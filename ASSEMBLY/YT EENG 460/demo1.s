# Title:   Demo               Filename:
# Author: Leonardo Bitto      Data:
# Description:
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali




############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
      #load some registers
      li $t0,0x0   #load immediate
      li $t1,0x1   #load immediate
      li $t2,0x2   #load immediate
      li $t3,0x3   #load immediate
      li $t4,0x4   #load immediate
      li $t5,0x5   #load immediate
      li $t6,0x6   #load immediate
      li $t7,0x7   #load immediate
      li $t8,0x8   #load immediate
      li $t9,0x9   #load immediate









li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
