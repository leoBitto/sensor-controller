# Title:   Demo               Filename:
# Author: Leonardo Bitto      Date:
# Description: jump & link  & stack
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

        title:    .asciiz "Demo program\n\n"
        subtext:  .asciiz "subroutine!\n\n"
        CR:       .asciiz "\n"
        NT:       .asciiz "normal termination"
############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        li $v0, 4
        la $a0, title
        syscall

        addi $s0, $zero, 0
        addi $s1, $zero, 1
        addi $s2, $zero, 2
        addi $s3, $zero, 3
        addi $s4, $zero, 4
        addi $s5, $zero, 5
        addi $s6, $zero, 6
        addi $s7, $zero, 7

        jal sub1

        #Normal termination
        li $v0, 4
        la $a0, NT
        syscall


li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma


sub1: #aggiorna stack pointer
      addi $sp, $sp, -32

      #push
      sw $s0,28($sp)
      sw $s1,24($sp)
      sw $s2,20($sp)
      sw $s3,16($sp)
      sw $s4,12($sp)
      sw $s5, 8($sp)
      sw $s6, 4($sp)
      sw $s7, 0($sp)

      li $v0, 4
      la $a0, subtext
      syscall

      #change values
      addi $s0, $zero, -1
      addi $s1, $zero, -1
      addi $s2, $zero, -1
      addi $s3, $zero, -1
      addi $s4, $zero, -1
      addi $s5, $zero, -1
      addi $s6, $zero, -1
      addi $s7, $zero, -1

      #pop
      lw $s7,  0($sp)
      lw $s6,  4($sp)
      lw $s5,  8($sp)
      lw $s4, 12($sp)
      lw $s3, 16($sp)
      lw $s2, 20($sp)
      lw $s1, 24($sp)
      lw $s0, 28($sp)

      # riaggiorna stack pointer
      addi $sp, $sp, 32

      # RITORNO AL CHIAMANTE
      jal $ra
