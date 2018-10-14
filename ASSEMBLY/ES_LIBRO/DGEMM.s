# Title: Double Precision General Matrix Multiply   Filename: DGEMM
# Author: Leonardo Bitto                            Data: 2/5/18
# Description: C=C+A*B
# Input: tre matrici A, B, C a due dimensioni che partiranno
#        dagli indirizzi contenuti in $a0, $a1, $a2
#        le variabili intere saranno rispettivamente in
#        $s0, $s1, $s2
# Output: C = C+A*B

# CODICE IN C
# void mm (double c[][], double a[][], double b[][]){
#         int i, j, k;
#         for(i=0; i!=32; i=i+1)
#         for(j=0; j!=32; j=j+1)
#         for(k=0; k!=32; k=k+1)
#           c[i][j] = c[i][j] + a[i][k] * b[k][j];
# }

############ Data Segment #############
.data       #identifica la porzione di file in cui vengono specificati i dati gobali




############ Code Segment #############
.text       #identifica nel file il codice per l'assembler
.globl mm #rende l'etichetta main globale

  mm:
      li $t1, 32          # valore di fine ciclo
      li $s0, 0           # int i = 0
    L1:  li $s1, 0        # int j = 0
    L2:  li $s2, 0        # int k = 0
      sll  $t2, $s0, 5     # $t2= i*2^5 ampiezza riga c
      addu $t2, $t2, $s1  # $t2= i*ampiezza_riga+j
      sll  $t2, $t2, 3     # $t2= spiazzamento in byte di [i][j]
      addu $t2, $a0, $t2  # $t2= indirizzo in byte di c[i][j]
      l.d  $f4, 0($t2)     # $f4= 8 byte di c[i][j]

    L3:
      sll  $t0, $s2, 5     # $t0= k*2^5 ampiezza riga b
      addu $t0, $t0, $s1  # $t0= k*ampiezza_riga+j
      sll  $t0, $t0, 3     # $t0= spiazzamento in byte di [k][j]
      addu $t0, $a2, $t0  # $t0= indirizzo in byte di b[k][j]
      l.d  $f16, 0($t0)    # $f16= 8 byte di b[k][j]

      sll  $t0, $s0, 5     # $t0= i*2^5 ampiezza riga a
      addu $t0, $t0, $s2   # $t0= i*ampiezza_riga+j
      sll  $t0, $t0, 3     # $t0= spiazzamento in byte di [i][k]
      addu $t0, $a1, $t0   # $t0= indirizzo in byte di a[i][k]
      l.d  $f18, 0($t0)    # $f18= 8 byte di a[i][k]

      mul.d $f16, $f18, $f16 # $f16 = a[i][k]*b[k][j]
      add.d $f4, $f4, $f16   # $f4 = c[i][j]+a[i][k]*b[k][j]

      addiu $s2, $s2, 1       # k=k+1
      bne $s2, $t1, L3        # se (k!=32) vai a L3
      s.d $f4, 0($t2)         # c[i][j]=$f4

      addiu $s1, $s1, 1       # j=j+1
      bne $s1, $t1, L2        # se (j!=32) vai a L2
      addiu $s0, $s0, 1       # i=i+1
      bne $s0, $t1, L1        # se (i!=32) vai a L1

      jr $ra








li $v0, 10  #metti in $v0 il valore 10 e chiama
syscall     #syscall per finire l'esecuzione del programma
