# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: STORE WORD
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $s0, 0x10010000
        li $t0, 0x30
        sw $t0, 0($s0)
        #the following will cause an error
        #sw $t0, 1($s0)
        #sw $t0, 2($s0)
        #sw $t0, 3($s0)

        li $t0, 0x12345678
        sw $t0, 4($s0)

        li $t0, 0xA5A5A5A5
        sw $t0, 8($s0)

        addi $t0, $t0, 1
        sw $t0, 12($s0)

li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
