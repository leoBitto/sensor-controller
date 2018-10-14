# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: SHIFTING
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $t0, 0xFFFFFFFF
        sll $t0, $t0, 1 #shift left logical
        sll $t0, $t0, 1 # questa operazione
        sll $t0, $t0, 1 # moltiplica il valore
        sll $t0, $t0, 1 # nel registro di 2^i con
        sll $t0, $t0, 1 # i= al numero passato in
        sll $t0, $t0, 1 # questo caso 1
        sll $t0, $t0, 1
        sll $t0, $t0, 1

        li $t1, 0xFFFFFFFF
        srl $t1, $t1, 1 #shift right logical
        srl $t1, $t1, 1 # stesso discorso di sll
        srl $t1, $t1, 1 # ma in questo caso si
        srl $t1, $t1, 1 # divide
        srl $t1, $t1, 1
        srl $t1, $t1, 1
        srl $t1, $t1, 1
        srl $t1, $t1, 1


li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
