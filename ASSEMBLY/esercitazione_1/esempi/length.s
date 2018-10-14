.data
str:    .asciiz "hello world!!"

.text
.globl main

main:   la $t2,str      # t2 punta a un carattere della stringa
        li $t1,0        # t1 contatore lunghezza

nextCh: lb $t0,($t2)   # leggo un carattere della stringa (pseudoistruzione)
        beqz $t0,strEnd # se il valore letto è zero ho finito (pseudoistruzione)
        add $t1,$t1,1  # incremento il contatore
        add $t2,$t2,1  # incremento la posizione sulla stringa
        j nextCh        # e continuo

strEnd: move $a0,$t1    # scrivo il risultato
	  li $v0, 1
        syscall

	  li $v0, 10	# esce
        syscall
