# Title:   Demo               Filename:
# Author: Leonardo Bitto      Data:
# Description: subtraction registers
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali




############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:

      #positive result
      li $t1,0x2222   #load immediate
      li $t2,0x1111   #load immediate
      sub $t3, $t1, $t2

      li $t1,0xFFFF   #load immediate
      li $t2,0x0001   #load immediate
      sub $t3, $t1, $t2

      li $t1,0x7FFFFFFF   #load immediate
      li $t2,0x00000001   #load immediate
      sub $t3, $t1, $t2

      #negative result (2' complement)
      li $t1,0x1111   #load  4369
      li $t2,0x2222   #load 8738
      sub $t3, $t1, $t2 #=-4369

      li $t1,0x0001   #load 1
      li $t2,0xFFFF   #load 65535
      sub $t3, $t1, $t2 # = -65534

      li $t1,0x00000001   #load 1
      li $t2,0xFFFFFFFF   #load -1
      sub $t3, $t1, $t2   # = 2

      li $t1,0xFFFFFFFF   #load -1
      li $t2,0xFFFFFFFE   #load -2
      sub $t3, $t1, $t2   # = 1

li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
