# Title:   SWAP               Filename: swap
# Author: Leonardo Bitto      Date: 27\4\2018
# Description: takes a number in a vector and swap it with his follower
# Input: address of an array and index of the element to swap
# Output: None
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        title:         .asciiz " SWAP\n\n"
        CR:            .asciiz "\n"
        EnterF_read:   .asciiz "enter floating point number:"
        EnterF_write:  .asciiz "you entered floating point number:"
        NT:            .asciiz "normal termination"

############ Code Segment #############
.text
.globl main

      main:
            #print title
            li $v0, 4
            la $a0, title
            syscall

            # CREAZIONE ARRAY una word per ogni valore
            # si usa il global pointer per indirizzare la memoria
            # dello heap, che contiene i dati dinamicamente
            # allocati in memoria durante l'esecuzione del programma

            li $t0, 0x01
            sw $t0, 0($gp)

            li $t0, 0x02
            sw $t0, 4($gp)

            li $t0, 0x03
            sw $t0, 8($gp)

            li $t0, 0x04
            sw $t0, 12($gp)

            li $t0, 0x05
            sw $t0, 16($gp)

            li $t0, 0x06
            sw $t0, 20($gp)

            #chiamata alla routine SWAP

            move $a0, $gp # metti il valore del global pointer
                          # nel registro usato dalle funzioni chiamate
            li $a1, 3
            jal swap


            #Normal termination
            li $v0, 4
            la $a0, NT
            syscall

  #END OF PROGRAM
  li $v0, 10  #metti in $v0 il valore 10 e chiama
  syscall     #syscall per finire l'esecuzione del programma

  # l'indice in MIPS come in tutti i linguaggi è un offset che
  # permette di avere un indirizzo relativo al primo elemento
  # in MIPS per ottenere un indirizzo assoluto richiesto dalla macchina
  # dobbiamo sommare l'indirizzo relativo all'indirizzo del primo elemento
  # in modo esplicito ricordandoci che si indirizza al BYTE

    #SWAP ROUTINE
    # $a0 contiene l'indirizzo del global pointer
    # $a1 contiene l'indice dell'elemento che si vuole scambiare


        swap:
            sll $t1, $a1, 2   # aggiusta indice per indirizzamento al BYTE
            add $t1, $a0, $t1 # calcola indirizzo assoluto nella macchina

            lw $t0, 0($t1)    # metti in t0 il primo valore
            lw $t2, 4($t1)    # metti in t2 il valore successivo

            sw $t0, 4($t1)    # metti il primo valore estratto nella posizione successiva
            sw $t2, 0($t1)    # metti il secondo valore estratto nella posizione del primo

            j $ra             # salta al registro contente il punto del programma interrotto
