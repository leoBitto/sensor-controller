# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: demo of printing a single precision floatng
#               point number representerde by IEEE754
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        title:         .asciiz "Demo program floating point\n\n"
        CR:            .asciiz "\n"
        EnterF_read:   .asciiz "enter floating point number:"
        EnterF_write:  .asciiz "you entered floating point number:"
        NT:            .asciiz "normal termination"

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        #print title
        li $v0, 4
        la $a0, title
        syscall

        #print prompt for reading
        li $v0, 4
        la $a0, EnterF_read
        syscall

        #read floating number in $f0
        li $v0, 6
        syscall

        #prompt for writing float point
        li $v0, 4
        la $a0, EnterF_write
        syscall

        # print floating to console
        mov.s   $f12, $f0
        li $v0, 2
        syscall

        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall

#END OF PROGRAM
li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
