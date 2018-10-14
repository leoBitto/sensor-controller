# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: load e store byte
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        title:    .asciiz "Demo program\n\n"
        NT:       .asciiz "normal termination"
############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $s0,0x10010000

        lb  $t0, 0x00($s0) #load byte
        lb  $t1, 0x01($s0)
        lb  $t2, 0x02($s0)
        lb  $t3, 0x03($s0)

        li $s1,0x10010030

        sb  $t0, 0($s1) #store byte
        sb  $t1, 1($s1)
        sb  $t2, 2($s1)
        sb  $t3, 3($s1)


        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall


li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
