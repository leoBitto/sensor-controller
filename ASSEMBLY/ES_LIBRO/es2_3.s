# Title: esercitazione        Filename:es2.3
# Author: Leonardo Bitto      Data: 24 apr 2018
# Description:assegna un valore di un vettore nella 8 posizione di un altro vettore
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale
main:
    subi $t0, $s3,$s4 #sottrai j a i e metti risultato in t0 t0=i-j
    sll $t0, 2        #calcola offset al byte t0*4
    lw $t0,$t0($s6)   #carica la parola in t0 di A[]
    li $t1, 8         #metti 8 nel registro t1
    sll $t1, 2        #calcola offset al byte 8*2
    sw $t0, $t1($s7)  #metti il valore t0(A[i-j]) in B[8]




li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
