.data
	string0: .asciiz "\n\n Inserire un carattere:\n  "
      string1: .asciiz "\n\n Carattere inserito:\n  "
	string2: .asciiz "\n\n uguale a b\n  "		
	string3: .asciiz "\n\n diverso da b\n  "

.text
.globl main 

main:

la $a0, string0 		# stampa string0	
li $v0, 4 		
syscall 		


li $v0, 12 			# codice leggi carattere = 12
syscall 			# legge il carattere e lo mette in $v0

move $t0, $v0   		# sposta il carattere in $t0

la $a0, string1 		# stampa string1
li $v0, 4
syscall

move $a0, $t0   		# stampa il carattere
li $v0, 11
syscall

li $t1, 'b'
beq $t0, $t1, uguale

la $a0, string3 		# stampa string3
li $v0, 4
syscall
j esci

uguale:
la $a0, string2 		# stampa string2
li $v0, 4
syscall

esci:
li $v0,10			# esce
syscall		 