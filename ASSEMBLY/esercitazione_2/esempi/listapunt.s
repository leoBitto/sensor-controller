.data
string:   .asciiz "** Richiede in input una serie di interi, terminata da 0,\nli memorizza in una lista implementata con puntatori e li stampa **\n\n"
message:  .asciiz "Prossimo elemento?\n"
spazio:   .asciiz " "
fine:	  .asciiz "\n*Fine*"

.text   
.globl main     

main:                 		# etichetta main  

li $v0, 4
la $a0, string
syscall               		# stampa messaggio di benvenuto

move $t8 $zero	    		# t8 (= Testa) = 0
move $t9 $zero	    		# t9 (= Coda ) = 0

inputloop:                    # inizio loop di input; 
li $v0, 4
la $a0, message
syscall                       # stampa messaggio

li $v0, 5
syscall                       # legge un intero
beq $v0, $zero, print           # se l'intero letto e' zero, salta a routine print (stampa)
move $t1 $v0                  # altrimenti t1=input

					# inizio inserzione nuovo elemento
li $v0, 9
li $a0, 8
syscall                      	# chiamata sbrk: restituisce un blocco di 8 byte, puntato da v0: il nuovo record
				# vegono riempiti i due campi del nuovo record:
sw $t1, 0($v0)              	# campo intero = t1
sw $zero, 4($v0)              	# campo elemento-successivo = nil

bne $t8, $zero, link_last       	# se t8!=nil (coda non vuota) vai a link_last
move $t8, $v0                 	# altrimenti (prima inserzione)  Testa=Coda=v0
move $t9, $v0

j inputloop                  	# torna all'inizio del loop di input


link_last:                    # se la coda e' non vuota, collega l'ultimo elemento della lista,
					# puntato da Coda (t9) al nuovo record; dopodiche' modifica Coda 
					# per farlo puntare al nuovo record
sw $v0, 4($t9)                	# il campo elemento successivo dell'ultimo del record prende v0
move $t9, $v0                 	# Coda = v0
j inputloop                  	# salta all'inizio del loop


print:                       	# loop di stampa di tutti gli elementi della coda, separati da spazi

move $t0, $t8			# t0 = Testa. t0 verra' usato come puntatore per scorrere gli elementi della lista

loop_print:
beq $t0, $zero, exit		# se  t0 == 0 si e' raggiunta la fine della lista e si esce
li $v0, 1				# altrimenti si stampa l'elemento corrente. Cioe':
lw $a0, 0($t0)			# a0 = valore del campo intero dell'elemento corrente (puntato da t0)
syscall				# stampa valore intero dell'elemento corrente
li $v0, 4
la $a0, spazio			
syscall				# stampa spazio
lw $t0, 4($t0)			# t0 = valore del campo elemento-successivo dell'elemento corrente (puntato da t0)
j loop_print			# salta all'inizio del ciclo di stampa

exit:
jr $ra
