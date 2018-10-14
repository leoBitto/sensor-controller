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
      #load some registers con numeri interi in esadecimale
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

      #load some registers numeri esadecimali a 16bit
      li $t0,0x0000   #load immediate
      li $t1,0x1111   #load immediate
      li $t2,0x2222   #load immediate
      li $t3,0x3333   #load immediate
      li $t4,0x4444   #load immediate
      li $t5,0x5555   #load immediate
      li $t6,0x6666   #load immediate
      li $t7,0x7777   #load immediate
      li $t8,0x8888   #load immediate
      li $t9,0x9999   #load immediate

      #load some registers numeri esadecimali a 32 bit
      li $t0,0x00000000   #load immediate
      li $t1,0x11111111   #load immediate
      li $t2,0x22222222   #load immediate
      li $t3,0x33333333   #load immediate
      li $t4,0x44444444   #load immediate
      li $t5,0x55555555   #load immediate
      li $t6,0x66666666   #load immediate
      li $t7,0x77777777   #load immediate
      li $t8,0x88888888   #load immediate
      li $t9,0x99999999   #load immediate
      #carica nel registro temporaneo 9 un numero piu grande di 32 bit
      li $t9,0x123456789   #load immediate troppe cifre esadecimali (8 max)
      #ignora una parte del valore non mette l'1 nei sistemi BIG endian
      #mentre nei sistemi little endian elimina il 9






li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
