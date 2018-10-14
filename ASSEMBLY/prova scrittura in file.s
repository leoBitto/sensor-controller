# Title:                      Filename:
# Author: Leonardo Bitto      Data:
# Description:
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

buffer: .space 20
OUT:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test OUT/correttezzaPendenzaOUT.txt"# file di output

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:

          li $t0, 23
          li $t1, 43
          li $t2, 52
          li $t3, 11
          li $s0, 0

          sb $t0, buffer($s0)
          addiu $s0, $s0, 1
          sb $t1, buffer($s0)
          addiu $s0, $s0, 1
          sb $t2, buffer($s0)
          addiu $s0, $s0, 1
          sb $t3, buffer($s0)

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
          li $a2, 500               # quanti caratteri da scrivere
          syscall

          # chiudi il file OUT

          li $v0, 16
          move $a0, $t7
          syscall

          # chiudi SPIM

          li $v0, 10
          syscall








li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
