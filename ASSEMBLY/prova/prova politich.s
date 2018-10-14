# Title:                      Filename:
# Author: Leonardo Bitto      Data:
# Description:
# Input:
# Output:
############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali

bufferOUTp: .space 250
INp: .asciiz "../corr.txt"

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:

        # copia in buffer p

        li $v0, 13        # codice del sistema operativo per aprire file txt
        la $a0, INp        # nome del file da caricare
        li $a1, 0         # flag per scrittura
        li $a2, 0         # flag per modalità
        syscall           # chiamata al sistema

        move $a0, $v0     # metti nel parametro di entrata descrittore del file
                          # indirizzo del buffer in cui copiare il file di testo
        la $a1, bufferOUTp     # viene specificato dalla funzione chiamante come parametro di ingresso in s5
        li $a2, 250       # specifica la quantità di caratteri nel buffer
        li $v0, 14        # codice di chiamata per lettura
        syscall           # chiamata al sistema

        # chiudi il file IN
        move $a0, $v0
        li $v0, 16
        syscall

fine: li $v0, 10  #metti in $v0 il valore 10 e chiama
      syscall     #syscall per finire l'esecuzione del programma
