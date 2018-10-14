# Title: Farheneit to Celsius Filename: farhToCels
# Author: Leonardo Bitto      Data: 2\5\18
# Description: convertitore MIPS da Farheneit a celsius
# Input: gradi in Farheneit passati in $f12
# Output: gradi in Celsius nel registro $f0

# CODICE IN C
#    float f2c (float fahr){

#           return ((5,0/9,0) * (fahr - 32,0));

#    }
############ Data Segment #############
.data




############ Code Segment #############
.text
.globl f2c
  f2c:
    l.s $f16, 5  #carica la costante 5 in $f16
    l.s $f18, 9  #carica la costante 9 in $f18
    div.s $f16, $f16, $f18 # $f16 = $f16 + $f18

    lwc1 $f18, cost32($gp) #carica la costante 32 in $f18
    sub.s $f18, $f12, $f18 # $f18 = fahr - 32,0

    mul.s $f0, $f16, $f18  # $f0 = (5/9)*(fahr-32)
    jr $ra                 # ritorna









li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
