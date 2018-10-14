# Title: Sensore di pendenza  Filename: Pendenzamodu.s
# Author: Leonardo Bitto                    Data: 17/5/18
# Description: legge in input un valore e verifica che questo
#              sia compreso nell'intervallo +60 ; -60
# Input:       una serie di valori
# Output:      un valore booleano in corrispondenza di ogni
#              valore 1 se il valore è compreso nell'intervallo,
#              0 se il valore non appartiene all' intervallo
############ Data Segment #############
.data
  bufferIN:   .space 350
  bufferOUT:  .space 250
  IN:   .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test IN/pendenzaIN.txt"  # file di input
  OUT:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test OUT/correttezzaPendenzaOUT.txt"# file di output

############ Code Segment #############
.text
.globl main

  main:

      # apri il file degli input (ottenere il descrittore del file in $v0)

      li $v0, 13        # codice del sistema operativo per aprire file txt
      la $a0, IN        # nome del file da caricare
      li $a1, 0         # flag per scrittura
      li $a2, 0         # flag per modalità
      syscall           # chiamata al sistema

      # leggi dal file appena aperto,
      # in pratica carica in memoria nel buffer
      # una porzione specificata del file in $a2

      move $a0, $v0     # metti nel parametro di entrata descrittore del file
      la $a1, bufferIN  # indirizzo del buffer da cui leggere
      li $a2, 500       # specifica la quantità di caratteri nel buffer
      li $v0, 14        # codice di chiamata per lettura
      syscall           # chiamata al sistema
      move $s7, $v0     # metti il descrittore del file nel registro s7
      li $v0, 0         # azzeramento di v0 in quanto usato successivamente

      li $s1, 0         # inizializzazione contatore bufferIN
      li $s2, 0         # inizializzazione contatore bufferOUT

      li $s4, 0x2d      # carica il valore esadecimale 0x2d in s4 (-)
      li $s5, 0x20      # carica il valore esadecimale 0x20 in s5 (spazio)

      # MONTAGGIO DEL
      # NUMERO CHE POI VERRÀ LETTO E GIUDICATO
       loop:
            lb $s0, bufferIN($s1)     # carica  il byte da esaminare
            beq $s0, $zero, FINE      # se questo equivale a zero allora si passa a FINE

      # CASE CHECK IL BYTE CARICATO SE SPAZIO SE SEGN NEG SE NUMERO

            # check se ha trovato uno spazio
            bne $s0, $s5, next      # se il byte caricato in s0 non è 20 vai a next
            jal pendenza              # chiamata al modulo condPendenza.s

            # conversione in ASCII del risultato e
            # scrittura nel bufferOUT
            addi $v0, $v0, 48         # ritrasforma in codice ASCII i valori 1 && 0
            sb $v0, bufferOUT($s2)    # metti il valore trovato nella posizione
                                      # a cui siamo arrivati nel bufferOUT
            addiu $s2, $s2, 1         # aumenta di 1 il contatore del bufferOUT
            sb $s5, bufferOUT($s2)    # aggiungi uno spazio, codice 20 in bufOUT
            addiu $s2, $s2, 1         # aumenta di 1 il contatore del bufferOUT

            # azzeramento registri
            li $a0, 0                 # conteneva il vecchio numero esaminato
            li $s6, 0                 # conteneva il flag negativo

            j continue
      next:
            # check if negativo
            bne $s0, $s4, labelnum   # se il byte è diverso dal segno negativo 0x2d
                                     # allora è un numero, vai a calcolarlo
            li $s6, 1                # flag per numero negativo
            j continue               # torna a loop

            #calcolo numero                                                 GESTIONE ERRORI
  labelnum: blt $s0, 48, continue    # controlla se il byte è un numero   | nel caso in cui non venga riconosciuto come numero
            bgt $s0, 57, continue    # deve essere compreso tra 48 e 57   | non viene implementata la gestione dell'errore
            addi $s0, $s0, -48       # converti il char ASCII in intero   | si passa al prossimo byte da esaminare
            mul $a0, $a0, 10         # moltiplica per 10 $a0 = $a0 * 10
            beq $s6, 1, negativo     # se il flag negativo è attivo (1)
                                     # allora esegui il calcolo come se fosse
                                     # un numero negativo sennò
            add $a0, $a0, $s0        # $a0 = $a0 * 10 + digit
            j continue               # e vai a continue
    negativo: sub $a0, $a0, $s0      # $a0 = $a0 * 10 - digit
    continue:
            addiu $s1, $s1, 1        # aumenta di 1 il contatore di bufferIN
            j loop
            # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
            # cosi che al prossimo spazio venga usato come
            # ingresso per la funzione pendenza
  FINE:

      # chiudi il file IN

      li $v0, 16
      move $a0, $s7
      syscall

      # apri il file OUT (ottenere il descrittore del file)

      li $v0, 13                # codice del sistema operativo per aprire file txt
      la $a0, OUT               # nome del file da caricare
      li $a1, 1                 # flag per scrittura
      li $a2, 0                 # flag per modalità
      syscall                   # chiamata al sistema

      # scrivi nel file appena aperto

      move $a0, $v0             # descrittore file di OUT
      li $v0, 15                # codice syscall per scrittura
      la $a1, bufferOUT         # indirizzo bufferOUT
      li $a2, 200               # quanti caratteri da scrivere
      syscall

      # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

      li $v0, 16
      syscall

      # chiudi SPIM

      li $v0, 10
      syscall
