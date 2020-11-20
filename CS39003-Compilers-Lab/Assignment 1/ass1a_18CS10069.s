	.file	"ass1a.c"
	.text
	.section	.rodata
.LC0:
	.string	"\nThe greater number is: %d"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp						# save rbp in stack
	movq	%rsp, %rbp					# rbp = rsp, assign rsp to rbp
	subq	$16, %rsp					# allocate some space (16 bytes) on the stack, rsp -= 16
	movl	$45, -8(%rbp)				# Mem[rbp - 8] = 45; assign 45 to num1
	movl	$68, -4(%rbp)				# Mem[rbp - 4] = 68; assign 68 to num2
	movl	-8(%rbp), %eax				# eax = Mem[rbp - 8] (eax assigned num1)
	cmpl	-4(%rbp), %eax				# evaluate result = eax - Mem[rbp - 4], sets condition code; i.e., result = num1 <= num2
	jle	.L2								# jump to .L2 if result is less or equal (determined from condition code)

	movl	-8(%rbp), %eax				# eax = Mem[rbp - 8]; 'greater' assigned num1 (when num1 > num2)
	movl	%eax, -12(%rbp)				# Mem[rbp - 12] = eax (Mem[rbp -12] contains 'greater')
	jmp	.L3								# unconditional jump to .L3 
.L2:
	movl	-4(%rbp), %eax				# eax = Mem[rbp - 4]; 'greater' assigned num2 (when num1 <= num2)
	movl	%eax, -12(%rbp)				# Mem[rbp - 12] = eax (Mem[rbp -12] contains 'greater'), next moves down to .L3
.L3:
	movl	-12(%rbp), %eax				# eax = Mem[rbp - 12] (eax contains 'greater')
	movl	%eax, %esi					# esi = eax (esi assigned 'greater'), esi is the second argument to the function (here printf)
	leaq	.LC0(%rip), %rdi			# rdi = string (.string of .LC0), uses rip relative addressing, rdi is the first argument of the function (here printf), so rdi = &(*(rip + .LC0))
	movl	$0, %eax					# printf is a variable argument function, %al is expected to hold the number of vector register, since here printf has integer argument so eax = 0 (al is the first 8 bits of eax)
	call	printf@PLT					# calls printf (with rdi and rsi as arguments) via Procedure Linkage Table (used to call external procedures or functions whose address isn't known at the time of linking)
										# above call is equivalent to printf ("\nThe greater number is: %d", greater)
	movl	$0, %eax					# eax = 0; corresponds to return 0
	leave								# Set rsp to rbp, and then pops the old rbp from the stack
	ret									# pop return address from stack and transfer control back to the return address
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
