# Title:   Demo               Filename:
# Author: Leonardo Bitto      Data:
# Description: ASCIIZ IN MEMORY
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

a1:     .asciiz  "123"
a2:     .asciiz "5"
a3:     .asciiz  "4"
name:   .asciiz  "Leonardo"
course: .asciiz  "computer science"

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:



li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
