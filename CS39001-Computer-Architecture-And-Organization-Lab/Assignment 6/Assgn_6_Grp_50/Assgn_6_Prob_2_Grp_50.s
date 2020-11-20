# Assignment no.: 6
# Problem no.: 2 [Prime by SQRT Algorithm]
# Semester: 5
# Group no.: 50
# Names of group members: Siba Smarak Panigrahi - 18CS10069
#                         Debajyoti Dasgupta - 18CS30051
.data
newline:
    .asciiz "\n"
msg:
    .asciiz "Enter the number: "
prime_msg:
    .asciiz "The input number is prime"
composite_msg:
    .asciiz "The input number is composite"
err:
    .asciiz "Argument should be greater than or equal to 2\n"
output:
    .asciiz "Required gcd: "

    .text
    .globl main

main: 
    la      $a0, msg                # load address of msg in $a0
    li      $v0, 4                  # $v0 = 4
    syscall                         # syscall to print string

    li		$v0, 5		            # $v0 = 5
    syscall                         # get input integer syscall
    move 	$a0, $v0		        # $a0 = $v0

    li		$t0, 2          		# $t0 = 2
    slt     $t0, $a0, $t0           
    bne		$t0, $zero, Error_Exit	# if $t0 != 0 then Error_Exit
    
    li		$a1, 2		            # $a1 = 2

loop:
    multu	$a1, $a1			    # $a1 * $a1 = Hi and Lo registers
    mflo	$t0					    # copy Lo to $t0
    sltu    $t0, $a0, $t0           
    bne	    $t0, $zero, prime	    # if $t0 != 0 then prime

    mfhi	$t0					    # copy hi to $t0
    bgt	    $t0, $zero, prime	    # if $t0 > 0 then prime
    
    divu	$a0, $a1			    # $a0 / $a1
    mfhi	$t0					    # $t0 = $a0 mod $a1 
    beq		$t0, $zero, composite	# if $t0 == $zero then composite
    addi	$a1, $a1, 1			    # $a1 = $a1 + 1
    j		loop				    # jump to loop

prime:    
    move 	$s0, $a0        		# $s0 = $a0

    la $a0, prime_msg               # load address of prime message string
    li		$v0, 4          		# $v0 = 4
    syscall                         # syscall to print string

    la      $a0, newline            # load address of newline string
    li		$v0, 4          		# $v0 = 4
    syscall                         # syscall to print string

    j		Exit				    # jump to Exit

composite:    
    move 	$s0, $a0		        # $s0 = $a0

    la      $a0, composite_msg      # load address of composite message string
    li		$v0, 4          		# $v0 = 4
    syscall                         # syscall to print string

    la      $a0, newline            # load address of newline string
    li		$v0, 4          		# $v0 = 4
    syscall                         # syscall to print string

Exit:
    li		$v0, 10		            # $v0 = 10
    syscall                         # syscall to exit from the program

Error_Exit:
    la      $a0, err                # load address of err message in $v0
    li		$v0, 4	        	    # $v0 = 4
    syscall                         # syscall to print a string

    j		Exit				    # jump to Exit