.globl _start
_start:
b       reset
_TEXT_BASE:
.word   0x1000000
.globl _armboot_start
_armboot_start:
.word _start

.globl _bss_start
_bss_start:
.word __bss_start

reset:
adr     r0, _start             
ldr     r1, _TEXT_BASE          
cmp     r0, r1                  
ldr     r2, _armboot_start
ldr     r3, _bss_start
sub     r2, r3, r2              
add     r2, r0, r2              

copy_loop:
ldmia   r0!, {r3-r10}           
stmia   r1!, {r3-r10}           
cmp     r0, r2                  
ble     copy_loop
stack_setup:
bl      c_entry
