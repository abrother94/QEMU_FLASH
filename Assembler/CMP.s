	.data 
arr:	.byte 10,20,30
eoa:
	.text
start:
	ldr	r0, =0x101
	ldr	r1, =0x2
	tst	r0, r1 		@test bit 2 if set or not or use tst r0, #2 
stop:	b stop
