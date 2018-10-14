# Title:    condizione distanza    Filename: condDistanza.s
# Author: Leonardo Bitto           Data: 22/05/18
# Description: implementa la condizione necessaria a determinare il funzionamento
#              del sensore preso in considerazione, in questo caso due condizioni
#              devono essere soddisfatte, che il valore numerico sia compreso da 0 e 50
#              e che in due misurazioni consecutive non siano letti due valori A
# Input:  un valore numerico in a1 e i valori A o B in a0
# Output: restituzione valore output 1 o 0 in $v0
############ Data Segment #############
.data



############ Code Segment #############
.text
.globl distanza

        distanza:

            li $t0, 50                # imposta $t1 a 50 decimale
            li $t1, 0x42              # valore di B in codifica ASCII esadecimale
            # controllo se valore di distanza in $a1 è compreso tra
            # 0 e 50
            slt $t2, $zero, $a0       # imposta a 1 $t3 se 0 < $a0
            slt $t3, $a0, $t0         # imposta a 1 $t4 se $a0 < $t0

            and $t4, $t2, $t3         # and logico tra i due registri $t2 & $t3
            beq $t4, $zero fine       # imposta $t4 a 1 se 0 < $a0 < 50

            # controllo misure precedenti
            add $t7, $zero, 1         # supponi che non i tre valori siano diversi

            bne $t9, $t1, fine        # se la lettera corrente è diversa da B
                                      # puoi saltare a fine

            bne $a1, $s0, fine        # se la lettera in input non è una B allora vai a fine
            li  $t5, 0                # sennò carica in $t5 il valore 1
            bne $a1, $s1, fine        # se la lettera precedente non era una B allora vai a fine
            li  $t6, 0                # sennò carica in $t6 il valore 1
            and $t7, $t5, $t6         # verifica che non sia stato letto tre volte
                                      # t5 e t6 sono rispettivamente la seconda e terza volta

       fine:move $s1, $s0
            move $s0, $a1

            and $v0, $t4, $t7         # metti il risultato 1 in v0 se entrambe le condizioni sono rispettare

            j $ra
