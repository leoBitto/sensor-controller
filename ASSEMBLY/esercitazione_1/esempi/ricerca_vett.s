.data

myarray:        .word 2, 4, 5, 9, 133, 44, 1, 0
messagefound:   .asciiz  "\n L'elemento cercato e' stato trovato in posizione "
messagenotfound: .asciiz "\n L'elemento cercato non e' stato trovato nell'array\n"
richiestaintero: .asciiz  "\n Fornire un intero: "

.text

main:  # ricerca nel vettore myarray la presenza di un elemento fornito dall'utente e se c'e' ne stampa la posizione


         li $v0, 4                 # $v0 = codice per stampa stringa
         la $a0, richiestaintero   # $a0 = indirizzo stringa
         syscall                   # stampa stringa

         li $v0, 5                 # $v0 = codice per lettura   intero
         syscall                   # $v0 = intero letto da console

	 move $t3, $v0             # $t3 = $v0 (valore da ricercare)

   move $t0, $zero    # $t0 è l'indice contatore

	 li $t5, 0		   # $t5 è l'indice del vettore che contiene il valore cercato

loop:    addi $t5, $t5, 1
	 lw $t1, myarray($t0)      # $t1 = myarray[$t0]
         beq $t1, $zero, NotFound  # if $t1 == 0 goto NotFound (fine vettore raggiunta senza trovare $t3)
         beq $t1, $t3, Found       # if $t1==$t3 goto Found
         addi $t0, $t0, 4          # incrementa indice contatore $t0
         j loop                    # goto loop

Found:
         li $v0, 4                 # $v0 = codice per stampa stringa
         la $a0, messagefound      # $a0 = indirizzo della stringa da stampare
         syscall                   # stampa stringa

         move $a0, $t5             # $a0 contiene la posizione dell'intero trovato
         li $v0, 1                 # $v0 = codice per stampa intero
         syscall                   # stampa intero (posizione)
         j Exit                    # goto Exit
NotFound:
         li $v0, 4                 # $v0 = codice per stampa stringa
         la $a0, messagenotfound   # $a0 = indirizzo della stringa da stampare
         syscall                   # stampa stringa
Exit:
         li $v0, 10                # $v0 = codice per terminazione
         syscall                   # termina il programma
