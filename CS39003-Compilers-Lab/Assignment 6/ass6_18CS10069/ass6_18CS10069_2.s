	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"        #########################################################\n        ##                 TESTING FUNCTIONS                   ##\n        #########################################################        \n"
.LC1:
	.string	"\n\n        Passing parameter to function :\n        int test(int *a)    \n"
.LC2:
	.string	"\n        Value passed to function: "
.LC3:
	.string	"\n"
.LC4:
	.string	"\n        Address returned from function is: "
.LC5:
	.string	"\n"
.LC6:
	.string	"\n        #####################################################\n        ##              READ AN INTEGER                    ##\n        ##                TESTING I/O                      ##\n        #####################################################\n        \n"
.LC7:
	.string	"\nEnter an Integer : "
.LC8:
	.string	"The integer that was read is : "
.LC9:
	.string	"\n"
	.text	
	.globl	test
	.type	test, @function
test: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$28, %rsp
	movq	%rdi, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	test, .-test
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
	subq	$180, %rsp

	movq 	$.LC0, -40(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	printStr
	movl	%eax, -44(%rbp)
	movl	$3, %eax
	movl 	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	movl 	%eax, -28(%rbp)
	leaq	-28(%rbp), %rax
	movq 	%rax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl 	%eax, -32(%rbp)
	movq 	$.LC1, -64(%rbp)
	movl 	-64(%rbp), %eax
	movq 	-64(%rbp), %rdi
	call	printStr
	movl	%eax, -68(%rbp)
	movq 	$.LC2, -72(%rbp)
	movl 	-72(%rbp), %eax
	movq 	-72(%rbp), %rdi
	call	printStr
	movl	%eax, -76(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printInt
	movl	%eax, -84(%rbp)
	movq 	$.LC3, -88(%rbp)
	movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rdi
	call	printStr
	movl	%eax, -92(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	test
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movq 	$.LC4, -108(%rbp)
	movl 	-108(%rbp), %eax
	movq 	-108(%rbp), %rdi
	call	printStr
	movl	%eax, -112(%rbp)
	movl 	-24(%rbp), %eax
	movq 	-24(%rbp), %rdi
	call	printInt
	movl	%eax, -116(%rbp)
	movq 	$.LC5, -120(%rbp)
	movl 	-120(%rbp), %eax
	movq 	-120(%rbp), %rdi
	call	printStr
	movl	%eax, -124(%rbp)
	movq 	$.LC6, -128(%rbp)
	movl 	-128(%rbp), %eax
	movq 	-128(%rbp), %rdi
	call	printStr
	movl	%eax, -132(%rbp)
	movq 	$.LC7, -136(%rbp)
	movl 	-136(%rbp), %eax
	movq 	-136(%rbp), %rdi
	call	printStr
	movl	%eax, -140(%rbp)
	movl 	-32(%rbp), %eax
	movq 	-32(%rbp), %rdi
	call	readInt
	movl	%eax, -148(%rbp)
	movl	-148(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movq 	$.LC8, -156(%rbp)
	movl 	-156(%rbp), %eax
	movq 	-156(%rbp), %rdi
	call	printStr
	movl	%eax, -160(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printInt
	movl	%eax, -164(%rbp)
	movq 	$.LC9, -168(%rbp)
	movl 	-168(%rbp), %eax
	movq 	-168(%rbp), %rdi
	call	printStr
	movl	%eax, -172(%rbp)
	movl	$0, %eax
	movl 	%eax, -176(%rbp)
	movl	-176(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 18CS10069"
	.section	.note.GNU-stack,"",@progbits
