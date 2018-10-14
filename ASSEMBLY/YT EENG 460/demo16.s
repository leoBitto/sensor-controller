# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: and or nor
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        title:   .asciiz "Logical demo program\n\n"
        NT:       .asciiz "normal termination"
############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $v0, 4
        la $a0, title
        syscall

        li $t2, 0x5555aaaa # 5=0101
        li $t3, 0xaaaa5555 # a=1010

        and $t4,$t2,$t1   # dato che non hanno bits in comune la loro
                          #somma logica è zero

        or  $t5, $t2, $t3 # dato che si alernano gli 1 e 0 nelle
                          # rappresentazioni di a e 5 il prodotto logico
                          #è uguale a 32 uno che corrisponde a 0xffffffff

        andi $t6,$t2,0x00FF #immediate usa solo 16 bit per l'argomento
                            # i 16 bit iniziali di un indirizzo vengono
                            #rimpiazzati con l'argomento,
                            #il risultato è messo nel primo registro

        ori  $t7,$t2,0xFF00 # ori  usa ancora 16 bit ma questi vengono
                            #messi nei 16 bit finali di una stringa
                            #il risultato viene salvato nel primo registro

        nor $t8,$t6,$t7      # nor = not + or

        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall


li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
