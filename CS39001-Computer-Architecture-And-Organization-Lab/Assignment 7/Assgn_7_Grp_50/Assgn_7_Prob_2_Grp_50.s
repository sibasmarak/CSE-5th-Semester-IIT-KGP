# Assignment no.: 7
# Problem no.: 2 [Insertion Sort in MIPS-32]
# Semester: 5
# Group no.: 50
# Names of group members: Siba Smarak Panigrahi - 18CS10069
#                         Debajyoti Dasgupta - 18CS30051

.data
newline:
    .asciiz "\n"
blank:
    .asciiz " "
msg:
    .asciiz "Enter 8 numbers (one in each line): "
sorted_msg:
    .asciiz "Sorted Array is : \n"
numbers: 
    .word 8, 7, 6, 5, 4, 3, 2, 1
length: 
    .word 8
 
 .text
 .globl main
main:
    li		$v0, 4		        # $v0 = 4
    la		$a0, msg		    # load address of message
    syscall
        
    li		$v0, 4		        # $v0 = 4
    la		$a0, newline	    # load address of newline string
    syscall

    la		$a0, numbers		
    

read:

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 0($a0)		        # 0($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 4($a0)		        # 4($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 8($a0)		        # 8($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 12($a0)		    # 12($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 16($a0)		    # 16($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 20($a0)		    # 20($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 24($a0)		    # 24($a0) = $v0

    li		$v0, 5		        # $v0 = 5
    syscall
    sw 	$v0, 28($a0)		    # 28($a0) = $v0

############################################################################
#                                                                          #
#        Use $v0 to hold firstUnsortedIndex                                #
#        Use $v1 to hold testIndex                                         #
#        Use $a0 to hold elementToInsert                                   #
#        Use $a1 to hold value of array                                    #
#        Use $a2 to calculate the address of array in                      #
#        Use $a3 to hold the value of (length-1)                           #
#        Use $t0 to hold the base/starting address of the numbers array    #
#                                                                          #
############################################################################

InsertionSort:
    jal		for_init				# jump to for_init and save position to $ra
    jal		outer_for				# jump to outer_for and save position to $ra
    jal		print			    	# jump to print and save position to $ra
    j		exit			    	# jump to exit

for_init: 
    li      $v0, 1
    lw      $a3, length
    sub     $a3, $a3, 1
    la      $t0, numbers
    jr		$ra			    		# jump to $ra

outer_for: 
    bgt     $v0, $a3, end_for
    sub     $v1, $v0, 1
    mul     $a2, $v0, 4             # address of numbers[i]= base addr of numbers + i*(element size)
    add     $a2, $t0, $a2
    lw      $a0, 0($a2)

while_loop: 
    blt     $v1, 0, end_while_loop
    mul     $a2, $v1, 4             # address of numbers[i]= base addr of numbers + i*(element size)
    add     $a2, $t0, $a2
    lw      $a1, 0($a2)
    ble     $a1, $a0, end_while_loop
    sw      $a1, 4($a2)
    sub     $v1, $v1, 1
    j       while_loop

end_while_loop:
    mul     $a2, $v1, 4             # address of numbers[i]= base addr of numbers + i*(element size)
    add     $a2, $t0, $a2
    sw      $a0, 4($a2)
    addi    $v0, $v0, 1
    j       outer_for

end_for:
    jr		$ra					    # jump to $ra
    
exit:
    li      $v0, 10                 # system call to exit
    syscall

print:
    la		$a0, sorted_msg		     
    li		$v0, 4		            # $v0 = 4
    syscall

    la		$s1, numbers		 
    
    lw		$a0, 0($s1)	    	 
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall
    
    lw		$a0, 4($s1)	    	 
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    lw		$a0, 8($s1)	    	
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    lw		$a0, 12($s1)	    
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    lw		$a0, 16($s1)	     
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    lw		$a0, 20($s1)	     
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    lw		$a0, 24($s1)	     
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    lw		$a0, 28($s1)	     
    li		$v0, 1      		# $v0 = 1
    syscall                     # print integer
    la		$a0, blank		     
    li		$v0, 4	        	# $v0 = 4
    syscall

    la		$a0, newline		 
    li		$v0, 4	        	# $v0 = 4
    syscall                     # print integer
    
    jr		$ra					# jump to $ra