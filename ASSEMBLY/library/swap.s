# Title:   SWAP               Filename: swap
# Author: Leonardo Bitto      Date: 27\4\2018
# Description: takes a number in a vector and swap it with his follower
# Input: $a0 == address of an array in register
#        $a1 == index of the element to swap in register 
#
# Output: None
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

############ Code Segment #############
.text
.globl swap

      swap:
          #chiamata alla routine SWAP

          sll $t1, $a1, 2   # aggiusta indice per indirizzamento al BYTE
          add $t1, $a0, $t1 # calcola indirizzo assoluto nella macchina

          lw $t0, 0($t1)    # metti in t0 il primo valore
          lw $t2, 4($t1)    # metti in t2 il valore successivo

          sw $t0, 4($t1)    # metti il primo valore estratto nella posizione successiva
          sw $t2, 0($t1)    # metti il secondo valore estratto nella posizione del primo

          j $ra             # salta al registro contente il punto del programma interrotto
