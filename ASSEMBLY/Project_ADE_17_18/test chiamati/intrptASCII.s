# Title: interpetatore di caratteri ASCII          Filename: intrprtASCII.s
# Author: Leonardo Bitto      Data: 21/05/18
# Description: elabora un carattere ASCII e lo converte in un numero
#              funziona tramite due basi una decimale e l'altra esadecimale
#              all'accensione di un flag in a0 viene attivata la base esadecimale
#
# Input: carattere ASCII
# Output: un valore decimale positivo o negativo
############ Data Segment #############
.data




############ Code Segment #############
.text
.globl converter

  converter:

            # controlla se è un simbolo negativo
            li $t3, 0x2d             # carica il valore esadecimale 0x2d in t3 (-)
            bne $a0, $t3, base       # se il byte è diverso dal segno negativo 0x2d
                                     # allora calcola la base,
            li $a3, 1                # flag per numero negativo
            j continue               # torna a loop

            # decidi con quale base operare
      base: beq $a2, $zero, decimal # se il flag è spento allora decimale
            li $t5, 16              # imposta la base a sedici
            j lettera               # controlla se è una lettera
   decimal: li $t5, 10              # metti la base a dieci
            addi $a0, $a0, -0x30     # sottrai al carattere ascii il valore 0x30 per ottenere il valore decimale vero, essendo sicuramente minore 10
            j labelnum              # salta al calcolo del numero

            # SCEGLI ROUTINE NEL CASO SIA UN NUMERO O UNA LETTERA da convertire
   lettera: li $t3, 0x39
            bgt $a0, $t3, nodigit
            blt $a0, $zero, continue
            sub $a0, $a0, 0x30  # 0x30 è un fattore necessario a convertire da ascii decimale
                                 # solo nel caso dei numeri minori di 9
            # calcolo numero  $t8 viene usato per creare il numero                GESTIONE ERRORI
  labelnum:
            mul $t8, $t8, $t5        # moltiplica per 10 $t8 = $t8 * 10    | nel caso in cui non venga riconosciuto come numero
            beq $a3, 1, negativo     # se il flag negativo è attivo (1)       | non viene implementata la gestione dell'errore
                                     # allora esegui il calcolo come se fosse | si passa al prossimo byte da esaminare. se il codice
                                     # un numero negativo sennò               | ASCII è minore di 48 allora è una lettera.
            add $t8, $t8, $a0        # $t8 = $t8 + digit
            j continue               # e vai a continue
  negativo: sub $t8, $t8, $a0        # $t8 = $t8 - digit

  continue: move $v0, $t8            # sposta valore in registro out
            jr $ra
   nodigit: sub $a0, $a0, 65   # valore decimale in codifica ASCII
            addi $a0, $a0, 10   # riporta al valore decimale la lettera in esadecimale
            j labelnum
