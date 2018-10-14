# Title: Sensore di pendenza  Filename: pendenza.s
# Author: Leonardo Bitto      Data: 13/5/2018
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

      # apri il file degli input (ottenere il descrittore del file)

      li $v0, 13        # codice del sistema operativo per aprire file txt
      la $a0, IN        # nome del file da caricare
      li $a1, 0         # flag per scrittura
      li $a2, 0         # flag per modalità
      syscall           # chiamata al sistema
      move $t7, $v0     # sposta il descrittore del file

      # leggi dal file appena aperto
      # in pratica carica in memoria nel buffer
      # una porzione specificata del file in $a2

      li $v0, 14        # codice di chiamata per lettura
      move $a0, $t7     # metti nel parametro di entrata descrittore del file
      la $a1, bufferIN  # indirizzo del buffer da cui leggere
      li $a2, 500       # specifica la quantità di caratteri nel buffer
      syscall           # letti


      li $s1, 0         # inizializzazione contatore bufferIN
      li $s3, 0         # inizializzazione contatore bufferOUT
      li $s5, 0x20      # carica il valore esadecimale 0x20 in s5
      li $s4, 0x2d      # carica il valore esadecimale 0x2d in s4

      # MONTAGGIO DEL
      # NUMERO CHE POI VERRÀ LETTO E GIUDICATO
       loop:
            lb $t0, bufferIN($s1)     # carica  il byte da esaminare
            beq $t0, $zero, FINE      # se questo equivale a zero allora si passa a FINE

      # CASE CHECK IL BYTE CARICATO SE SPAZIO SE SEGN NEG SE NUMERO

            # check se ha trovato uno spazio
            beq $t0, $s5, scrivi     # se il byte caricato in t0 è 20 vai a scrivi

            # check if negativo
            bne $t0, $s4, labelnum   # se il byte è diverso dal segno negativo
                                     # allora è un numero, vai a calcolarlo
            li $t9, 1                # flag per numero negativo
            j continue               # torna a loop

            #calcolo numero
  labelnum: blt $t0, 48, continue    # controlla se il byte è un numero
            bgt $t0, 57, continue    # deve essere compreso tra 48 e 57
            addi $t6, $t0, -48       # converti il char ASCII in intero
            mul $v1, $v1, 10         # moltiplica per 10 $v1 = $v1 * 10
            beq $t9, 1, negativo     # se il flag negativo è attivo (1)
                                     # allora esegui il calcolo come se fosse
                                     # un numero negativo sennò
            add $v1, $v1, $t6        # $v1 = $v1 * 10 + digit
            j continue               # e vai a continue
  negativo: sub $v1, $v1, $t6
  continue:
            addiu $s1, $s1, 1        # aumenta di 1 il contatore di bufferIN
            j loop

      # IL NUMERO VERRÀ RESTITUITO IN $v1

      # PARTE DI CONTROLLO SE IL NUMERO CORRISPONDE
      # ALL'INTERVALLO +60 -60 E SCRITTURA NEL bufferOUT
      # viene elaborato da una funzione esterna
      # in a0 viene messo
      scrivi:
          li $t1, 60                # imposta $t1 al limite massimo
          li $t2, -60               # imposta $t2 al limite minimo

          slt $t3, $t2, $v1         # imposta a 1 $t3 se $t2 < $v1
          slt $t4, $v1, $t1         # imposta a 1 $t4 se $v1 < $t1

          and $t3, $t3, $t4         # and logico tra i due registri $t3 & $t4
                                    # imposta $t3 a 1 se $t2 < $v1 < $t1

          addi $t3, $t3, 48         # ritrasforma in codice ASCII i valori 1 && 0
          sb $t3, bufferOUT($s3)    # metti il valore trovato nella posizione
                                    # a cui siamo arrivati nel bufferOUT
          addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT
          sb $s5, bufferOUT($s3)    # aggiungi uno spazio, codice 20 in bufOUT
          addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT

          # flush registri
          li $v1, 0                 # conteneva il vecchio numero esaminato
          li $t9, 0                 # conteneva il flag negativo

          j continue

      FINE:
          # chiudi il file IN

          li $v0, 16
          move $a0, $t7
          syscall

          # apri il file OUT (ottenere il descrittore del file)

          li $v0, 13                # codice del sistema operativo per aprire file txt
          la $a0, OUT               # nome del file da caricare
          li $a1, 1                 # flag per scrittura
          li $a2, 0                 # flag per modalità
          syscall                   # chiamata al sistema
          move $t7, $v0             # sposta il descrittore del file in t7

          # scrivi nel file appena aperto

          li $v0, 15                # codice syscall
          move $a0, $t7             # descrittore file di OUT
          la $a1, bufferOUT         # indirizzo bufferOUT
          li $a2, 200               # quanti caratteri da scrivere
          syscall

          # chiudi il file OUT

          li $v0, 16
          move $a0, $t7
          syscall

          # chiudi SPIM

          li $v0, 10
          syscall
