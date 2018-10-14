# Title: Sensore di sterzo  Filename: Sterzo.s
# Author: Leonardo Bitto    Data: 22/5/18
# Description: legge in input un valore e verifica che la differenza
#              tra questo e il successivo sia minore di 10
# Input:       una serie di valori
# Output:      un valore booleano in corrispondenza di ogni
#              valore 1 se il valore è compreso nell'intervallo,
#              0 se il valore non appartiene all' intervallo
############ Data Segment #############
.data

  INs:   .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test IN/sterzoIN.txt"                  # file di input sterzo
  OUTs:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test OUT/correttezzaSterzoOUT.txt"     # file di output sterzo
  bufferOUTs: .space 250

############ Code Segment #############
.text
.globl SenSterzo

  SenSterzo:

      # apri il file degli input (ottenere il descrittore del file in $v0)

      li $v0, 13        # codice del sistema operativo per aprire file txt
      la $a0, INs        # nome del file da caricare
      li $a1, 0         # flag per scrittura
      li $a2, 0         # flag per modalità
      syscall           # chiamata al sistema

      # leggi dal file appena aperto,
      # in pratica carica in memoria nel buffer
      # una porzione specificata del file in $a2

      move $a0, $v0     # metti nel parametro di entrata descrittore del file
                        # indirizzo del buffer in cui copiare il file di testo
      move $a1, $s5       # viene specificato dalla funzione chiamante come parametro di ingresso in s5
      li $a2, 500       # specifica la quantità di caratteri nel buffer
      li $v0, 14        # codice di chiamata per lettura
      syscall           # chiamata al sistema

      # chiudi il file IN
      move $a0, $v0
      li $v0, 16
      syscall

      li $v0, 0         # azzeramento di v0 in quanto usato successivamente
      li $a0, 0         # azzeramento di a0 in quanto usato successivamente contiene s(t)
      li $a1, 0         # azzeramento di a1 in quanto usato successivamente contiene s(t-1)

      li $s2, 0         # inizializzazione contatore bufferIN
      li $s3, 0         # inizializzazione contatore bufferOUT
      li $s6, 0x0a      # terminatore bufferIN
      li $s7, 0x20      # carica il valore esadecimale 0x20 in s5 (spazio)

      # ALLOCAZIONE NELLO STACK DELL'INDIRIZZO DI RITORNO
      # a causa delle chiamate convertitore e condizione, gli indirizzi
      # di ritorno vengono modificati, è necessario quindi preservare
      # l'indirizzo di ritorno nello stack. le chiamate convertitore e condizione
      # soffrono di questo problema in quanto vengono chiamate in modo sequenziale

      addi $sp, $sp, -4
      sw $ra, 0($sp)

      # dato che si deve calcolare la differenza tra un valore e il suo precedente
      # è necessario calcolare il primo numero prima di entrare nel loop che calcola
      # il prossimo numero calcolare per ogni coppia se la differenza è minore di 10 (1)
      # oppure maggiore di 10 (0)
      add $a1, $s5, $s2
      lb $a1, ($a1)
      blt $a1, 48, continue    # controlla se il byte è un numero   | nel caso in cui non venga riconosciuto come numero
      bgt $a1, 57, continue    # deve essere compreso tra 48 e 57   | non viene implementata la gestione dell'errore
      addi $a1, $a1, -48       # converti il char ASCII in intero   | si passa al prossimo byte da esaminare
      addi $s2, $s2, 1         # aggiungi uno al contatore di bufferIN
      add $t5, $s5, $s2
      lb $t5, ($t5)            # carica byte successivo
      beq $t5, $s5, continue   # se il carattere è uguale a uno spazio vai a continue
      blt $t5, 48, continue    # controlla se il byte è un numero   | nel caso in cui non venga riconosciuto come numero
      bgt $t5, 57, continue    # deve essere compreso tra 48 e 57   | non viene implementata la gestione dell'errore
      addi $t5, $t5, -48       # converti il char ASCII in intero   | si passa al prossimo byte da esaminare
      mul $a1, $a1, 10         # moltiplica per 10 $a1 = $a1 * 10
      add $a1, $a1, $t5        # $a1 = $a1 + digit
      addi $s2, $s2, 2         # aggiungi due al contatore di bufferIN
      add $t5, $zero, $zero    # $t5 = 0 ripulisce variabile

      loop:
            add $a0, $s5, $s2
            lb $a0, ($a0)     # carica  il byte da esaminare
            beq $a0, $s6, FINE        # se questo equivale al terminatore del bufferIN
                                      # 0x0a allora si passa a FINE

            # check se ha trovato uno spazio
            bne $a0, $s7, conv        # se il byte caricato in s0 non è 20 vai a next

            move $a0, $v0        # sposta da v0 dove è stato messo l'ultimo
                                 # numero calcolato, in a0 e chiama la funzione
                                 # che implementa la condizione di funzionamento
                                 # dell sterzo
            jal sterzo                # chiamata al modulo condSterzo.s

            # conversione in ASCII del risultato e
            # scrittura nel bufferOUT
            addi $v0, $v0, 48         # ritrasforma in codice ASCII i valori 1 && 0
            sb $v0, bufferOUTs($s3)    # metti il valore trovato nella posizione
                                      # a cui siamo arrivati nel bufferOUT
            addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT
            sb $s7, bufferOUTs($s3)    # aggiungi uno spazio, codice 20 in bufOUT
            addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT

            # spostamento registro $a0 in $a1
            move $a1, $a0             # conteneva il vecchio numero esaminato
            add $a0, $zero, $zero     # imposta a zero $a0
            add $v0, $zero, $zero     # conteneva un numero non piu necessario
            add $t3, $zero, $zero     # il registro conteneva un numero usato temporaneamente
                                      # dalla condizione di sterzo
            add $t8, $zero, $zero     # conteneva un numero di appoggio per il converter

            #calcolo numero
            j continue
      conv: li $a2, 0
            jal converter
  continue: addiu $s2, $s2, 1        # aumenta di 1 il contatore di bufferIN
            j loop
            # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
            # cosi che al prossimo spazio venga usato come
            # ingresso per la funzione sterzo
  FINE:

      # apri il file OUT (ottenere il descrittore del file)

      li $v0, 13                # codice del sistema operativo per aprire file txt
      la $a0, OUTs               # nome del file da caricare
      li $a1, 1                 # flag per scrittura
      li $a2, 0                 # flag per modalità
      syscall                   # chiamata al sistema

      # scrivi nel file appena aperto

      move $a0, $v0             # descrittore file di OUT
      li $v0, 15                # codice syscall per scrittura
      la $a1, bufferOUTs        # indirizzo bufferOUT
      li $a2, 198               # quanti caratteri da scrivere
      syscall

      # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

      li $v0, 16
      syscall

      # RIPRISTINO DALLO STACK DELL'INDIRIZZO DI RITORNO E SALTO AL chiamante
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      la $v0, bufferOUTs
      jr $ra
