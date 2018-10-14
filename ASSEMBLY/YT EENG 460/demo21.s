# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: load half word
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        test:     .asciiz "0123456789ABCDEF"
        title:    .asciiz "Demo program\n\n"
        CR:       .asciiz "\n"
        NT:       .asciiz "normal termination"

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $v0, 4
        la $a0, title
        syscall

        li $s0, 0x10010000

        #loading half-word from mem to reg

        lhu $t0, 0x00($s0)
      #  lhu $t1, 0x01($s0)  #ERROR offset mest be
        lhu $t1, 0x02($s0)    # multiple of 2, not of 4
        lhu $t2, 0x04($s0)    # because of the half word
        lhu $t3, 0x06($s0)    # works with 16 bit
        lhu $t4, 0x08($s0)
        lhu $t5, 0x10($s0)
        lhu $t6, 0x12($s0)
        lhu $t7, 0x14($s0)
        lhu $t8, 0x16($s0)

        li $s1, 0x10020000

        # storing half-word from reg to mem

        sh $t0, 0($s1)
      #  sh $t1, 1($s1) #ERROR
        sh $t1, 2($s1)
        sh $t2, 4($s1)
        sh $t3, 6($s1)
        sh $t4, 8($s1)
        sh $t5, 10($s1)
        sh $t6, 12($s1)
        sh $t7, 14($s1)
        sh $t8, 16($s1)

        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall

#END OF PROGRAM
li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
