# Assignment no.: 6
# Problem no.: 4 [Booth’s Multiplication Algorithm]
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
err_overflow:
    .asciiz "Arguments should be 16-bit signed integers!"
output:
    .asciiz "Required product: "

    .text
    .globl main

main:
    # prompt to take the first input
    la $a0, msg1
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $a1, $v0

    # prompt to take the second input
    la $a0, msg2
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $a0, $v0

    # load immediate values of -2^15 and (2^15 - 1) for sanity check
    li $t0, -32768
    li $t1, 32767			
  
    # if any of the inputs is less than -2^15
    # head to Error_Exit_Overflow branch to print the error message
    slt $t2, $a0, $t0
    bne	$t2, $zero, Error_Exit_Overflow	
    slt $t2, $a1, $t0
    bne	$t2, $zero, Error_Exit_Overflow	

    # if any of the inputs is greater than 2^15 - 1
    # head to Error_Exit_Overflow branch to print the error message
    bgt	$a0, $t1, Error_Exit_Overflow
    bgt	$a1, $t1, Error_Exit_Overflow

    beq $a1, $t0, swap
    
pre_process:
    # handle special case when both the input are -2^15
    beq $a1, $t0, handle_special
    # move into lower-half
    andi $a0, $a0, 0x0000ffff

    # move into upper-half
    sll $a1, $a1, 16                    
    
    li $t4,0                            # for LSB 
    li $t5,16                           # for counter

    move $v0, $a0                       # $v0 stores the result
    j seq_mult_booth

swap:
    move 	$s0, $a1		# $s0 = $a1
    move 	$a1, $a0		# $a1 = $a0
    move 	$a0, $s0		# $a0 = $s0
    j pre_process

# seq_mult_booth
seq_mult_booth:
    andi $t3, $v0, 1                    # $t3 stores the LSB of $s1
    beq $t3, $t4, shift                 # if 00 or 11 -> goto shift
    beq $t3, $zero, end_run             # if 01 -> goto end_run; run starts; add
    sub $v0, $v0, $a1                   # if 10 -> run begins; subtract
    j shift                             # goto shift

# run ends
end_run:
    add $v0, $v0, $a1

# shifting occurs
shift:
    sra $v0, $v0, 1                     # arithmetic right shift
    addi $t5, -1                        # decrement the counter
    move $t4, $t3                       # move the LSB to $t4
    bne $t5, $zero, seq_mult_booth      # if counter is non-zero, goto seq_mult_booth

print:
# print the result   
    move $s0, $v0

    la $a0, output
    li $v0, 4
    syscall

    move $a0, $s0
    li $v0, 1
    syscall   

    la $a0, newline
    li $v0, 4
    syscall

# exit branch
Exit:
    li $v0, 10
    syscall 

# Error_Exit_Overflow branch
# prints error message and exits whenever an overflow occurs in user inputs 
Error_Exit_Overflow:
    la $a0, err_overflow
    li $v0, 4
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    j Exit

handle_special:
    li		$a0, 1		    # $a0 = 1
    sll     $a0, $a0, 30    # store 2^30
    move 	$v0, $a0		# $v0 = $a0

    j print
