# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: BRANCHING & LOOPs
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        title:   .asciiz "Logical demo program\n\n"
        NT:       .asciiz "normal termination"
############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $t0 , 5
    L1:   addi $t0, $t0, -1           #L1
          nop
          nop     #body of loop
          nop
          bne $t0,$zero, L1

        li $t0, 0
        li $t1, 5
    L2:   addi $t0, $t0, 1           #L2
          nop
          nop     #body of loop
          nop
          bne $t0,$t1, L2


        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall


li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
