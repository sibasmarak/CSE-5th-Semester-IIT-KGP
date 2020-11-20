	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"\n        #############################################################\n        ##                                                         ##\n        ##            PRINT LOWER TRIANGLE PATTERN                 ##\n        ##    CHECK FOR CONDITIONAL STATEMENT AND NESTED LOOP      ##\n        ##                                                         ##\n        #############################################################\n\n        \n"
.LC1:
	.string	"        ENTER SIZE OF THE TRIANGLE "
.LC2:
	.string	"\n        "
.LC3:
	.string	"*"
	.text	
	.globl	main
	.type	main, @function
main: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$144, %rsp

	movq 	$.LC0, -32(%rbp)
	movl 	-32(%rbp), %eax
	movq 	-32(%rbp), %rdi
	call	printStr
	movl	%eax, -36(%rbp)
	movq 	$.LC1, -40(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	printStr
	movl	%eax, -44(%rbp)
	leaq	-68(%rbp), %rax
	movq 	%rax, -72(%rbp)
	movl 	-72(%rbp), %eax
	movq 	-72(%rbp), %rdi
	call	readInt
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movl 	%eax, -52(%rbp)
	movl	$0, %eax
	movl 	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl 	%eax, -56(%rbp)
.L2: 
	movl	$2, %eax
	movl 	%eax, -92(%rbp)
	movl 	-92(%rbp), %eax
	imull 	-52(%rbp), %eax
	movl 	%eax, -96(%rbp)
	movl	$1, %eax
	movl 	%eax, -100(%rbp)
	movl 	-96(%rbp), %eax
	movl 	-100(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -104(%rbp)
	movl	-56(%rbp), %eax
	cmpl	-104(%rbp), %eax
	jl .L4
	jmp .L8
.L3: 
	movl	-56(%rbp), %eax
	movl 	%eax, -108(%rbp)
	addl 	$1, -56(%rbp)
	jmp .L2
.L4: 
	movq 	$.LC2, -112(%rbp)
	movl 	-112(%rbp), %eax
	movq 	-112(%rbp), %rdi
	call	printStr
	movl	%eax, -116(%rbp)
	movl	$0, %eax
	movl 	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl 	%eax, -60(%rbp)
.L5: 
	movl	-60(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jle .L7
	jmp .L3
.L6: 
	movl	-60(%rbp), %eax
	movl 	%eax, -128(%rbp)
	addl 	$1, -60(%rbp)
	jmp .L5
.L7: 
	movq 	$.LC3, -132(%rbp)
	movl 	-132(%rbp), %eax
	movq 	-132(%rbp), %rdi
	call	printStr
	movl	%eax, -136(%rbp)
	jmp .L6
	jmp .L3
.L8: 
	movl	$0, %eax
	movl 	%eax, -140(%rbp)
	movl	-140(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 18CS10069"
	.section	.note.GNU-stack,"",@progbits
