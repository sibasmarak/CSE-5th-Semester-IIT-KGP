# Assignment no.: 7
# Problem no.: 1 [String Operation in MIPS-32]
# Semester: 5
# Group no.: 50
# Names of group members: Siba Smarak Panigrahi - 18CS10069
#                         Debajyoti Dasgupta - 18CS30051

.data
    string: .space 100
    opening_message:  .asciiz "Enter input string (less than 100 chars): \n"
    convert_message:  .asciiz "Converted string : "

.text

main:
    la $a0, opening_message     # load the message
    li $v0, 4                   # $v0 = 4
    syscall                     # print the message

    li $v0, 8                   # $v0 = 8
    la $a0, string              # load the address of the space allocated for the string
    li $a1, 100                 # allot the byte space for string
    syscall
    move $s0, $a0               # $s0 = $a0 

    li $t0, 0                   # $t0 = 0 -> counter


# Loop to convert the string into lower-case
# traverse through all elements of the string
# if upper case -> convert to lower case
# else leave the character as it is
traverse:
    lb $t1, string($t0)         # Load a character from the t0-th position in the space allocated
    beq $t1, 0, print           # If all elements are traversed, print

check:
    blt $t1, 'A', not_upper     # If less than char 'A', continue
    bgt $t1, 'Z', not_upper     # If greater than char 'Z', continue
    add $t1, $t1, 32            # If uppercase, then add 32
    sb $t1, string($t0)         # Store it back to t0-th position in string

#if not upper case character
# then increment the counter $t0 and continue
not_upper: 
    addi $t0, $t0, 1
    j traverse

# when the counter is zero
# we have completely traversed the string
# print the converted string
print:
    la $a0, convert_message     # load and print "capitalized" string
    li $v0, 4
    syscall

    move $a0, $s0               # primary address = s0 address (load pointer)
    li $v0, 4                   # print string
    syscall

# Exit
exit:
    li $v0, 10                  
    syscall