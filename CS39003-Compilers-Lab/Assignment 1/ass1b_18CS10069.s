	.file	"ass1b.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"\nGCD of %d, %d, %d and %d is: %d"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp						# save rbp in stack
	movq	%rsp, %rbp					# rbp = rsp, assign rsp to rbp
	subq	$32, %rsp					# allocate some space (32 bytes) on the stack, rsp -= 32
	movl	$45, -20(%rbp)				# Mem[rbp - 20] = 45; assign 45 to a
	movl	$99, -16(%rbp)				# Mem[rbp - 16] = 99; assign 99 to b
	movl	$18, -12(%rbp)				# Mem[rbp - 12] = 18; assign 18 to c
	movl	$180, -8(%rbp)				# Mem[rbp - 8] = 180; assign 180 to d
	movl	-8(%rbp), %ecx				# ecx = Mem[rbp - 8] (ecx stores d), ecx is the fourth argument for call GCD4
	movl	-12(%rbp), %edx				# edx = Mem[rbp - 12] (edx stores c), edx is the third argument for call GCD4
	movl	-16(%rbp), %esi				# esi = Mem[rbp - 16] (esi stores b), esi is the second argument for call GCD4
	movl	-20(%rbp), %eax				# eax = Mem[rbp - 20] (eax stores a)
	movl	%eax, %edi					# edi = eax (edi stores a), edi is the first argument for call GCD4
	call	GCD4						# call GCD4 function with four arguments - edi (first), esi (second), edx (third), and ecx (fourth);
										# equivalent to GCD4(a, b, c, d)

	movl	%eax, -4(%rbp)				# Mem[rbp - 4] = eax (eax contained the return of GCD4, and now Mem[rbp - 4] stores the return value)
	movl	-4(%rbp), %edi				# edi = Mem[rbp - 4] (edi stores result); result = GCD4(a, b, c, d)
	movl	-8(%rbp), %esi				# esi = Mem[rbp - 8] (esi stores d)
	movl	-12(%rbp), %ecx				# ecx = Mem[rbp - 12] (ecx stores c)
	movl	-16(%rbp), %edx				# edx  = Mem[rbp - 16] (edx stores b)
	movl	-20(%rbp), %eax				# eax = Mem[rbp - 20] (eax stores a)
	movl	%edi, %r9d					# r9d = edi (r9d stores result)
	movl	%esi, %r8d					# r8d = esi (r8d stores d)
	movl	%eax, %esi					# esi = eax (esi stores a)
	leaq	.LC0(%rip), %rdi			# rdi = string (.string of .LC0), uses rip relative addressing, rdi is the first argument of the function (here printf), so rdi = &(*(rip + .LC0))
	movl	$0, %eax					# printf is a variable argument function, %al is expected to hold the number of vector register, since here printf has integer argument so eax = 0 (al is the first 8 bits of eax)
	call	printf@PLT					# call printf (with rdi, esi, edx, ecx, r8d, and r9d as arguments) via Procedure Linkage Table (used to call external procedures whose address isn't known at the time of linking)
										# aabove call is equivalent to printf ("\nGCD of %d, %d, %d and %d is: %d",a, b, c, d, result)

	movl	$10, %edi					# edi = '\n'
	call	putchar@PLT					# putchar (with edi argument) via Procedure Linkage Table; equivalent to printf("\n") 
	movl	$0, %eax					# eax = 0 (assign return value 0 to eax)
	leave								# Set rsp to rbp, and then pops the old rbp from the stack
	ret									# pop return address from stack and transfer control back to the return address
	.size	main, .-main
	.globl	GCD4
	.type	GCD4, @function
GCD4:
	pushq	%rbp					# save rbp in stack 					
	movq	%rsp, %rbp				# rbp = rsp, assign rsp to rbp
	subq	$32, %rsp				# allocate some space (32 bytes) on the stack, rsp -= 32
	movl	%edi, -20(%rbp)			# Mem[rbp - 20] = edi, store the first argument in Mem[rbp - 20] (first argument: n1)
	movl	%esi, -24(%rbp)			# Mem[rbp - 24] = esi, store the second argument in Mem[rbp - 24] (second argument: n2)
	movl	%edx, -28(%rbp)			# Mem[rbp - 28] = edx, store the third argument in Mem[rbp - 28] (third argument: n3)
	movl	%ecx, -32(%rbp)			# Mem[rbp - 32] = ecx, store the fourth argument in Mem[rbp - 32] (fourth argument: n4)

	movl	-24(%rbp), %edx			# edx = Mem[rbp - 24] (edx contains n2)
	movl	-20(%rbp), %eax			# eax = Mem[rbp - 20] (eax contains n1)
	movl	%edx, %esi				# esi = edx, esi is the second argument for the upcoming call GCD (esi contains n2)
	movl	%eax, %edi				# edi = eax, edi is the first argument for the upcoming call GCD (edi contains n1)
	call	GCD						# call function GCD with two arguments - edi (first) and esi (second); corresponds to t1 = GCD(n1, n2) 

	movl	%eax, -12(%rbp)			# Mem[rbp - 12] = eax, eax contains the return value of above GCD call (Mem[rbp - 12] = t1)
	movl	-32(%rbp), %edx			# edx = Mem[rbp - 32] (edx contains n4)
	movl	-28(%rbp), %eax			# eax = Mem[rbp - 28] (eax contains n3)
	movl	%edx, %esi				# esi = edx, esi is the second argument for the upcoming call GCD (esi contains n4)
	movl	%eax, %edi				# edi = eax, edi is the first argument for the upcoming call GCD (edi contains n3)
	call	GCD						# call function GCD with two arguments - edi (first) and esi (second); corresponds to t2 = GCD(n3, n4)

	movl	%eax, -8(%rbp)			# Mem[rbp - 8] = eax, eax contains the return value of above GCD call (Mem[rbp - 8] = t2)
	movl	-8(%rbp), %edx			# edx = Mem[rbp - 8] (edx contains t2)
	movl	-12(%rbp), %eax			# eax = Mem[rbp - 12] (eax contains t1)
	movl	%edx, %esi				# esi = edx, esi is the second argument for the upcoming call GCD (esi contains t2)
	movl	%eax, %edi				# edi = eax, edi is the first argument for the upcoming call GCD (edi contains t1)
	call	GCD						# call function GCD with two arguments - edi (first) and esi (second); corresponds to t3 = GCD(t1, t2)

	movl	%eax, -4(%rbp)			# Mem[rbp - 4] = eax, eax contains the return value of above GCD call (Mem[rbp - 4] = t3)
	movl	-4(%rbp), %eax			# eax = Mem[rbp - 4], store the return value of call GCD4 in rax (eax contains t3, return value of GCD4)
	leave							# Set rsp to rbp, and pop top of stack into rbp
	ret								# pop return address from stack and transfer control back to the return address
	.size	GCD4, .-GCD4
	.globl	GCD
	.type	GCD, @function
GCD:
	pushq	%rbp					# save rbp in stack 
	movq	%rsp, %rbp				# rbp = rsp, assign rsp to rbp
	movl	%edi, -20(%rbp)			# Mem[rbp - 20] = edi i.e., the first argument (Mem[rbp - 20] contains num1)
	movl	%esi, -24(%rbp)			# Mem[rbp - 24] = esi i.e., the second argument (Mem[rbp - 24] contains num2)
	jmp	.L6							# unconditional jump to .L6
.L7:
	movl	-20(%rbp), %eax			# eax = Mem[rbp - 20] (remainder after the division)
	cltd							# cltd sign-extends eax into edx:eax (necessary for the upcoming signed division)
	idivl	-24(%rbp)				# Signed divide %rdx:%rax by Mem[rbp - 24] (signed division of num1 by num2)
	movl	%edx, -4(%rbp)			# Mem[rbp - 4] = edx (Mem[rbp - 4] = t1, the remainder of above division); temp = num1 % num2
	movl	-24(%rbp), %eax			# eax = Mem[rbp - 24]; eax = num2
	movl	%eax, -20(%rbp)			# Mem[rbp - 20] = eax (Mem[rbp - 20] = num1); num1 = num2
	movl	-4(%rbp), %eax			# eax = Mem[rbp - 4]; eax = temp
	movl	%eax, -24(%rbp)			# Mem[rbp - 24] = eax (Mem[rbp - 24] = num2); num2 = temp
.L6:
	movl	-20(%rbp), %eax			# eax = Mem[rbp - 20] (eax contains num1)

	cltd							# cltd sign-extends eax into edx:eax (necessary for the upcoming signed division)
	idivl	-24(%rbp)				# Signed divide %rdx:%rax by Mem[rbp - 24] (signed division of eax by num2)
	movl	%edx, %eax				# eax = edx, eax now contains the remainder of above division, since edx contained the remainder (eax contains num1 % num2)
	testl	%eax, %eax				# evaluates result = eax & eax, sets condition code; checks num1 % num2 != 0 (checks if the remainder zero or not)
	jne	.L7							# jump to .L7 if the result above is not equal to 0 (decided with the help of condition code)

	movl	-24(%rbp), %eax			# eax = Mem[rbp - 24]; eax has the return value to call GCD with num1 and num2
	popq	%rbp					# restore rbp from the stack
	ret								# pop return address from stack and transfer control back to the return address
	.size	GCD, .-GCD
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
