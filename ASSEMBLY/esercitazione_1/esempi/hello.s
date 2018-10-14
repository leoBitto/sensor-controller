# hello.s


.data
prompt: .asciiz "Come ti chiami: "
msg:    .ascii "Ciao "
buffer: .space 256


.text
.globl main

main:   li $v0,4        # stampa il prompt
        la $a0,prompt
        syscall         

        li $v0,8        # legge un nome
        la $a0,buffer
        li $a1,256
        syscall         

        li $v0,4        # stampa "ciao " + nome
        la $a0,msg
        syscall        

        li $v0, 10      # termina programma
        syscall         

