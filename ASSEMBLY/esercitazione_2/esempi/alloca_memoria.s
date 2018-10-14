.data

string0: .asciiz "\n\nPermette di inserire un numero e lo memorizza in un'area di memoria allocata dinamicamente"
string1: .asciiz "\n\nInserire un numero\n"
string2: .asciiz "\nNumero inserito "

.text        
.globl main

main:                 	# etichetta main  
li $v0, 4
la $a0, string0
syscall               	# stampa string0

li $v0, 4			# inserisco il numero
la $a0, string1
syscall                 # stampa string1

li $v0, 5
syscall 		      # legge un intero

move $t1 $v0        	# sposta in $t1 l'intero letto
					
li $v0, 9			# codice syscall SBRK
li $a0, 4			# numero di byte da allocare
syscall                 # chiamata sbrk: restituisce un blocco di 4 byte, puntato da v0: il nuovo record
			
sw $t1, 0($v0)          # memorizza il contenuto di $t1 nella nuova area di memoria
move $t2, $v0		# $t2 = $v0 = puntatore alla nuova area di memoria

li $v0, 4
la $a0, string2
syscall               	# stampa string2

li $v0, 1
lw $a0, 0($t2)
syscall			# stampa l'intero inserito nella nuova area di memoria

jr $ra