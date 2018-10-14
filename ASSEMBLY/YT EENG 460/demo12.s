# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: PRINT INTEGER
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

Title:    .asciiz  "Print integer \n\n"    # \n == new line
CR:       .asciiz  "\n"
NT:       .asciiz  "Normal Termination \n"

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        #print name to console
        li $v0, 4
        la $a0, Title # load address
        syscall

        #load in the register number 1234
        li  $s0, 1234

        #print INTEGER
        li $v0, 1
        move $a0, $s0
        syscall

        #print name to console
        li $v0, 4
        la $a0, CR
        syscall
        #syscall
        #syscall

        #print name to console
        li $v0, 4
        la $a0, NT
        syscall

li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
