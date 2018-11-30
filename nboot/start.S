/*
label: .word value 
: Places the 4-byte value at the address assigned (by the linker) to label
*/    

/* _start on flash address is from 0x34000000 
   #define CONFIG_SYS_FLASH_BASE   0x34000000
*/

.globl _start
_start:
/*
#include "load_constant_value_to_regs.S"
*/
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

/*load address of _start , this should be addrsss in flash (calulate from PC) to r0 (0x34000000) */

adr     r0, _start 

/*load content in addres _TETXT_BASE into r1 (0x10000000)  */

ldr     r1, _TEXT_BASE                     

/* Test if at RAM , if yes, go to RAM to excute code from start again  */

cmp     r0, r1                 
beq     stack_setup

ldr     r2, _armboot_start
ldr     r3, _bss_start

/*Calculate size of code size (bss address - text address)and put into r2 (0x34000080)*/

sub     r2, r3, r2              

/* r0 (RAM start address ) + code size  = r2 = copy end point address   */

add     r2, r0, r2              

/* cp code from r0 (flash start address)  to r1 (RAM start address)*/
/* ldmia r0!, {r3-r10}
   Load Multiple Increment After
   Load data from address in r0 , r0+4 , ....r0+28, to r3, r4 ....r10
   and then r0 content = address in r0 + 32 (Because of ! sign)

   stmia
   STore Mutliple Increment After
   store data from address in r3 ... r10 to address in r1 
   and then r1 = r1 + 32 (Because of ! sign)
*/

copy_loop:
ldmia   r0!, {r3-r10}      
stmia   r1!, {r3-r10}           

/*Check if r0 (start R0 addess) is the R2 code end address inf flash */

cmp     r0, r2                  
ble     copy_loop

/* Jump to RAM (0x1000000) to excute again */
ldr     pc, _TEXT_BASE

stack_setup:

ldr     pc, _c_entry
_c_entry:
 .word c_entry
