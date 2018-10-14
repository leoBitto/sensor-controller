.data
   str1:.asciiz "Selezione: 1\n\n"    
   str2:.asciiz "Selezione: 2\n\n"    
   str3:.asciiz "Selezione: 3\n\n"    
   inserimento:.asciiz "Inserisci un numero da 1 a 3\n\n"
   errore:.asciiz "Il numero inserito non era compreso tra 1 e 3 \n\n"
   fine:.asciiz "THE END \n\n"

   jump_table: .space 12 # jump table array a 3 word che verra' instanziata dal main con gli indirizzi delle label che chiameranno le corrispondenti procedure
   
.text 
.globl main 

main:  
# prepara la jump_table con gli indirizzi delle case actions
	  la $t1, jump_table
	  la $t0, juno	  
	  sw $t0, 0($t1)
 	  la $t0, jdue  
	  sw $t0, 4($t1)
	  la $t0, jtre	  
	  sw $t0, 8($t1)	  

choice:
# scelta della procedura o dell'uscita
	  li $v0, 4  # $v0 =codice della print_string 
        la $a0, inserimento # $a0 =  indirizzo della stringa 
	  syscall # stampa la stringa prompt	 
	  
# legge la scelta
      li $v0, 5
	  syscall
	  move $t2, $v0   # $t2=scelta 1, 2 o 3
	  
	  sle  $t0, $t2, $zero	# $t0=1 se $t2 <= 0
	  bne  $t0, $zero, choice_err # errore se scelta <=0
	  li   $t0,3
	  sle  $t0, $t2, $t0
	  beq  $t0, $zero, choice_err # errore se scelta >3
 
branch_case:
	  addi $t2, $t2, -1 # tolgo 1 da scelta perche' prima azione nella jump table (in posizione 0) corrisponde alla prima scelta del case
	  add $t0, $t2, $t2 
	  add $t0, $t0, $t0 # ho calcolato (scelta-1) * 4
	  add $t0, $t0, $t1 # sommo all'indirizzo della prima case action l'offset calcolato sopra
	  lw $t0, 0($t0)    # $t0 = indirizzo a cui devo saltare

	  jr $t0 # salto all'indirizzo calcolato

# prima case action
juno: 
	la $a0, str1
	li $v0, 4
	syscall

	j exit # esce

# seconda case action
jdue: 
	la $a0, str2
	li $v0, 4
	syscall

	j exit # esce

# terza case action
jtre: 
	la $a0, str3
	li $v0, 4
	syscall
	   
	j exit # esce
	  
choice_err: 
      li $v0, 4  
      la $a0, errore 
      syscall # stampa la stringa errore		
	  				  		  		  	  
      j choice # ritorna alla richiesta di inserimento di un numero tra 1 e 3 
	  
exit: # stampa messaggio di uscita e esce
	li $v0, 4
	la $a0, fine
	syscall
		
	li $v0, 10 
      syscall 	