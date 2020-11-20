	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"\n        ######################################################\n        ##                                                  ##\n        ##         Print first 20 natural numbers           ##\n        ##                   (LOOP)                         ##\n        ##                                                  ##\n        ######################################################\n\n"
.LC1:
	.string	"        "
.LC2:
	.string	" "
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
	subq	$120, %rsp

	movq 	$.LC0, -40(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	printStr
	movl	%eax, -44(%rbp)
	movl	$1, %eax
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
	movl	$0, %eax
	movl 	%eax, -72(%rbp)
	movl	-72(%rbp), %eax
	movl 	%eax, -24(%rbp)
.L2: 
	movl	$20, %eax
	movl 	%eax, -80(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-80(%rbp), %eax
	jl .L4
	jmp .L5
.L3: 
	movl	-24(%rbp), %eax
	movl 	%eax, -84(%rbp)
	addl 	$1, -24(%rbp)
	jmp .L2
.L4: 
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printInt
	movl	%eax, -92(%rbp)
	movq 	$.LC2, -96(%rbp)
	movl 	-96(%rbp), %eax
	movq 	-96(%rbp), %rdi
	call	printStr
	movl	%eax, -100(%rbp)
	movl	$1, %eax
	movl 	%eax, -104(%rbp)
	movl 	-28(%rbp), %eax
	movl 	-104(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -108(%rbp)
	movl	-108(%rbp), %eax
	movl 	%eax, -28(%rbp)
	jmp .L3
.L5: 
	movl	$0, %eax
	movl 	%eax, -116(%rbp)
	movl	-116(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 18CS10069"
	.section	.note.GNU-stack,"",@progbits
