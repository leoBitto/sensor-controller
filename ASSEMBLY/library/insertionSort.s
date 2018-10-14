# Title:   insertion Sort     Filename: insertionSort
# Author: Leonardo Bitto      Data: 27\4\2018
# Description: implementazione in assembly MIPS dell'algoritmo
#               di ordinamento insertion sort
# Input: address of the first element of the array to order
#         and length of array
# Output:
############ Data Segment #############
.data
  Array: .word 2, 15, 7, 28, 17, 23, 11, 5, 9, 0


############ Code Segment #############
.text
.globl main

  main:
      # addi $sp, $sp, -20
      # sw $ra, 16($sp)
      # sw $s3, 12($sp)
      # sw $s2, 8($sp)
      # sw $s1, 4($sp)
      # sw $s0, 0($sp)

      li $a1, 10          # a1 == numero di elementi
      li $a0, 0x10010000  # a0 == posizione iniziale dell'array
      move $s0, $zero   #  $s0 => i==0
      ciclo1:
      #condizione di uscita ciclo1
        slt $t0, $s0, $a1 # se il contatore i è minore del
                          # numero n di elementi da ordinare
                          # metti in t0 il valore 1 in caso
                          # contrario  metti 0

        beq $t0, $zero, esci1 # se t0 == zero allora vai a esci

        addi $s1, $s0, -1   # j= i-1

        ciclo2:
          #condizione di uscita ciclo2 {j>=0}
          slti $t0, $s1, 0
          bne $t0, $zero, esci2
          #seconda condizione di uscita ciclo2 {v[j]>v[j+1]}
          sll $t1, $s1, 2         # $t1 = j*4
          add $t2, $a0, $t1       # $t2 = v + $t1
          lw $t3, 0($t2)          # $t3 => v[j]
          lw $t4, 4($t2)          # $t4 => v[j+1]
          slt $t0, $t4, $t3       # $t4>$t3 \\ v[j]>v[j+1]
          beq $t0, $zero, esci2


          move $a1, $s1
          jal swap

          addi $s1, $s1, -1  #  j-=1
          j ciclo2

      esci2:
        addi $s0, $s0, 1  #  i+=1
        j ciclo1

      esci1:
            # lw $s0, 0($sp)
            # lw $s1, 4($sp)
            # lw $s2, 8($sp)
            # lw $s3, 12($sp)
            # lw $ra, 16($sp)
            # addi $sp, $sp, 20

            li $v0, 10
            syscall


      #jr $ra
