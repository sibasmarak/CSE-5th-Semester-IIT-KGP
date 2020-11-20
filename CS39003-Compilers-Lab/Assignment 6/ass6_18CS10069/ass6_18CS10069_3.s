	.file	"test.c"
	.comm	a,4,4
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	1
	.globl	t00
	.data
	.align 4
	.type	t00, @object
	.size	t00, 4
t00:
	.long	1
	.comm	c,1,1
	.globl	d
	.type	d, @object
	.size	d, 1
d:
	.byte	0
	.globl	t01
	.type	t01, @object
	.size	t01, 1
t01:
	.byte	0
	.section	.rodata
.LC0:
	.string	"    ==== Entered into the function ====\n"
.LC1:
	.string	"    ==== Returning from function   ====\n"
.LC2:
	.string	"\n    ####################################################\n    ##                                                ##\n    ##           Tracing function steps               ##\n    ##      Adding two numbers in a Function          ##\n    ##                                                ##\n    ####################################################\n    \n\n"
.LC3:
	.string	"\n    Enter two numbers :\n"
.LC4:
	.string	"\n    Enter first numbers  : "
.LC5:
	.string	"    Enter second numbers : "
.LC6:
	.string	"\n    ==== Passing to the function   ====\n"
.LC7:
	.string	"\n    Sum is equal to : "
.LC8:
	.string	"\n"
	.text	
	movl	$1, %eax
	movl 	%eax, 0(%rbp)
	movl	0(%rbp), %eax
	movl 	%eax, 0(%rbp)
	movb	$0, 0(%rbp)
	movl	0(%rbp), %eax
	movl 	%eax, 0(%rbp)
	.globl	add
	.type	add, @function
add: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$144, %rsp
	movq	%rdi, -20(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$2, %eax
	movl 	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movl	$10, %eax
	movl 	%eax, -80(%rbp)
	movq 	$.LC0, -92(%rbp)
	movl 	-92(%rbp), %eax
	movq 	-92(%rbp), %rdi
	call	printStr
	movl	%eax, -96(%rbp)
	movl 	-20(%rbp), %eax
	movl 	-16(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$2, %eax
	movl 	%eax, -108(%rbp)
	movl	-108(%rbp), %eax
	movl 	%eax, -36(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jge .L2
	jmp .L3
	jmp .L4
.L2: 
	movl	-20(%rbp), %eax
	movl 	%eax, -116(%rbp)
	addl 	$1, -20(%rbp)
	jmp .L4
.L3: 
	movl 	-20(%rbp), %eax
	movl 	-16(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl 	%eax, -28(%rbp)
.L4: 
	movq 	$.LC1, -128(%rbp)
	movl 	-128(%rbp), %eax
	movq 	-128(%rbp), %rdi
	call	printStr
	movl	%eax, -132(%rbp)
	movl	-24(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	add, .-add
	.globl	main
	.type	main, @function
main: 
.LFB1:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$208, %rsp

	movl	$2, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$10, %eax
	movl 	%eax, -76(%rbp)
	movq 	$.LC2, -104(%rbp)
	movl 	-104(%rbp), %eax
	movq 	-104(%rbp), %rdi
	call	printStr
	movl	%eax, -108(%rbp)
	movq 	$.LC3, -112(%rbp)
	movl 	-112(%rbp), %eax
	movq 	-112(%rbp), %rdi
	call	printStr
	movl	%eax, -116(%rbp)
	movq 	$.LC4, -120(%rbp)
	movl 	-120(%rbp), %eax
	movq 	-120(%rbp), %rdi
	call	printStr
	movl	%eax, -124(%rbp)
	leaq	-96(%rbp), %rax
	movq 	%rax, -132(%rbp)
	movl 	-132(%rbp), %eax
	movq 	-132(%rbp), %rdi
	call	readInt
	movl	%eax, -136(%rbp)
	movl	-136(%rbp), %eax
	movl 	%eax, -84(%rbp)
	movq 	$.LC5, -144(%rbp)
	movl 	-144(%rbp), %eax
	movq 	-144(%rbp), %rdi
	call	printStr
	movl	%eax, -148(%rbp)
	leaq	-96(%rbp), %rax
	movq 	%rax, -152(%rbp)
	movl 	-152(%rbp), %eax
	movq 	-152(%rbp), %rdi
	call	readInt
	movl	%eax, -156(%rbp)
	movl	-156(%rbp), %eax
	movl 	%eax, -88(%rbp)
	movq 	$.LC6, -164(%rbp)
	movl 	-164(%rbp), %eax
	movq 	-164(%rbp), %rdi
	call	printStr
	movl	%eax, -168(%rbp)
	movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rdi
movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rsi
	call	add
	movl	%eax, -176(%rbp)
	movl	-176(%rbp), %eax
	movl 	%eax, -92(%rbp)
	movq 	$.LC7, -184(%rbp)
	movl 	-184(%rbp), %eax
	movq 	-184(%rbp), %rdi
	call	printStr
	movl	%eax, -188(%rbp)
	movl 	-92(%rbp), %eax
	movq 	-92(%rbp), %rdi
	call	printInt
	movl	%eax, -196(%rbp)
	movq 	$.LC8, -200(%rbp)
	movl 	-200(%rbp), %eax
	movq 	-200(%rbp), %rdi
	call	printStr
	movl	%eax, -204(%rbp)
	movl	-24(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 18CS10069"
	.section	.note.GNU-stack,"",@progbits
