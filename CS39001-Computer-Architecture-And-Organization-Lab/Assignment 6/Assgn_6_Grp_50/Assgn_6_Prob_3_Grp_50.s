# Assignment no.: 6
# Problem no.: 3 [Left Shift Multiplication Algorithm]
# Semester: 5
# Group no.: 50
# Names of group members: Siba Smarak Panigrahi - 18CS10069
#                         Debajyoti Dasgupta - 18CS30051
.data
newline:
    .asciiz "\n"
msg1:
    .asciiz "Enter first number: "
msg2:
    .asciiz "Enter second number: "
err:
    .asciiz "Arguments should be non-negative integers"
    .asciiz "Enter second number: "
bigint:
    .asciiz "Arguments should be unsigned 16 bit numbers"
handle_neg:
    .asciiz "2^32"
output:
    .asciiz "Required product: "

    .text
    .globl main

main: 
    la      $a0, msg1               # load address of msg1 in $a0
    li      $v0, 4                  # $v0 = 4
    syscall                         # syscall to print string

    li		$v0, 5          		# $v0 = 5
    syscall                         # sysall to read integer
    move 	$a1, $v0        		# $a1 = $v0
    blt		$a1, $zero, Error_Exit	# if $a1 < $zero then Error_Exit
    
    la $a0, msg2
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $a0, $v0
    blt $a0, 0, Error_Exit          # if $a0 < $zero then Error_Exit

    li		$v0, 0		            # $v0 = 0


    li		$t0, 1	        	    # $t0 = 1
    sll     $t0, $t0, 16            # $t0 = 2^16
    bge		$a0, $t0, big_input	    # if $a0 >= $t0 then big_input
    bge		$a1, $t0, big_input	    # if $a1 >= $t0 then big_input


seq_mult_unsigned:  
    beq		$a0, $zero, print	    # if $a0 == $zero then Exit
    andi    $t0, $a0, 1 
    beq		$t0, $zero, shift	    # if $t0 == $zero then shift
    addu	$v0, $v0, $a1		    # $v0 = $v0 + $a1
    
shift:                              
    srl     $a0, $a0, 1             # right shift the first multiplicand
    sll     $a1, $a1, 1             # left shift  the second multiplicand
    j       seq_mult_unsigned       # go back to the caller function

print:    
    move 	$s0, $v0		        # $s0 = $v0

    la $a0, output                  # print the output message
    li $v0, 4
    syscall
    blt		$s0, $zero, handler	    # if $s0 < $zero then handler

print_num:                          # print the output number
    move $a0, $s0
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

Exit:                               # exit from the program
    li $v0, 10
    syscall    

Error_Exit:                         # handle error
    la $a0, err
    li $v0, 4
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    j Exit

handler:                            # handle negative values
    la $a0, handle_neg
    li $v0, 4
    syscall

    j print_num

big_input:                          # handle if the input is not unsigned 64 bit
    la $a0, bigint
    li $v0, 4
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    j		Exit				# jump to Exit
    