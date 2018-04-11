	.file	"client.cpp"
	.section	.rodata
.LC0:
	.string	"usage:./client<ipaddress>"
	.align 4
.LC1:
	.string	"create socket error:%s(errno:%d\n)"
.LC2:
	.string	"inet_pton error for %s\n"
.LC3:
	.string	"connect error:%s(errno:%d\n)"
.LC4:
	.string	"send msg to server:"
.LC5:
	.string	"send msg error:%s(errno:%d)\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	andl	$-16, %esp
	subl	$4160, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %eax
	movl	%eax, 28(%esp)
	movl	%gs:20, %eax
	movl	%eax, 4156(%esp)
	xorl	%eax, %eax
	cmpl	$2, 8(%ebp)
	je	.L2
	movl	$.LC0, (%esp)
	call	puts
	movl	$0, %eax
	jmp	.L8
.L2:
	movl	$0, 8(%esp)
	movl	$1, 4(%esp)
	movl	$2, (%esp)
	call	socket
	movl	%eax, 40(%esp)
	movl	40(%esp), %eax
	shrl	$31, %eax
	testb	%al, %al
	je	.L4
	call	__errno_location
	movl	(%eax), %ebx
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	strerror
	movl	%ebx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	printf
	movl	$0, %eax
	jmp	.L8
.L4:
	movl	$16, 8(%esp)
	movl	$0, 4(%esp)
	leal	44(%esp), %eax
	movl	%eax, (%esp)
	call	memset
	movw	$2, 44(%esp)
	movl	$6666, (%esp)
	call	htons
	movw	%ax, 46(%esp)
	movl	28(%esp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	leal	44(%esp), %edx
	addl	$4, %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$2, (%esp)
	call	inet_pton
	testl	%eax, %eax
	setle	%al
	testb	%al, %al
	je	.L5
	movl	28(%esp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	movl	$0, %eax
	jmp	.L8
.L5:
	movl	$16, 8(%esp)
	leal	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	connect
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L6
	call	__errno_location
	movl	(%eax), %ebx
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	strerror
	movl	%ebx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$0, %eax
	jmp	.L8
.L6:
	movl	$.LC4, (%esp)
	call	puts
	movl	stdin, %eax
	movl	%eax, 8(%esp)
	movl	$4096, 4(%esp)
	leal	60(%esp), %eax
	movl	%eax, (%esp)
	call	fgets
	leal	60(%esp), %eax
	movl	%eax, (%esp)
	call	strlen
	movl	$0, 12(%esp)
	movl	%eax, 8(%esp)
	leal	60(%esp), %eax
	movl	%eax, 4(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	send
	shrl	$31, %eax
	testb	%al, %al
	je	.L7
	call	__errno_location
	movl	(%eax), %ebx
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	strerror
	movl	%ebx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$.LC5, (%esp)
	call	printf
	movl	$0, %eax
	jmp	.L8
.L7:
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	close
	movl	$0, %eax
.L8:
	movl	4156(%esp), %ecx
	xorl	%gs:20, %ecx
	je	.L9
	call	__stack_chk_fail
.L9:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
