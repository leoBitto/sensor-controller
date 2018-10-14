# Title: Unità di Monitoraggio Filename: UDM.s
# Author: Leonardo Bitto       Data: 02/06/18
# Description: dati in input 100 valori per ogni sensore si ottengano
#              i risultati di ogni sensore, questi vengono aggregati
#             secondo tre politiche di funzionamento i risultati vengono
#             riscritti in un file di testo out put per ogni sensore e ogni politica
# Input:      3 file di testo dei valori in input dei sensori
# Output:     6 file di testo dei valori in output dei sensori e delle politiche
############ Data Segment #############
.data

  bufferIN:   .space 420
  bufferOUT1:  .space 250
  bufferOUT2:  .space 250
  bufferOUT3:  .space 250
  OUT1: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaP1.txt"         # file di output politica1
  OUT2: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaP2.txt"         # file di output politica2
  OUT3: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaP3.txt"         # file di output politica3

  INp:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/pendenzaIN.txt"                # file di input pendenza
  OUTp: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaPendenzaOUT.txt"   # file di output pendenza
  bufferOUTp: .space 250

  INs:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/sterzoIN.txt"                  # file di input sterzo
  OUTs: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaSterzoOUT.txt"     # file di output sterzo
  bufferOUTs: .space 250

  INd:  .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/distanzaIN.txt"                # file di input distanza
  OUTd: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18_consegna/correttezzaDistanzaOUT.txt"   # file di output distanza
  bufferOUTd: .space 250

############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl main #rende l'etichetta main globale

  main:
        jal SenPendenza
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

        jal SenSterzo
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

        jal SenDistanza
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

  #  ESEGUI PRIMA POLITICA ########################################################
  # POLITICA DI AGGREGAZIONE E SCRITTURA IN FILE DI TESTO OUT
  # carica byte in $t0, $t1, $t2
  la $s2, bufferOUTd       # indirizzo bufferOUT DISTANZA
  la $s1, bufferOUTs       # indirizzo bufferOUT STERZO
  la $s0, bufferOUTp       # indirizzo bufferOUT PENDENZA

  li $s3, 0               # inizializzazione del contatore del bufferIN
  li $s4, 0               # inizializzazione del contatore del bufferOUT
  li $s5, 0x20            # codice ASCII per SPAZIO

P1loop:

  lb $t0, ($s0)               # carica byte dal buffer pendenza
  beq $t0, $zero, P1scrivi      # se il byte estratto è zero allora vai a fine
                              # funziona perchè i numeri sono in codice ascii nei buffers
                              # e questi terminano con zero
  addi $s0, $s0, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  lb $t1, ($s1)               # carica byte dal buffer sterzo
  beq $t1, $zero, P1scrivi      # se il byte estratto è zero allora vai a fine
  addi $s1, $s1, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  lb $t2, ($s2)               # carica byte dal buffer distanza
  beq $t2, $zero, P1scrivi      # se il byte estratto è zero allora vai a fine
  addi $s2, $s2, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  addi $t0, $t0, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)
  addi $t1, $t1, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)
  addi $t2, $t2, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)

      # controllo se 3 sensori sono funzionanti
      and $t0, $t0, $t1       # controllo se $t0 e $t1 funzionano
      and $t0, $t0, $t2       # controllo se anche $t2 funziona

  # scrittura nel bufferOUT
  addi $t0, $t0, 48         # ritrasforma in codice ASCII i valori 1 && 0
  sb $t0, bufferOUT1($s4)    # metti il valore trovato nella posizione
                            # a cui siamo arrivati nel bufferOUT
  addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT
  sb $s5, bufferOUT1($s4)    # aggiungi uno spazio, codice 20 in bufOUT
  addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT


  add $t0, $zero, $zero     # conteneva un numero di cond
  add $t1, $zero, $zero     # conteneva un numero di cond
  add $t2, $zero, $zero     # conteneva un numero di cond

  #incremento contatore
  addi $s3, $s3, 2        # incremento contatore di due, salta lo spazio tra i valori

  j P1loop

P1scrivi:
  # apri il file OUT (ottenere il descrittore del file)
  li $v0, 13                # codice del sistema operativo per aprire file txt
  la $a0, OUT1               # nome del file da caricare
  li $a1, 1                 # flag per scrittura
  li $a2, 0                 # flag per modalità
  syscall                   # chiamata al sistema

  # scrivi nel file appena aperto
  move $a0, $v0             # descrittore file di OUT
  li $v0, 15                # codice syscall per scrittura
  la $a1, bufferOUT1         # indirizzo bufferOUT
  li $a2, 200               # quanti caratteri da scrivere
  syscall

  # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

  li $v0, 16
  syscall

  # CHIAMATA ALLA SECONDA POLITICA######################################################àà
  # POLITICA DI AGGREGAZIONE E SCRITTURA IN FILE DI TESTO OUT
  # carica byte in $t0, $t1, $t2

  la $s2, bufferOUTd       # indirizzo bufferOUT DISTANZA
  la $s1, bufferOUTs       # indirizzo bufferOUT STERZO
  la $s0, bufferOUTp       # indirizzo bufferOUT PENDENZA

  li $s3, 0               # inizializzazione del contatore del bufferIN
  li $s4, 0               # inizializzazione del contatore del bufferOUT

  P2loop:

  lb $t0, ($s0)               # carica byte dal buffer pendenza
  beq $t0, $zero, P2scrivi      # se il byte estratto è zero allora vai a fine
                              # funziona perchè i numeri sono in codice ascii nei buffers
                              # e questi terminano con zero
  addi $s0, $s0, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  lb $t1, ($s1)               # carica byte dal buffer sterzo
  beq $t1, $zero, P2scrivi      # se il byte estratto è zero allora vai a fine
  addi $s1, $s1, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  lb $t2, ($s2)               # carica byte dal buffer distanza
  beq $t2, $zero, P2scrivi      # se il byte estratto è zero allora vai a fine
  addi $s2, $s2, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  addi $t0, $t0, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)
  addi $t1, $t1, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)
  addi $t2, $t2, -48      # riporta in decimale i caratteri letti nel buffer (0 o 1)

    # controllo se almeno 2 sensori sono funzionanti
    # ps+pd+sd

    and $t3, $t0, $t1   # usa tre registri temporanei per mantenere il risultato
    and $t4, $t0, $t2   # degli and tra ps, pd, sd
    and $t5, $t1, $t2   #
    or $t6, $t3, $t4    # il risultato del primo or tra ps e pd viene messo in t6
    or $t0, $t6, $t5    # e il risultato finale tra (ps+pd) or sd in t0

  # scrittura nel bufferOUT
  addi $t0, $t0, 48         # ritrasforma in codice ASCII i valori 1 && 0
  sb $t0, bufferOUT2($s4)    # metti il valore trovato nella posizione
                            # a cui siamo arrivati nel bufferOUT
  addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT
  sb $s5, bufferOUT2($s4)    # aggiungi uno spazio, codice 20 in bufOUT
  addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT


  add $t0, $zero, $zero     # conteneva un numero di cond
  add $t1, $zero, $zero     # conteneva un numero di cond
  add $t2, $zero, $zero     # conteneva un numero di cond

  #incremento contatore
  addi $s3, $s3, 2        # incremento contatore di due, salta lo spazio tra i valori

  j P2loop

  P2scrivi:
  # apri il file OUT (ottenere il descrittore del file)
  li $v0, 13                # codice del sistema operativo per aprire file txt
  la $a0, OUT2               # nome del file da caricare
  li $a1, 1                 # flag per scrittura
  li $a2, 0                 # flag per modalità
  syscall                   # chiamata al sistema

  # scrivi nel file appena aperto
  move $a0, $v0             # descrittore file di OUT
  li $v0, 15                # codice syscall per scrittura
  la $a1, bufferOUT2         # indirizzo bufferOUT
  li $a2, 200               # quanti caratteri da scrivere
  syscall

  # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

  li $v0, 16
  syscall

  # CHIAMATA ALLA TERZA POLITICA############################################################
  # POLITICA DI AGGREGAZIONE E SCRITTURA IN FILE DI TESTO OUT
  # carica byte in $t0, $t1, $t2

  la $s2, bufferOUTd       # indirizzo bufferOUT DISTANZA
  la $s1, bufferOUTs       # indirizzo bufferOUT STERZO
  la $s0, bufferOUTp       # indirizzo bufferOUT PENDENZA

  li $s3, 0               # inizializzazione del contatore del bufferIN
  li $s4, 0               # inizializzazione del contatore del bufferOUT

  P3loop:

  lb $t0, ($s0)               # carica byte dal buffer pendenza
  beq $t0, $zero, P3scrivi      # se il byte estratto è zero allora vai a fine
                              # funziona perchè i numeri sono in codice ascii nei buffers
                              # e questi terminano con zero
  addi $s0, $s0, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  lb $t1, ($s1)               # carica byte dal buffer sterzo
  beq $t1, $zero, P3scrivi      # se il byte estratto è zero allora vai a fine
  addi $s1, $s1, 2            # incremento di 2 dell'indirizzo base cosi da
                              # non considerare lo spazio

  lb $t2, ($s2)               # carica byte dal buffer distanza
  beq $t2, $zero, P3scrivi      # se il byte estratto è zero allora vai a fine
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
  sb $t0, bufferOUT3($s4)    # metti il valore trovato nella posizione
                            # a cui siamo arrivati nel bufferOUT
  addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT
  sb $s5, bufferOUT3($s4)    # aggiungi uno spazio, codice 20 in bufOUT
  addiu $s4, $s4, 1         # aumenta di 1 il contatore del bufferOUT


  add $t0, $zero, $zero     # conteneva un numero di cond
  add $t1, $zero, $zero     # conteneva un numero di cond
  add $t2, $zero, $zero     # conteneva un numero di cond

  #incremento contatore
  addi $s3, $s3, 2        # incremento contatore di due, salta lo spazio tra i valori

  j P3loop

  P3scrivi:
  # apri il file OUT (ottenere il descrittore del file)
  li $v0, 13                # codice del sistema operativo per aprire file txt
  la $a0, OUT3               # nome del file da caricare
  li $a1, 1                 # flag per scrittura
  li $a2, 0                 # flag per modalità
  syscall                   # chiamata al sistema

  # scrivi nel file appena aperto
  move $a0, $v0             # descrittore file di OUT
  li $v0, 15                # codice syscall per scrittura
  la $a1, bufferOUT3         # indirizzo bufferOUT
  li $a2, 200               # quanti caratteri da scrivere
  syscall

  # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

  li $v0, 16
  syscall

  j FINE



                  # CODICI DEI SENSORI
                  # SENSORE DI PENDENZA
  SenPendenza:

      # apri il file degli input (ottenere il descrittore del file in $v0)

      li $v0, 13        # codice del sistema operativo per aprire file txt
      la $a0, INp        # nome del file da caricare
      li $a1, 0         # flag per scrittura
      li $a2, 0         # flag per modalità
      syscall           # chiamata al sistema

      # leggi dal file appena aperto,
      # in pratica carica in memoria
      # una porzione specificata del file

      move $a0, $v0     # metti nel parametro di entrata descrittore del file
                        # indirizzo del buffer in cui copiare il file di testo
      la $a1, bufferIN
      li $a2, 500       # specifica la quantità di caratteri nel buffer
      li $v0, 14        # codice di chiamata per lettura
      syscall           # chiamata al sistema

      # chiudi il file IN
      move $a0, $v0
      li $v0, 16
      syscall

      li $v0, 0         # azzeramento di v0 in quanto usato successivamente

      li $s1, 0         # inizializzazione contatore bufferIN
      li $s2, 0         # inizializzazione contatore bufferOUT
      li $s6, 0x0a      # carica valore di fine buffer
      li $s7, 0x20      # carica il valore esadecimale 0x20 in t9 (spazio)

      # ALLOCAZIONE NELLO STACK DELL'INDIRIZZO DI RITORNO
      # a causa delle chiamate convertitore e condizione, gli indirizzi
      # di ritorno vengono modificati, è necessario quindi preservare
      # l'indirizzo di ritorno nello stack. le chiamate convertitore e condizione
      # non soffrono di questo problema in quanto vengono chiamate in modo sequenziale

      addi $sp, $sp, -4
      sw $ra, 0($sp)

      # MONTAGGIO DEL
      # NUMERO CHE POI VERRÀ LETTO E GIUDICATO
       Ploop:
            lb $a0, bufferIN($s1)     # carica  il byte da esaminare
            beq $a0, $s6, PFINE        # se questo equivale al terminatore 0x0a
                                      # allora si passa a FINE

      # CASE CHECK IL BYTE CARICATO SE SPAZIO SE SEGN NEG SE NUMERO

            # check se ha trovato uno spazio
            bne $a0, $s7, Pconv        # se il byte caricato in a0 non è 20 vai a conv

            move $a0, $v0             # metti come argomento di entrata l'uscita del
                                      # convertitore ASCII-numero
            jal pendenza              # chiamata al modulo condPendenza.s

            # conversione in ASCII del risultato e
            # scrittura nel bufferOUT
            addi $v0, $v0, 48         # ritrasforma in codice ASCII i valori 1 && 0
            sb $v0, bufferOUTp($s2)          # metti il valore trovato nella posizione
                                      # a cui siamo arrivati nel bufferOUT($s2)
            addiu $s2, $s2, 1         # aumenta di 1 il contatore del bufferOUT
            sb $s7, bufferOUTp($s2)          # aggiungi uno spazio, codice 20 in bufOUT($s2)
            addiu $s2, $s2, 1         # aumenta di 1 il contatore del bufferOUT

            # azzeramento registri
            # una volta calcolato il valore tutti registri che hanno
            # preso parte al suo calcolo devono essere resettati a zero
            add $v0, $zero, $zero     # conteneva un numero non più necessario
            add $a3, $zero, $zero     # conteneva il segno negativo
            add $t2, $zero, $zero     # conteneva numero d'appoggio per condizione di pendenza
            add $t3, $zero, $zero     # conteneva numero d'appoggio per condizione di pendenza
            add $t8, $zero, $zero     # conteneva un numero usato dal convertitore
            j Pcontinue

      Pconv: li $a2, 0
            jal converter
  Pcontinue: addiu $s1, $s1, 1         # aumenta di 1 il contatore di bufferIN
            j Ploop
            # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
            # cosi che al prossimo spazio venga usato come
            # ingresso per la funzione pendenza
  PFINE:

      # apri il file OUT (ottenere il descrittore del file)

      li $v0, 13                # codice del sistema operativo per aprire file txt
      la $a0, OUTp               # nome del file da caricare
      li $a1, 1                 # flag per scrittura
      li $a2, 0                 # flag per modalità
      syscall                   # chiamata al sistema

      # scrivi nel file appena aperto

      move $a0, $v0             # descrittore file di OUT
      li $v0, 15                # codice syscall per scrittura
      la $a1, bufferOUTp        # indirizzo bufferOUT
      li $a2, 200               # quanti caratteri da scrivere
      syscall

      # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

      li $v0, 16
      syscall

      # RIPRISTINO DALLO STACK DELL'INDIRIZZO DI RITORNO E SALTO AL chiamante
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      jr $ra

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


    SenSterzo:

        # apri il file degli input (ottenere il descrittore del file in $v0)

        li $v0, 13        # codice del sistema operativo per aprire file txt
        la $a0, INs        # nome del file da caricare
        li $a1, 0         # flag per scrittura
        li $a2, 0         # flag per modalità
        syscall           # chiamata al sistema

        # leggi dal file appena aperto,
        # in pratica carica in memoria nel buffer
        # una porzione specificata del file in $a2

        move $a0, $v0     # metti nel parametro di entrata descrittore del file
                          # indirizzo del buffer in cui copiare il file di testo
        la $a1, bufferIN
        li $a2, 500       # specifica la quantità di caratteri nel buffer
        li $v0, 14        # codice di chiamata per lettura
        syscall           # chiamata al sistema

        # chiudi il file IN
        move $a0, $v0
        li $v0, 16
        syscall

        li $v0, 0         # azzeramento di v0 in quanto usato successivamente
        li $a0, 0         # azzeramento di a0 in quanto usato successivamente contiene s(t)
        li $a1, 0         # azzeramento di a1 in quanto usato successivamente contiene s(t-1)

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

        # dato che si deve calcolare la differenza tra un valore e il suo precedente
        # è necessario calcolare il primo numero prima di entrare nel loop che calcola
        # il prossimo numero calcolare per ogni coppia se la differenza è minore di 10 (1)
        # oppure maggiore di 10 (0)
        lb $a1, bufferIN($s2)
        blt $a1, 48, Scontinue    # controlla se il byte è un numero   | nel caso in cui non venga riconosciuto come numero
        bgt $a1, 57, Scontinue    # deve essere compreso tra 48 e 57   | non viene implementata la gestione dell'errore
        addi $a1, $a1, -48       # converti il char ASCII in intero   | si passa al prossimo byte da esaminare
        addi $s2, $s2, 1         # aggiungi uno al contatore di bufferIN
        lb $t5, bufferIN($s2)            # carica byte successivo
        beq $t5, $s5, Scontinue   # se il carattere è uguale a uno spazio vai a continue
        blt $t5, 48, Scontinue    # controlla se il byte è un numero   | nel caso in cui non venga riconosciuto come numero
        bgt $t5, 57, Scontinue    # deve essere compreso tra 48 e 57   | non viene implementata la gestione dell'errore
        addi $t5, $t5, -48       # converti il char ASCII in intero   | si passa al prossimo byte da esaminare
        mul $a1, $a1, 10         # moltiplica per 10 $a1 = $a1 * 10
        add $a1, $a1, $t5        # $a1 = $a1 + digit
        addi $s2, $s2, 2         # aggiungi due al contatore di bufferIN
        add $t5, $zero, $zero    # $t5 = 0 ripulisce variabile

        Sloop:
              lb $a0, bufferIN($s2)     # carica  il byte da esaminare
              beq $a0, $s6, SFINE        # se questo equivale al terminatore del bufferIN
                                        # 0x0a allora si passa a FINE

              # check se ha trovato uno spazio
              bne $a0, $s7, Sconv        # se il byte caricato in s0 non è 20 vai a next

              move $a0, $v0        # sposta da v0 dove è stato messo l'ultimo
                                   # numero calcolato, in a0 e chiama la funzione
                                   # che implementa la condizione di funzionamento
                                   # dell sterzo
              jal sterzo                # chiamata al modulo condSterzo.s

              # conversione in ASCII del risultato e
              # scrittura nel bufferOUT
              addi $v0, $v0, 48         # ritrasforma in codice ASCII i valori 1 && 0
              sb $v0, bufferOUTs($s3)    # metti il valore trovato nella posizione
                                        # a cui siamo arrivati nel bufferOUT
              addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT
              sb $s7, bufferOUTs($s3)    # aggiungi uno spazio, codice 20 in bufOUT
              addiu $s3, $s3, 1         # aumenta di 1 il contatore del bufferOUT

              # spostamento registro $a0 in $a1
              move $a1, $a0             # conteneva il vecchio numero esaminato
              add $a0, $zero, $zero     # imposta a zero $a0
              add $v0, $zero, $zero     # conteneva un numero non piu necessario
              add $t3, $zero, $zero     # il registro conteneva un numero usato temporaneamente
                                        # dalla condizione di sterzo
              add $t8, $zero, $zero     # conteneva un numero di appoggio per il converter

              #calcolo numero
              j Scontinue
        Sconv: li $a2, 0
              jal converter
    Scontinue: addiu $s2, $s2, 1        # aumenta di 1 il contatore di bufferIN
              j Sloop
              # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
              # cosi che al prossimo spazio venga usato come
              # ingresso per la funzione sterzo
    SFINE:

        # apri il file OUT (ottiene il descrittore del file)

        li $v0, 13                # codice del sistema operativo per aprire file txt
        la $a0, OUTs               # nome del file da caricare
        li $a1, 1                 # flag per scrittura
        li $a2, 0                 # flag per modalità
        syscall                   # chiamata al sistema

        # scrivi nel file appena aperto

        move $a0, $v0             # descrittore file di OUT
        li $v0, 15                # codice syscall per scrittura
        la $a1, bufferOUTs        # indirizzo bufferOUT
        li $a2, 198               # quanti caratteri da scrivere
        syscall

        # chiudi il file OUT in a0 è gia presente il descrittore del file OUT

        li $v0, 16
        syscall

        # RIPRISTINO DALLO STACK DELL'INDIRIZZO DI RITORNO E SALTO AL chiamante
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

        # PARTE DI CONTROLLO SE LA DIFFERENZA
        # È MINORE DI 10 IN QUEL CASO RESTITUIRE 1 IN V0
        # viene elaborato da una funzione esterna
        # in a0 viene messo
        sterzo:
            addi $t0, $zero, 10       # imposta $t0 a 10
            addi $t1, $zero, -1       # serve a verificare che la DIFFERENZA
                                      # sia maggiore di zero
            sub $t3, $a0, $a1         # $a0 = $a0 - $a1
            bgt $t3, $t1, sfine        # se $a0 > 0 allora fine
            nor $t3, $t3, $zero       # sennò inverti i bit del NUMERO
            addi $t3, $t3, 1          # e aggiungi uno, per il complemento a due questo numero è ora positivo
    sfine:   slt $v0, $t3, $t0         # imposta $v0 a 1 se $a0 < 10

            j $ra

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
      la $a1, bufferIN
      li $a2, 500       # specifica la quantità di caratteri nel buffer
      li $v0, 14        # codice di chiamata per lettura
      syscall           # chiamata al sistema

      # chiudi il file IN
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

      Dloop:
            lb $a1, bufferIN($s2)     # carica  il byte da esaminare
            move $t9, $a1             # carica la lettera nel registro t9 (usata dalla condizione)
            beq $a1, $s6, DFINE        # se questo equivale al terminatore del bufferIN
                                      # 0x0a allora si passa a FINE

            addiu $s2, $s2, 1         # aumenta di 1 il contatore di bufferIN

                  # check se ha trovato uno spazio
           Dloop2:
                  lb $a0, bufferIN($s2)     # carica  il byte da esaminare

                  beq $a0, $s6, DFINE        # se questo equivale al terminatore del bufferIN
                                            # 0x0a allora si passa a FINE
                  bne $a0, $s7, Dconv        # se il byte caricato in s0 non è 20 allora
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
                  j Dcontinue

                  #calcolo numero
            Dconv: li $a3, 0     # spegni flag di segno negativo
                  li $a2, 1     # accendi flag base esadecimale
                  jal converter
                  addiu $s2, $s2, 1         # aumenta di 1 il contatore di bufferIN
                  j  Dloop2

  Dcontinue: addiu $s2, $s2, 1        # aumenta di 1 il contatore di bufferIN
            j Dloop
            # QUANDO IL NUMERO È PRONTO VIENE MESSO IN $A0
            # cosi che al prossimo spazio venga usato come
            # ingresso per la funzione sterzo
  DFINE:

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
      jr $ra

    distanza:

        li $t0, 50                # imposta $t1 a 50 decimale
        li $t1, 0x42              # valore di B in codifica ASCII esadecimale
        # controllo se valore di distanza in $a1 è compreso tra
        # 0 e 50
        slt $t2, $zero, $a0       # imposta a 1 $t3 se 0 < $a0
        slt $t3, $a0, $t0         # imposta a 1 $t4 se $a0 < $t0

        and $t4, $t2, $t3         # and logico tra i due registri $t2 & $t3
        beq $t4, $zero dfine       # imposta $t4 a 1 se 0 < $a0 < 50

        # controllo misure precedenti
        add $t7, $zero, 1         # supponi che i tre valori non siano diversi

        bne $t9, $t1, dfine        # se la lettera corrente è diversa da B
                                  # puoi saltare a fine

        bne $a1, $s0, dfine        # se la lettera in input non è una B allora vai a fine
        li  $t5, 0                # sennò carica in $t5 il valore 1
        bne $a1, $s1, dfine        # se la lettera precedente non era una B allora vai a fine
        li  $t6, 0                # sennò carica in $t6 il valore 1
        and $t7, $t5, $t6         # verifica che non sia stato letto tre volte
                                  # t5 e t6 sono rispettivamente la seconda e terza volta

    dfine:move $s1, $s0
        move $s0, $a1

        and $v0, $t4, $t7         # metti il risultato 1 in v0 se entrambe le condizioni sono rispettare
        j $ra

# INTERPRETATORE ASCII NUMERO ##
converter:

          # controlla se è un simbolo negativo
          li $t3, 0x2d             # carica il valore esadecimale 0x2d in t3 (-)
          bne $a0, $t3, base       # se il byte è diverso dal segno negativo 0x2d
                                   # allora calcola la base,
          li $a3, 1                # flag per numero negativo
          j AScontinue               # torna a loop chiamante

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
          blt $a0, $zero, AScontinue
          sub $a0, $a0, 0x30  # 0x30 è un fattore necessario a convertire da ascii decimale
                               # solo nel caso dei numeri minori di 9
          # calcolo numero  $t8 viene usato per creare il numero                GESTIONE ERRORI
labelnum:
          mul $t8, $t8, $t5        # moltiplica per 10 $t8 = $t8 * 10    | nel caso in cui non venga riconosciuto come numero
          beq $a3, 1, negativo     # se il flag negativo è attivo (1)       | non viene implementata la gestione dell'errore
                                   # allora esegui il calcolo come se fosse | si passa al prossimo byte da esaminare. se il codice
                                   # un numero negativo sennò               | ASCII è minore di 48 allora è una lettera.
          add $t8, $t8, $a0        # $t8 = $t8 + digit
          j AScontinue               # e vai a continue
negativo: sub $t8, $t8, $a0        # $t8 = $t8 - digit

AScontinue: move $v0, $t8            # sposta valore in registro out
          jr $ra
 nodigit: sub $a0, $a0, 65   # valore decimale in codifica ASCII
          addi $a0, $a0, 10   # riporta al valore decimale la lettera in esadecimale
          j labelnum


FINE:
li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
