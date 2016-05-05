	.file	"uart_auto2.c"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	sw	zero,-20(s0)
	li	a5,1520
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sll	a5,a5,20
	sw	a5,-28(s0)
#	li	a5,114688
	lui	a5,28
	add	a0,a5,512
	li	a1,1
	call	uart_init
	li	a0,13
	call	uart_putchar
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	add	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-20(s0)
#	li	a5,8192
	lui	a5,2
	add	a5,a5,-193
	ble	a4,a5,.L3
	li	a0,83
	call	uart_putchar
	sw	zero,-20(s0)
	j	.L4
.L5:
	lw	a5,-20(s0)
	add	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a4,-20(s0)
#	li	a5,8192
	lui	a5,2
	add	a5,a5,-193
	ble	a4,a5,.L5
	nop
.L6:
	call	autobaud
	move	a4,a0
	li	a5,2
	beq	a4,a5,.L6
.L8:
	nop
.L7:
	lw	a5,-28(s0)
	add	a5,a5,6
	lbu	a5,0(a5)
	and	a5,a5,0xff
	and	a5,a5,1
	and	a5,a5,0xff
	beq	a5,zero,.L7
	lw	a5,-28(s0)
	lbu	a5,0(a5)
	sb	a5,-29(s0)
	lw	a5,-28(s0)
	lbu	a4,-29(s0)
	sb	a4,0(a5)
	j	.L8
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
	bne	a4,a5,.L10
	sb	zero,-17(s0)
	li	a5,-94
	sb	a5,-18(s0)
	j	.L11
.L10:
	lw	a4,-36(s0)
#	li	a5,8192
	lui	a5,2
	add	a5,a5,1408
	bne	a4,a5,.L12
	li	a5,2
	sb	a5,-17(s0)
	li	a5,-117
	sb	a5,-18(s0)
	j	.L11
.L12:
	lw	a4,-36(s0)
#	li	a5,20480
	lui	a5,5
	add	a5,a5,-1280
	bne	a4,a5,.L13
	li	a5,1
	sb	a5,-17(s0)
	li	a5,69
	sb	a5,-18(s0)
	j	.L11
.L13:
	lw	a4,-36(s0)
#	li	a5,57344
	lui	a5,14
	add	a5,a5,256
	bne	a4,a5,.L14
	sb	zero,-17(s0)
	li	a5,108
	sb	a5,-18(s0)
	j	.L11
.L14:
	sb	zero,-17(s0)
	li	a5,54
	sb	a5,-18(s0)
.L11:
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
	.align	2
	.globl	uart_getchar
	.type	uart_getchar, @function
uart_getchar:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	li	a5,1520
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sll	a5,a5,20
	sw	a5,-24(s0)
	nop
.L17:
	lw	a5,-24(s0)
	add	a5,a5,6
	lbu	a5,0(a5)
	and	a5,a5,0xff
	and	a5,a5,1
	and	a5,a5,0xff
	beq	a5,zero,.L17
	lw	a5,-24(s0)
	lbu	a5,0(a5)
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	move	a0,a5
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	uart_getchar, .-uart_getchar
	.align	2
	.globl	autobaud
	.type	autobaud, @function
autobaud:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	li	a5,1520
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sll	a5,a5,20
	sw	a5,-28(s0)
	nop
.L20:
	lw	a5,-28(s0)
	add	a5,a5,6
	lbu	a5,0(a5)
	and	a5,a5,0xff
	and	a5,a5,32
	and	a5,a5,0xff
	beq	a5,zero,.L20
#	li	a5,114688
	lui	a5,28
	add	a0,a5,512
	call	setbaud
	call	uart_getchar
	move	a5,a0
	sb	a5,-29(s0)
	lbu	a4,-29(s0)
	li	a5,13
	bne	a4,a5,.L21
#	li	a5,114688
	lui	a5,28
	add	a5,a5,512
	sw	a5,-20(s0)
	j	.L22
.L21:
	lbu	a4,-29(s0)
	li	a5,230
	bne	a4,a5,.L23
#	li	a5,57344
	lui	a5,14
	add	a5,a5,256
	sw	a5,-20(s0)
	j	.L22
.L23:
	lbu	a4,-29(s0)
	li	a5,28
	bne	a4,a5,.L24
#	li	a5,36864
	lui	a5,9
	add	a5,a5,1536
	sw	a5,-20(s0)
	j	.L22
.L24:
	lbu	a4,-29(s0)
	li	a5,224
	bne	a4,a5,.L25
#	li	a5,20480
	lui	a5,5
	add	a5,a5,-1280
	sw	a5,-20(s0)
	j	.L22
.L25:
	lbu	a4,-29(s0)
	li	a5,128
	bne	a4,a5,.L26
#	li	a5,16384
	lui	a5,4
	add	a5,a5,-1984
	sw	a5,-20(s0)
	j	.L22
.L26:
	lbu	a5,-29(s0)
	bne	a5,zero,.L27
#	li	a5,8192
	lui	a5,2
	add	a0,a5,1408
	call	setbaud
	call	uart_getchar
	move	a5,a0
	sb	a5,-29(s0)
	lbu	a4,-29(s0)
	li	a5,13
	bne	a4,a5,.L28
#	li	a5,8192
	lui	a5,2
	add	a5,a5,1408
	sw	a5,-20(s0)
	j	.L22
.L28:
	lbu	a4,-29(s0)
	li	a5,230
	bne	a4,a5,.L29
#	li	a5,4096
	lui	a5,1
	add	a5,a5,704
	sw	a5,-20(s0)
	j	.L22
.L29:
	lbu	a4,-29(s0)
	li	a5,120
	bne	a4,a5,.L30
#	li	a5,4096
	lui	a5,1
	add	a5,a5,-1696
	sw	a5,-20(s0)
	j	.L22
.L30:
	lbu	a4,-29(s0)
	li	a5,128
	bne	a4,a5,.L31
	li	a5,1200
	sw	a5,-20(s0)
	j	.L22
.L31:
	li	a5,2
	j	.L32
.L27:
	li	a5,2
	j	.L32
.L22:
	lw	a0,-20(s0)
	call	setbaud
	move	a5,zero
.L32:
	move	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	autobaud, .-autobaud
	.align	2
	.globl	setbaud
	.type	setbaud, @function
setbaud:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	li	a5,1520
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sll	a5,a5,20
	sw	a5,-28(s0)
	lw	a4,-36(s0)
	li	a5,1200
	bne	a4,a5,.L34
	li	a5,20
	sb	a5,-17(s0)
	li	a5,88
	sb	a5,-18(s0)
	j	.L35
.L34:
	lw	a4,-36(s0)
#	li	a5,4096
	lui	a5,1
	add	a5,a5,-1696
	bne	a4,a5,.L36
	li	a5,10
	sb	a5,-17(s0)
	li	a5,44
	sb	a5,-18(s0)
	j	.L35
.L36:
	lw	a4,-36(s0)
#	li	a5,4096
	lui	a5,1
	add	a5,a5,704
	bne	a4,a5,.L37
	li	a5,5
	sb	a5,-17(s0)
	li	a5,22
	sb	a5,-18(s0)
	j	.L35
.L37:
	lw	a4,-36(s0)
#	li	a5,8192
	lui	a5,2
	add	a5,a5,1408
	bne	a4,a5,.L38
	li	a5,2
	sb	a5,-17(s0)
	li	a5,-117
	sb	a5,-18(s0)
	j	.L35
.L38:
	lw	a4,-36(s0)
#	li	a5,16384
	lui	a5,4
	add	a5,a5,-1984
	bne	a4,a5,.L39
	li	a5,1
	sb	a5,-17(s0)
	li	a5,-78
	sb	a5,-18(s0)
	j	.L35
.L39:
	lw	a4,-36(s0)
#	li	a5,20480
	lui	a5,5
	add	a5,a5,-1280
	bne	a4,a5,.L40
	li	a5,1
	sb	a5,-17(s0)
	li	a5,69
	sb	a5,-18(s0)
	j	.L35
.L40:
	lw	a4,-36(s0)
#	li	a5,36864
	lui	a5,9
	add	a5,a5,1536
	bne	a4,a5,.L41
	sb	zero,-17(s0)
	li	a5,-94
	sb	a5,-18(s0)
	j	.L35
.L41:
	lw	a4,-36(s0)
#	li	a5,57344
	lui	a5,9
	add	a5,a5,256
	bne	a4,a5,.L42
	sb	zero,-17(s0)
	li	a5,108
	sb	a5,-18(s0)
	j	.L35
.L42:
	sb	zero,-17(s0)
	li	a5,54
	sb	a5,-18(s0)
.L35:
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
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	setbaud, .-setbaud
	.ident	"GCC: (GNU) 4.9.2"
