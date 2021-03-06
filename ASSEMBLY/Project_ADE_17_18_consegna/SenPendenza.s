# Title: Sensore di pendenza  Filename: Pendenzamodu.s
# Author: Leonardo Bitto                    Data: 18/5/18
# Description: legge in input un valore e verifica che questo
#              sia compreso nell'intervallo +60 ; -60
# Input:       una serie di valori
# Output:      un valore booleano in corrispondenza di ogni
#              valore 1 se il valore è compreso nell'intervallo,
#              0 se il valore non appartiene all' intervallo
############ Data Segment #############
.data

  INp:   .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/pendenzaIN.txt"                # file di input pendenza
  OUTp:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaPendenzaOUT.txt"   # file di output pendenza
  bufferOUTp: .space 250

############ Code Segment #############
.text
.globl SenPendenza

  SenPendenza:

      # apri il file degli input (ottenere il descrittore del file in $v0)

      li $v0, 13        # codice del sistema operativo per aprire file txt
      la $a0, INp        # nome del file da caricare
      li $a1, 0         # flag per scrittura
      li $a2, 0         # flag per modalità
      syscall           # chiamata al sistema

      # leggi dal file appena aperto,
      # in pratica carica in memoria
      # una porzione specificata del file

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

      li $s1, 0         # inizializzazione contatore bufferIN
      li $s2, 0         # inizializzazione contatore bufferOUT
      li $s6, 0x0a      # carica valore di fine buffer
      li $s7, 0x20      # carica il valore esadecimale 0x20 in t9 (spazio)

      # ALLOCAZIONE NELLO STACK DELL'INDIRIZZO DI RITORNO
      # a causa delle chiamate convertitore e condizione, gli indirizzi
      # di ritorno vengono modificati, è necessario quindi preservare
      # l'indirizzo di ritorno nello stack. le chiamate convertitore e condizione
      # soffrono di questo problema in quanto vengono chiamate in modo sequenziale

      addi $sp, $sp, -4
      sw $ra, 0($sp)

      # MONTAGGIO DEL
      # NUMERO CHE POI VERRÀ LETTO E GIUDICATO
       loop:
            add $a0, $s5, $s1
            lb $a0, ($a0)     # carica  il byte da esaminare
            beq $a0, $s6, FINE        # se questo equivale al terminatore 0x0a
                                      # allora si passa a FINE

      # CASE CHECK IL BYTE CARICATO SE SPAZIO SE SEGN NEG SE NUMERO

            # check se ha trovato uno spazio
            bne $a0, $s7, conv        # se il byte caricato in a0 non è 20 vai a conv

            move $a0, $v0             # metti come argomento di entrata l'uscita del
                                      # convertitore ASCII-numero
            jal pendenza              # chiamata al modulo condPendenza.s

            # conversione in ASCII del risultato e
            # scrittura nel bufferOUT
            addi $v0, $v0, 48         # ritrasforma in codice ASCII i valori 1 && 0
            sb $v0, bufferOUTp($s2)          # metti il valore trovato nella posizione
                                      # a cui siamo arrivati nel bufferOUT($s2)
            addiu $s2, $s2, 1         # aumenta di 1 il contatore del bufferOUT
            sb $s7, bufferOUTp($s2)          # aggiungi uno spazio, codice 20 in bufOUT($s2)
            addiu $s2, $s2, 1         # aumenta di 1 il contatore del bufferOUT

            # azzeramento registri
            # una volta calcolato il valore tutti registri che hanno
            # preso parte al suo calcolo devono essere resettati a zero
            add $v0, $zero, $zero     # conteneva un numero non più necessario
            add $a3, $zero, $zero     # conteneva il segno negativo
            add $t2, $zero, $zero     # conteneva numero d'appoggio per condizione di pendenza
            add $t3, $zero, $zero     # conteneva numero d'appoggio per condizione di pendenza
            add $t8, $zero, $zero     # conteneva un numero usato dal convertitore
            j continue

      conv: li $a2, 0
            jal converter
  continue: addiu $s1, $s1, 1         # aumenta di 1 il contatore di bufferIN
            j loop
            # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
            # cosi che al prossimo spazio venga usato come
            # ingresso per la funzione pendenza
  FINE:

      # apri il file OUT (ottenere il descrittore del file)

      li $v0, 13                # codice del sistema operativo per aprire file txt
      la $a0, OUTp               # nome del file da caricare
      li $a1, 1                 # flag per scrittura
      li $a2, 0                 # flag per modalità
      syscall                   # chiamata al sistema

      # scrivi nel file appena aperto

      move $a0, $v0             # descrittore file di OUT
      li $v0, 15                # codice syscall per scrittura
      la $a1, bufferOUTp        # indirizzo bufferOUT
      li $a2, 200               # quanti caratteri da scrivere
      syscall

      # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

      li $v0, 16
      syscall

      # RIPRISTINO DALLO STACK DELL'INDIRIZZO DI RITORNO E SALTO AL chiamante
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      la $v0, bufferOUTp
      jr $ra
