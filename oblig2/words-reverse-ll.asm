%include "macros.asm"
	
section .data
   STDIN equ 0
   STDOUT equ 1
   SYS_READ equ 3
   SYS_WRITE equ 4
   LINE_SHIFT equ 10
   buf_size equ 4096
   onlyIncrement dd 0 ; initializes the only increment counter we use this to count how many words we have


section .bss
   input_buffer resb buf_size

;  M A I N  E N T R Y  P O I N T
;  =============================
section .text
global _start
_start:
    ; calling reversal function
        call reverseInputLines

    ; sys_exit system call
        mov eax, 1
        mov ebx, 0
        int 0x80 ;call interrupt


%include "readLine.asm"

%include "reverseInputLines.asm"
