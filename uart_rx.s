	.file	"uart_rx.c"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	li	a5,1520
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sll	a5,a5,20
	sw	a5,-24(s0)
	li	a5,1
	sb	a5,-25(s0)
#	li	a5,8192
	lui	a5,2
	add	a0,a5,1408
	li	a1,1
	call	uart_init
	li	a0,83
	call	uart_putchar
	j	.L2
.L4:
	nop
.L3:
	lw	a5,-24(s0)
	add	a5,a5,6
	lbu	a5,0(a5)
	and	a5,a5,0xff
	and	a5,a5,1
	and	a5,a5,0xff
	beq	a5,zero,.L3
	lw	a5,-24(s0)
	lbu	a5,0(a5)
	sb	a5,-26(s0)
	lw	a5,-24(s0)
	lbu	a4,-26(s0)
	sb	a4,0(a5)
.L2:
	lbu	a5,-25(s0)
	bne	a5,zero,.L4
	move	a5,zero
	move	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	main, .-main
	.align	2
	.globl	uart_init
	.type	uart_init, @function
uart_init:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	move	a5,a1
	sb	a5,-37(s0)
	li	a5,1520
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sll	a5,a5,20
	sw	a5,-28(s0)
	lw	a4,-36(s0)
#	li	a5,36864
	lui	a5,9
	add	a5,a5,1536
	bne	a4,a5,.L7
	sb	zero,-17(s0)
	li	a5,-94
	sb	a5,-18(s0)
	j	.L8
.L7:
	lw	a4,-36(s0)
#	li	a5,8192
	lui	a5,2
	add	a5,a5,1408
	bne	a4,a5,.L9
	li	a5,2
	sb	a5,-17(s0)
	li	a5,-117
	sb	a5,-18(s0)
	j	.L8
.L9:
	lw	a4,-36(s0)
#	li	a5,20480
	lui	a5,5
	add	a5,a5,-1280
	bne	a4,a5,.L10
	li	a5,1
	sb	a5,-17(s0)
	li	a5,69
	sb	a5,-18(s0)
	j	.L8
.L10:
	lw	a4,-36(s0)
#	li	a5,57344
	lui	a5,14
	add	a5,a5,256
	bne	a4,a5,.L11
	sb	zero,-17(s0)
	li	a5,108
	sb	a5,-18(s0)
	j	.L8
.L11:
	sb	zero,-17(s0)
	li	a5,54
	sb	a5,-18(s0)
.L8:
	li	a5,1
	sb	a5,-37(s0)
	sb	zero,-29(s0)
	lw	a5,-28(s0)
	add	a5,a5,4
	move	a4,a5
	li	a5,19
	sb	a5,0(a4)
	lw	a5,-28(s0)
	add	a5,a5,3
	move	a4,a5
	li	a5,-58
	sb	a5,0(a4)
	lw	a5,-28(s0)
	sb	zero,0(a5)
	lw	a5,-28(s0)
	add	a5,a5,1
	sb	zero,0(a5)
	lw	a5,-28(s0)
	add	a5,a5,4
	move	a4,a5
	li	a5,-109
	sb	a5,0(a4)
	lw	a5,-28(s0)
	add	a5,a5,1
	move	a4,a5
	lbu	a5,-17(s0)
	sb	a5,0(a4)
	lw	a5,-28(s0)
	lbu	a4,-18(s0)
	sb	a4,0(a5)
	lw	a5,-28(s0)
	add	a5,a5,4
	move	a4,a5
	li	a5,19
	sb	a5,0(a4)
	lw	a5,-28(s0)
	add	a5,a5,3
	move	a4,a5
	lbu	a5,-29(s0)
	sb	a5,0(a4)
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	uart_init, .-uart_init
	.align	2
	.globl	uart_putchar
	.type	uart_putchar, @function
uart_putchar:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	move	a5,a0
	sb	a5,-33(s0)
	li	a5,1520
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sll	a5,a5,20
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	lbu	a4,-33(s0)
	sb	a4,0(a5)
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	uart_putchar, .-uart_putchar
	.ident	"GCC: (GNU) 4.9.2"
