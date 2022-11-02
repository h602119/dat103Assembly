; W O R D  R E A D I N G
; ======================
; int readLine(tgtAddress)
; Make use of the fact that the words (or punctuation-hashes)
; are already split up to lines.
; Result is the number of characters that were in the line.
readLine:
   push dword 0             ; initialize counter
readLine_charLoop:
   mov eax,SYS_READ
   mov ebx,STDIN
   mov ecx, w32FrStck(2)    ; address
   ; Read one byte/char at a time. Note that this is not efficient.
   mov edx, 1
   int 80h

   cmp eax, 0               ; if we're at EOF, nothing is read and we
   je finished_readLine     ; should finish reading.

   mov ecx, w32FrStck(2)    ; address
   movzx eax, byte [ecx]    ; the byte we just read
   cmp eax, byte LINE_SHIFT ; check whether we're done
   je finished_readLine

   mov ecx, w32FrStck(2)    ; increment address to read to
   inc ecx
   mov w32FrStck(2), ecx
   mov ebx, w32FrStck(0)    ; increment character-in-line counter
   inc ebx
   mov w32FrStck(0), ebx
   jmp readLine_charLoop

finished_readLine:
   pop ebx                  ; finished character-counter
   funret1_1 ebx
