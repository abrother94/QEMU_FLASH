	.data	
val1:	.byte 0xbe 
val2:	.byte 0xef
result:	.space 4

	.text	

	@ Copy datat to RAM
start:
	ldr	r2, =data_size 
	ldr	r0, =flash_sdata
	ldr	r1, =ram_sdata
copy:
	ldrb	r4, [r0], #1
	strb	r4, [r1], #1
	subs	r2, r2, #1
	bne 	copy

	@  Add and store result

	ldr	r0, =val1	@r0= &val1
	ldr	r1, =val2	@r1= &val2
	
	ldr	r2, [r0]	@r2= *r0
	ldr	r3, [r1]	@r3= *r1

	add	r4, r2, r3
	ldr	r0, =result	@r0= &result
	str	r4, [r0]	@*r0= r4

stop:	b stop
