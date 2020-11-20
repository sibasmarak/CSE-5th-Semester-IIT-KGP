	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"\nENTERING THE FUNCTION FOR ( I ) : "
.LC1:
	.string	"\n    #####################################################\n    ##                                                 ##\n    ##       RECURSIVE FIBONACCI SIMULATION            ##\n    ##            TEST FUNCTION CALLS                  ##\n    ##            AND LIBRARY MYL.H                    ##\n    ##                                                 ##\n    #####################################################\n    \n"
.LC2:
	.string	"ENTER THE NUMBER N FOR FIBOACCI: "
.LC3:
	.string	"ENTERED NUMBER "
.LC4:
	.string	"\n"
.LC5:
	.string	"------------TESTING RECURSIVE FIBOACCI-----------\nENTERING THE FUNCTION: \n"
.LC6:
	.string	"\n\nReturned from recursive fibonacci function successfully!!\n"
.LC7:
	.string	"----------- SUCCESSFULLY TERMINATED ----------"
	.text	
	.globl	fib
	.type	fib, @function
fib: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$120, %rsp
	movq	%rdi, -20(%rbp)
	movq 	$.LC0, -28(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printStr
	movl	%eax, -32(%rbp)
	movl 	-20(%rbp), %eax
	movq 	-20(%rbp), %rdi
	call	printInt
	movl	%eax, -40(%rbp)
	movl	$1, %eax
	movl 	%eax, -48(%rbp)
	movl 	-20(%rbp), %eax
	movl 	-48(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl	$0, %eax
	movl 	%eax, -64(%rbp)
	movl	-44(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jle .L2
	jmp .L3
	jmp .L4
.L2: 
	movl	$1, %eax
	movl 	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	jmp .L4
.L3: 
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	fib
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movl 	%eax, -56(%rbp)
	movl	$1, %eax
	movl 	%eax, -84(%rbp)
	movl 	-44(%rbp), %eax
	movl 	-84(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -88(%rbp)
	movl	-88(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	fib
	movl	%eax, -96(%rbp)
	movl	-96(%rbp), %eax
	movl 	%eax, -60(%rbp)
	movl 	-56(%rbp), %eax
	movl 	-60(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -104(%rbp)
	movl	-104(%rbp), %eax
	movl 	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
.L4: 
	movl	$1, %eax
	movl 	%eax, -112(%rbp)
	movl	-112(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	fib, .-fib
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

	movl	$5, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$2, %eax
	movl 	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movl 	%eax, -32(%rbp)
	movl	$5, %eax
	movl 	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl .L7
	jmp .L8
	jmp .L9
.L7: 
	movl	-24(%rbp), %eax
	movl 	%eax, -60(%rbp)
	addl 	$1, -24(%rbp)
	jmp .L9
.L8: 
	movl 	-24(%rbp), %eax
	movl 	-32(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -64(%rbp)
	movl	-64(%rbp), %eax
	movl 	%eax, -40(%rbp)
.L9: 
	movq 	$.LC1, -76(%rbp)
	movl 	-76(%rbp), %eax
	movq 	-76(%rbp), %rdi
	call	printStr
	movl	%eax, -80(%rbp)
	movq 	$.LC2, -84(%rbp)
	movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rdi
	call	printStr
	movl	%eax, -88(%rbp)
	leaq	-56(%rbp), %rax
	movq 	%rax, -96(%rbp)
	movl 	-96(%rbp), %eax
	movq 	-96(%rbp), %rdi
	call	readInt
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movq 	$.LC3, -108(%rbp)
	movl 	-108(%rbp), %eax
	movq 	-108(%rbp), %rdi
	call	printStr
	movl	%eax, -112(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	printInt
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl 	%eax, -40(%rbp)
	movq 	$.LC4, -128(%rbp)
	movl 	-128(%rbp), %eax
	movq 	-128(%rbp), %rdi
	call	printStr
	movl	%eax, -132(%rbp)
	movq 	$.LC5, -136(%rbp)
	movl 	-136(%rbp), %eax
	movq 	-136(%rbp), %rdi
	call	printStr
	movl	%eax, -140(%rbp)
	movl	$0, %eax
	movl 	%eax, -148(%rbp)
	movl	-148(%rbp), %eax
	movl 	%eax, -144(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	fib
	movl	%eax, -156(%rbp)
	movl	-156(%rbp), %eax
	movl 	%eax, -144(%rbp)
	movq 	$.LC6, -164(%rbp)
	movl 	-164(%rbp), %eax
	movq 	-164(%rbp), %rdi
	call	printStr
	movl	%eax, -168(%rbp)
	movq 	$.LC7, -172(%rbp)
	movl 	-172(%rbp), %eax
	movq 	-172(%rbp), %rdi
	call	printStr
	movl	%eax, -176(%rbp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 18CS10069"
	.section	.note.GNU-stack,"",@progbits
