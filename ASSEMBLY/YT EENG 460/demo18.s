# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: set less than
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
        li $s3,0x1
        li $s4,0x2
        slt $t0,$s3,$s4 #set t0 to 1 1<2

        li $s3,0x4
        li $s4,0x3
        slt $t0,$s3,$s4 #reset t0 to 0 4>3

        li $s3,0xFFFFFFFF
        li $s4,0x00000001
        slt $t0,$s3,$s4 # set less than con segno

        li $s3,0xFFFFFFFF
        li $s4,0x00000001
        sltu $t0,$s3,$s4 #ser less than senza segno

        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall


li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
