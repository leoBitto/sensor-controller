# Title:    condizione sterzo    Filename: condSterzo.s
# Author: Leonardo Bitto           Data: 22/05/18
# Description: implementa la condizione necessaria a determinare il funzionamento del sensore preso in considerazione
# Input:  valori da controllare da sottrarre $a0 - $a1 < 10
# Output: restituzione valore output 1 o 0 in $v0
############ Data Segment #############
.data



############ Code Segment #############
.text
.globl sterzo

        # PARTE DI CONTROLLO SE LA DIFFERENZA
        # È MINORE DI 10 IN QUEL CASO RESTITUIRE 1 IN V0
        # viene elaborato da una funzione esterna
        # in a0 viene messo
        sterzo:
            addi $t0, $zero, 10       # imposta $t0 a 10
            addi $t1, $zero, -1       # serve a verificare che la DIFFERENZA
                                      # sia maggiore di zero
            sub $t3, $a0, $a1         # $a0 = $a0 - $a1
            bgt $t3, $t1, fine        # se $a0 > 0 allora fine
            nor $t3, $t3, $zero       # sennò inverti i bit del NUMERO
            addi $t3, $t3, 1          # e aggiungi uno, per il complemento a due questo numero è ora positivo
    fine:   slt $v0, $t3, $t0         # imposta $v0 a 1 se $a0 < 10

            j $ra
