# Title:   Demo               Filename:
# Author: Leonardo Bitto      Data:
# Description: adding registers
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali




############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:

      #load some registers numeri esadecimali a 16bit
      li $t1,0x1111   #load immediate
      li $t2,0x2222   #load immediate
      add $t3, $t1, $t2

      li $t1,0x0000FFFF   #load immediate
      li $t2,0x00000001   #load immediate
      add $t3, $t1, $t2



li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
