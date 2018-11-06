	.text
	b start
str:	.asciz "Hello World!!!!"
	.equ	NULL, 0
	.align

start:	ldr	r0, =str	@r0= &str
	mov	r1, #0

loop:	ldrb	r2, [r0], #1 	@ r2= *(r0++)
	add	r1, r1, #1	@ r1= r1 + 1
	cmp	r2, #NULL
	bne	loop
	sub	r1, r1, #1	@ r1= r1 - 1

stop: b stop
