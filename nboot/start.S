/*
label: .word value 
: Places the 4-byte value at the address assigned (by the linker) to label
*/    

/* _start on flash address is from 0x34000000 
   #define CONFIG_SYS_FLASH_BASE   0x34000000
*/

.globl _start
_start:
b       reset

/* Address _TEXT_BASE value is 4bytes 0x10000000 */

_TEXT_BASE:
.word   0x1000000

/* Address _armboot_start value is 4bytes _start is virtual address "_start" define in nboot.lds */

.globl _armboot_start
_armboot_start:
.word _start

/* Address _bss_start value is 4bytes _start is virtual address "__bss_start" define in nboot.lds */

.globl _bss_start
_bss_start:
.word __bss_start

reset:

/*load address of _start , this should be addrsss in RAM (calulate from PC) to r0 */

adr     r0, _start 

/*load content in addres _TETXT_BASE into r1*/

ldr     r1, _TEXT_BASE          
cmp     r0, r1                  
ldr     r2, _armboot_start
ldr     r3, _bss_start

/*Calculate size of code size (bss address - text address)and put into r2*/

sub     r2, r3, r2              

/* r0 (RAM start address ) + code size  = r2 = copy end point address  */

add     r2, r0, r2              

copy_loop:
ldmia   r0!, {r3-r10}           
stmia   r1!, {r3-r10}           

/*Check if r0 (start R0 addess) */

cmp     r0, r2                  
ble     copy_loop
stack_setup:
bl      c_entry
