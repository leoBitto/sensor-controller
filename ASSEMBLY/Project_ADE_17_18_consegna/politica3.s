# Title:     politica di funzionamento sensore  (1 sensore)  Filename:
# Author: Leonardo Bitto                                     Data: 30/05/18
# Description: crea i buffer, chiama le funzioni dei sensori e scrive nei buffer di uscita infine copia nei file di testo OUT
# Input:
# Output: scrittura in file di testo
############ Data Segment #############
.data

  bufferIN:   .space 420
  bufferOUT:  .space 250
  OUT: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaP3.txt"         # file di output politica


############ Code Segment #############
.text
.globl main

  main:
        # CHIAMATA AL SENSORE PENDENZA, REGISTRI VENGONO POI AZZERATI
        la $s5, bufferIN
        jal SenPendenza
        addi $sp, $sp, -4
        sw $v0, ($sp)

        add $a0, $zero, $zero
        add $a1, $zero, $zero
        add $a2, $zero, $zero
        add $a3, $zero, $zero
        add $v0, $zero, $zero
        add $v1, $zero, $zero
        add $s0, $zero, $zero
        add $s1, $zero, $zero
        add $s2, $zero, $zero
        add $s3, $zero, $zero
        add $s4, $zero, $zero
        add $s6, $zero, $zero
        add $s7, $zero, $zero
        add $t0, $zero, $zero
        add $t1, $zero, $zero
        add $t2, $zero, $zero
        add $t3, $zero, $zero
        add $t4, $zero, $zero
        add $t5, $zero, $zero
        add $t6, $zero, $zero
        add $t7, $zero, $zero
        add $t8, $zero, $zero
        add $t9, $zero, $zero


        # CHIAMATA AL SENSORE STERZO I REGISTRI VENGONO POI AZZERATI
        la $s5, bufferIN
        jal SenSterzo
        addi $sp, $sp, -4
        sw $v0, ($sp)

        add $a0, $zero, $zero
        add $a1, $zero, $zero
        add $a2, $zero, $zero
        add $a3, $zero, $zero
        add $v0, $zero, $zero
        add $v1, $zero, $zero
        add $s0, $zero, $zero
        add $s1, $zero, $zero
        add $s2, $zero, $zero
        add $s3, $zero, $zero
        add $s4, $zero, $zero
        add $s6, $zero, $zero
        add $s7, $zero, $zero
        add $t0, $zero, $zero
        add $t1, $zero, $zero
        add $t2, $zero, $zero
        add $t3, $zero, $zero
        add $t4, $zero, $zero
        add $t5, $zero, $zero
        add $t6, $zero, $zero
        add $t7, $zero, $zero
        add $t8, $zero, $zero
        add $t9, $zero, $zero


        # CHIAMATA AL SENSORE DI DISTANZA I REGISTRI VENGONO POI AZZERATI
        la $s5, bufferIN
        jal SenDistanza

        add $a0, $zero, $zero
        add $a1, $zero, $zero
        add $a2, $zero, $zero
        add $a3, $zero, $zero
        # $v0 contiene l'indirizzo del buffer di uscita della distanza bufferOUTd
        # e non va cancellato nè caricato sullo stack
        add $v1, $zero, $zero
        add $s0, $zero, $zero
        add $s1, $zero, $zero
        add $s2, $zero, $zero
        add $s3, $zero, $zero
        add $s4, $zero, $zero
        add $s6, $zero, $zero
        add $s7, $zero, $zero
        add $t0, $zero, $zero
        add $t1, $zero, $zero
        add $t2, $zero, $zero
        add $t3, $zero, $zero
        add $t4, $zero, $zero
        add $t5, $zero, $zero
        add $t6, $zero, $zero
        add $t7, $zero, $zero
        add $t8, $zero, $zero
        add $t9, $zero, $zero


        # POLITICA DI AGGREGAZIONE E SCRITTURA IN FILE DI TESTO OUT
        # carica byte in $t0, $t1, $t2
        move $s2, $v0       # indirizzo bufferOUT DISTANZA

        lw $s1, ($sp)       # indirizzo bufferOUT STERZO
        addi $sp, $sp, 4

        lw $s0, ($sp)       # indirizzo bufferOUT PENDENZA
        addi $sp, $sp, 4


        li $s3, 0               # inizializzazione del contatore del bufferIN
        li $s4, 0               # inizializzazione del contatore del bufferOUT
        li $s5, 0x20            # codice ASCII per SPAZIO

  loop:

        lb $t0, ($s0)               # carica byte dal buffer pendenza
        beq $t0, $zero, scrivi      # se il byte estratto è zero allora vai a fine
                                    # funziona perchè i numeri sono in codice ascii nei buffers
                                    # e questi terminano con zero
        addi $s0, $s0, 2            # incremento di 2 dell'indirizzo base cosi da
                                    # non considerare lo spazio

        lb $t1, ($s1)               # carica byte dal buffer sterzo
        beq $t1, $zero, scrivi      # se il byte estratto è zero allora vai a fine
        addi $s1, $s1, 2            # incremento di 2 dell'indirizzo base cosi da
                                    # non considerare lo spazio

        lb $t2, ($s2)               # carica byte dal buffer distanza
        beq $t2, $zero, scrivi      # se il byte estratto è zero allora vai a fine
        addi $s2, $s2, 2            # incremento di 2 dell'indirizzo base cosi da
                                    # non considerare lo spazio

        addi $t0, $t0, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)
        addi $t1, $t1, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)
        addi $t2, $t2, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)

            # controllo se 3 sensori sono funzionanti
            or $t0, $t0, $t1       # controllo se $t0 o $t1 funzionano
            or $t0, $t0, $t2       # controllo se $t2 funziona

        # scrittura nel bufferOUT
        addi $t0, $t0, 48         # ritrasforma in codice ASCII i valori 1 && 0
        sb $t0, bufferOUT($s4)    # metti il valore trovato nella posizione
                                  # a cui siamo arrivati nel bufferOUT
        addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT
        sb $s5, bufferOUT($s4)    # aggiungi uno spazio, codice 20 in bufOUT
        addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT


        add $t0, $zero, $zero     # conteneva un numero di cond
        add $t1, $zero, $zero     # conteneva un numero di cond
        add $t2, $zero, $zero     # conteneva un numero di cond

        #incremento contatore
        addi $s3, $s3, 2        # incremento contatore di due, salta lo spazio tra i valori

        j loop

  scrivi:
        # apri il file OUT (ottenere il descrittore del file)
        li $v0, 13                # codice del sistema operativo per aprire file txt
        la $a0, OUT               # nome del file da caricare
        li $a1, 1                 # flag per scrittura
        li $a2, 0                 # flag per modalità
        syscall                   # chiamata al sistema

        # scrivi nel file appena aperto
        move $a0, $v0             # descrittore file di OUT
        li $v0, 15                # codice syscall per scrittura
        la $a1, bufferOUT         # indirizzo bufferOUT
        li $a2, 200               # quanti caratteri da scrivere
        syscall

        # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

        li $v0, 16
        syscall

        # CHIUDI SPIM

        li $v0, 10  # metti in $v0 il valore 10 e chiama
        syscall     # syscall per finire l'esecuzione del programma
