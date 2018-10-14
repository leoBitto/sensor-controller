# Title: Sensore di rilevamento ostacoli  Filename: Ostacoli.s
# Author: Leonardo Bitto    Data: 22/5/18
# Description: legge in input un valore a tre cifre esadecimali
#              e verifica tre condizioni, il valore di distanza non deve essere
#              zero o superare 50 e non si devono effettuare due misurazioni
#              consecutive di un ostacolo mobile
# Input:       una serie di valori a tre cifre esadecimali
# Output:      un valore booleano in corrispondenza di ogni
#              valore 1 se il valore verifica le tre condizioni,
#              0 in caso contrario.
############ Data Segment #############
.data

  INd:   .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test IN/distanzaIN.txt"                # file di input distanza
  OUTd:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test OUT/correttezzaDistanzaOUT.txt"   # file di output distanza
  bufferOUTd: .space 250

############ Code Segment #############
.text
.globl SenDistanza

  SenDistanza:

      # apri il file degli input (ottenere il descrittore del file in $v0)

      li $v0, 13        # codice del sistema operativo per aprire file txt
      la $a0, INd        # nome del file da caricare
      li $a1, 0         # flag per scrittura
      li $a2, 0         # flag per modalità
      syscall           # chiamata al sistema

      # leggi dal file appena aperto,
      # in pratica carica in memoria nel buffer
      # una porzione specificata del file in $a2
      # la specificazione del file da leggere avviene con l'apertura

      move $a0, $v0     # metti nel parametro di entrata descrittore del file
                        # indirizzo del buffer in cui copiare il file di testo
      move $a1, $s5       # viene specificato dalla funzione chiamante come parametro di ingresso in s5
      li $a2, 500       # specifica la quantità di caratteri nel buffer
      li $v0, 14        # codice di chiamata per lettura
      syscall           # chiamata al sistema

      # chiudi il file IN, avendo già caricato tutto il suo contenuto nel buffer non è più necessario

      move $a0, $v0
      li $v0, 16
      syscall

      li $v0, 0         # azzeramento di v0 in quanto usato successivamente
      li $a0, 0         # azzeramento di a0
      li $a1, 0         # azzeramento di a1
      li $a2, 0         # azzeramento di a2
      li $a3, 0         # azzeramento di a3
      li $s2, 0         # inizializzazione contatore bufferIN
      li $s3, 0         # inizializzazione contatore bufferOUT
      li $s6, 0x0a      # terminatore bufferIN
      li $s7, 0x20      # carica il valore esadecimale 0x20 in s5 (spazio)

      # ALLOCAZIONE NELLO STACK DELL'INDIRIZZO DI RITORNO
      # a causa delle chiamate convertitore e condizione, gli indirizzi
      # di ritorno vengono modificati, è necessario quindi preservare
      # l'indirizzo di ritorno nello stack. le chiamate convertitore e condizione
      # soffrono di questo problema in quanto vengono chiamate in modo sequenziale

      addi $sp, $sp, -4
      sw $ra, 0($sp)

      loop:
            add $a1, $s5, $s2
            lb $a1, ($a1)     # carica  il byte da esaminare
            move $t9, $a1             # carica la lettera nel registro t9 (usata dalla condizione)
            beq $a1, $s6, FINE        # se questo equivale al terminatore del bufferIN
                                      # 0x0a allora si passa a FINE

            addiu $s2, $s2, 1         # aumenta di 1 il contatore di bufferIN

                  # check se ha trovato uno spazio
           loop2:
                  add $a0, $s5, $s2
                  lb $a0, ($a0)     # carica  il byte da esaminare

                  beq $a0, $s6, FINE        # se questo equivale al terminatore del bufferIN
                                            # 0x0a allora si passa a FINE
                  bne $a0, $s7, conv        # se il byte caricato in s0 non è 20 allora
                                            # è un numero hex quindi vai a conv

                  # sposta i corretti valori da calcolare prima di chiamare la funzione distanza
                  move $a0, $v0         # per controllare se si è verificata tre volte la stessa sequenza di valori
                  add $a1, $a1,$a0      # dato che abbiamo solo 4 registri in entrata per non scomodare lo stack
                                        # operazione di somma grava meno di un'operazione di lw e sw
                                        # possiamo sommare il valore in codifica ascii della lettera
                                        # al valore numerico in input, il cambio della lettera o di valore
                                        # creerebbero un valore diverso rendendo diverso il valore negli $a
                                        # è possibile fare la somma solo quando si ottiene anche il valore
                                        # numerico, ovvero prima della chiamata alla condizione.
                  jal distanza          # chiamata al modulo condDistanza.s

                  # conversione in ASCII del risultato e
                  # scrittura nel bufferOUT
                  addi $v0, $v0, 48         # ritrasforma in codice ASCII i valori 1 && 0
                  sb $v0, bufferOUTd($s3)    # metti il valore trovato nella posizione
                                            # a cui siamo arrivati nel bufferOUT
                  addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT
                  sb $s7, bufferOUTd($s3)    # aggiungi uno spazio, codice 20 in bufOUT
                  addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT


                  add $t2, $zero, $zero     # conteneva un numero di cond distanza
                  add $t3, $zero, $zero     # conteneva un numero di cond distanza
                  add $t4, $zero, $zero     # conteneva un numero di cond distanza
                  add $t5, $zero, $zero     # conteneva un numero di cond distanza
                  add $t6, $zero, $zero     # conteneva un numero di cond distanza
                  add $t7, $zero, $zero     # conteneva un numero di cond distanza
                  add $t8, $zero, $zero     # conteneva un numero di intrprt ASCII
                  j continue

                  #calcolo numero
            conv: li $a3, 0     # spegni flag di segno negativo
                  li $a2, 1     # accendi flag base esadecimale
                  jal converter
                  addiu $s2, $s2, 1         # aumenta di 1 il contatore di bufferIN
                  j  loop2

  continue: addiu $s2, $s2, 1        # aumenta di 1 il contatore di bufferIN
            j loop
            # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
            # cosi che al prossimo spazio venga usato come
            # ingresso per la funzione sterzo
  FINE:

      # apri il file OUT (ottenere il descrittore del file)

      li $v0, 13                # codice del sistema operativo per aprire file txt
      la $a0, OUTd               # nome del file da caricare
      li $a1, 1                 # flag per scrittura
      li $a2, 0                 # flag per modalità
      syscall                   # chiamata al sistema

      # scrivi nel file appena aperto

      move $a0, $v0             # descrittore file di OUT
      li $v0, 15                # codice syscall per scrittura
      la $a1, bufferOUTd         # indirizzo bufferOUT
      li $a2, 198               # quanti caratteri da scrivere
      syscall

      # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

      li $v0, 16
      syscall

      # RIPRISTINO DALLO STACK DELL'INDIRIZZO DI RITORNO E SALTO AL chiamante
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      la $v0, bufferOUTd
      jr $ra
