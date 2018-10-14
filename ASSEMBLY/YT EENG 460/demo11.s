# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: PRINT STRING
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

Name:     .asciiz  "Leonardo Bitto \n\n"    # \n == new line
Course:   .asciiz  "Computer science"
CR:       .asciiz  "\n"
Date:     .asciiz  "MM\DD\YYYY\n\n"
NT:       .asciiz  "Normal Termination \n"

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        #print name to console
        li $v0, 4
        la $a0, Name
        syscall

        #print name to console
        li $v0, 4
        la $a0, Course
        syscall

        #print name to console
        li $v0, 4
        la $a0, CR
        syscall

        #print name to console
        li $v0, 4
        la $a0, Date
        syscall

        #print name to console
        li $v0, 4
        la $a0, NT
        syscall

li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
