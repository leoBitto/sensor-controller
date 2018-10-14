.data
myFile: .asciiz "/home/leonardo/Documenti/ASSEMBLY/Project_ADE_17_18/Data test/pendenzaIN.txt"      # filename for input
buffer: .space 1024
.text
main:
# Open file for reading

li   $v0, 13          # system call for open file
la   $a0, myFile      # input file name
li   $a1, 0           # flag for reading
li   $a2, 0           # mode is ignored
syscall               # open a file
move $s0, $v0         # save the file descriptor


# reading from file just opened

li   $v0, 14        # system call for reading from file
move $a0, $s0       # file descriptor
la   $a1, buffer    # address of buffer from which to read
li   $a2,  1100       # hardcoded buffer length
syscall             # read from file


# Printing File Content
li  $v0, 4          # system Call for PRINT STRING
la  $a0, buffer     # buffer contains the values
syscall             # print int

li $v0, 10      # Finish the Program
syscall
