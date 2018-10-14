# Title:    condizione pendenza    Filename: condPendenza.s
# Author: Leonardo Bitto           Data: 17/05/18
# Description: implementa la condizione necessaria a determinare il funzionamento del sensore preso in considerazione
# Input:  valore da controllare
# Output: scrittura nel buffer del valore output 1 o 0
############ Data Segment #############
.data



############ Code Segment #############
.text
.globl pendenza

        # PARTE DI CONTROLLO SE IL NUMERO CORRISPONDE
        # ALL'INTERVALLO +60 -60 E SCRITTURA NEL bufferOUT
        # viene elaborato da una funzione esterna
        # in a0 viene messo l'input in v0 l'output
        pendenza:
            li $t0, 60                # imposta $t0 al limite massimo
            li $t1, -60               # imposta $t1 al limite minimo

            slt $t2, $t1, $a0         # imposta a 1 $t2 se $t1 < $v0
            slt $t3, $a0, $t0         # imposta a 1 $t3 se $v0 < $t0

            and $v0, $t2, $t3         # and logico tra i due registri $t3 & $t4
                                      # imposta $t2 a 1 se $t2 < $v1 < $t1

            j $ra
