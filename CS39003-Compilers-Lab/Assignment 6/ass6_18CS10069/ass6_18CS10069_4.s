	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"\n    #######################################################\n    ##                                                   ##\n    ##      Print first N fibonacci numbers              ##\n    ##         CHECK FOR BINARY OP AND LOOP              ##\n    ##                                                   ##\n    #######################################################\n\n"
.LC1:
	.string	"ENTER THE VALUE FOR N (<=45): "
.LC2:
	.string	"\nYOU ENTERED THE VALUE: "
.LC3:
	.string	"\n\nTHE FIRST "
.LC4:
	.string	" FIBONACCI NUMBERS ARE :\n\n        "
.LC5:
	.string	" "
.LC6:
	.string	" "
.LC7:
	.string	" "
.LC8:
	.string	"\n        "
.LC9:
	.string	"\n"
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
	subq	$236, %rsp

	movq 	$.LC0, -28(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printStr
	movl	%eax, -32(%rbp)
	movq 	$.LC1, -36(%rbp)
	movl 	-36(%rbp), %eax
	movq 	-36(%rbp), %rdi
	call	printStr
	movl	%eax, -40(%rbp)
	leaq	-48(%rbp), %rax
	movq 	%rax, -56(%rbp)
	movl 	-56(%rbp), %eax
	movq 	-56(%rbp), %rdi
	call	readInt
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movq 	$.LC2, -68(%rbp)
	movl 	-68(%rbp), %eax
	movq 	-68(%rbp), %rdi
	call	printStr
	movl	%eax, -72(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	printInt
	movl	%eax, -80(%rbp)
	movq 	$.LC3, -84(%rbp)
	movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rdi
	call	printStr
	movl	%eax, -88(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	printInt
	movl	%eax, -92(%rbp)
	movq 	$.LC4, -96(%rbp)
	movl 	-96(%rbp), %eax
	movq 	-96(%rbp), %rdi
	call	printStr
	movl	%eax, -100(%rbp)
	movl	$0, %eax
	movl 	%eax, -112(%rbp)
	movl	-112(%rbp), %eax
	movl 	%eax, -108(%rbp)
	movl	$1, %eax
	movl 	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl 	%eax, -116(%rbp)
	movl	$0, %eax
	movl 	%eax, -128(%rbp)
	movl	-44(%rbp), %eax
	cmpl	-128(%rbp), %eax
	jg .L2
	jmp .L3
	jmp .L3
.L2: 
	movl 	-108(%rbp), %eax
	movq 	-108(%rbp), %rdi
	call	printInt
	movl	%eax, -132(%rbp)
	jmp .L3
.L3: 
	movq 	$.LC5, -136(%rbp)
	movl 	-136(%rbp), %eax
	movq 	-136(%rbp), %rdi
	call	printStr
	movl	%eax, -140(%rbp)
	movl	$1, %eax
	movl 	%eax, -144(%rbp)
	movl	-44(%rbp), %eax
	cmpl	-144(%rbp), %eax
	jg .L4
	jmp .L5
	jmp .L5
.L4: 
	movl 	-116(%rbp), %eax
	movq 	-116(%rbp), %rdi
	call	printInt
	movl	%eax, -148(%rbp)
	jmp .L5
.L5: 
	movq 	$.LC6, -152(%rbp)
	movl 	-152(%rbp), %eax
	movq 	-152(%rbp), %rdi
	call	printStr
	movl	%eax, -156(%rbp)
	movl	$2, %eax
	movl 	%eax, -160(%rbp)
	movl	-160(%rbp), %eax
	movl 	%eax, -104(%rbp)
.L6: 
	movl	-104(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl .L8
	jmp .L11
.L7: 
	movl	-104(%rbp), %eax
	movl 	%eax, -168(%rbp)
	addl 	$1, -104(%rbp)
	jmp .L6
.L8: 
	movl 	-108(%rbp), %eax
	movl 	-116(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -172(%rbp)
	movl	-172(%rbp), %eax
	movl 	%eax, -124(%rbp)
	movl 	-124(%rbp), %eax
	movq 	-124(%rbp), %rdi
	call	printInt
	movl	%eax, -180(%rbp)
	movq 	$.LC7, -184(%rbp)
	movl 	-184(%rbp), %eax
	movq 	-184(%rbp), %rdi
	call	printStr
	movl	%eax, -188(%rbp)
	movl	-116(%rbp), %eax
	movl 	%eax, -108(%rbp)
	movl	-124(%rbp), %eax
	movl 	%eax, -116(%rbp)
	movl	$10, %eax
	movl 	%eax, -204(%rbp)
	movl 	-104(%rbp), %eax
	cltd
	idivl 	-204(%rbp)
	movl 	%eax, -208(%rbp)
	movl	-208(%rbp), %eax
	movl 	%eax, -200(%rbp)
	movl	$10, %eax
	movl 	%eax, -212(%rbp)
	movl 	-200(%rbp), %eax
	imull 	-212(%rbp), %eax
	movl 	%eax, -216(%rbp)
	movl	-216(%rbp), %eax
	cmpl	-104(%rbp), %eax
	je .L9
	jmp .L7
	jmp .L10
.L9: 
	movq 	$.LC8, -220(%rbp)
	movl 	-220(%rbp), %eax
	movq 	-220(%rbp), %rdi
	call	printStr
	movl	%eax, -224(%rbp)
	jmp .L7
.L10: 
	jmp .L7
.L11: 
	movq 	$.LC9, -228(%rbp)
	movl 	-228(%rbp), %eax
	movq 	-228(%rbp), %rdi
	call	printStr
	movl	%eax, -232(%rbp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 18CS10069"
	.section	.note.GNU-stack,"",@progbits
