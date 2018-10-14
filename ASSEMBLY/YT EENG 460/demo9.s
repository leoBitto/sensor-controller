# Title:   Demo               Filename:
# Author: Leonardo Bitto      Data:
# Description: ASCII IN MEMORY
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

a1:     .ascii  "123"
a2:     .ascii  "5"
a3:     .ascii  "4"
name:   .ascii  "Leonardo"
course: .ascii  "computer science"


############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:



li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
