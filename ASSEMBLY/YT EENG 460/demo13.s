# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: LOAD WORD
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

TEMP:    .ascii  "123456789ABCDEF"    # \n == new line


############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $s0, 0x10010000
        lw $t0, 0($s0)

        #load word usa un indirizzamento al byte quindi
        # l'offset deve essere un multiplo di 4 in modo
        # tale da essere allineato al byte, i seguenti
        # esempi non funzionano
        #lw $t0, 1($s0)
        #lw $t0, 2($s0)
        #lw $t0, 3($s0)

        lw $t1, 4($s0)
        lw $t2, 8($s0)
        lw $t3, 12($s0)
        lw $t4, 0x0c($s0)
        #l'offset può essere espresso con valore decimale
        #oppure con valore esadecimale, l'ultima istruzione
        #ha lo stesso significato della precedente 0x0c=12

li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
