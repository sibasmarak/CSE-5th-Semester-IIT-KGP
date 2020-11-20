# Assignment no.: 6
# Problem no.: 1 [Euclid's GCD Algorithm]
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
    .asciiz "Arguments should be positive integers"
output:
    .asciiz "Required gcd: "

    .text
    .globl main

main:
    la      $a0, msg1               # load address of msg1 in $a0
    li      $v0, 4                  # print string syscall
    syscall

    li		$v0, 5		            # $v0 = 5
    syscall                         # get input integer syscall
    move 	$a1, $v0		        # $a1 = $v0
    ble		$a1, $zero, Error_Exit	# if $a1 <= 0 then Error_Exit

    la      $a0, msg2               # load address of msg2 in $a0
    li      $v0, 4                  # print string syscall
    syscall
    
    li		$v0, 5		            # $v0 = 5
    syscall                         # get input integer syscall
    move 	$a0, $v0		        # $a0 = $v0
    ble		$a0, $zero, Error_Exit	# if $a0 <= 0 then Error_Exit


gcd:    
    sltu    $t0, $a0, $a1           # set $t0 if $a0 is less than $a1 
    bne     $t0, $zero, swap        # if $a0 value is greater than $a1, swap their values

    beq		$a1, $zero, print	    # if $a1 == $zero then print

    subu	$a0, $a0, $a1		    # $a0 = $a0 - $a1
    j		gcd 				    # jump to gcd

swap:
    move 	$s0, $a0    		    # $s0 = $a0
    move 	$a0, $a1    		    # $a0 = $a1
    move 	$a1, $s0    		    # $a0 = $s0
    j		gcd 				    # jump to gcd
    
print:    
    move 	$s0, $a0		        # $s0 = $a0

    la      $a0, output             # load address of output in $a0
    li		$v0, 4  		        # $v0 = 4
    syscall                         # syscall to print string

    move 	$a0, $s0		        # $a0 = $s0
    li      $v0, 1                  # $v0 = 1
    syscall                         # syscall to print integer

    la      $a0, newline            # load address of newline in $a0
    li		$v0, 4      		    # $v0 = 4
    syscall                         # syscall to print string

Exit:
    li		$v0, 10		            # $v0 = 10
    syscall                         # syscall to exit from the program

Error_Exit:
    la      $a0, err                # load address of err message in $v0
    li		$v0, 4	        	    # $v0 = 4
    syscall                         # syscall to print a string

    la $a0, newline
    li $v0, 4
    syscall

    j		Exit				    # jump to Exit