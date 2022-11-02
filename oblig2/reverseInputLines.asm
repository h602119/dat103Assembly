; R E V E R S I N G
; =================
; void reverse()
; Recursively read in words, until none are found anymore.
; After the recursive calls are done, write out the word again.
reverseInputLines:

  call1_1 edx, readLine, input_buffer

  cmp edx, 0          ; If nothing was read, it means the
  jg there_is_input   ; input is already fully processed, i.e.
  ret                 ; that this call is finished.

there_is_input:
  
  mov eax, esp   ; Original stack pointer
  sub eax, edx   ; Enough space to store the read string

  mov ebx, 3     ; Complement of round-to-multiples-of-4 bitmask
  not ebx   
  and eax, ebx   ; Align stack location to 32-bit
  mov esp, eax   ; Allocate the space on the stack

  mov eax, 0     ; Index into the buffer when copying

  ; CODE FROM HERE__

mov [onlyIncrement], eax ;reset the onlyincrement to 0

;  edx is the numbers of chars in the input word
mov ecx, edx ; sets ecx to be equal to the string length (edx)


loop:           ;the loop push words to stack 4 bytes at a time


mov ebx, [input_buffer+eax]
mov [esp+eax], ebx              ;pushes four bytes to the top of the stack

add eax, 4                      ;increments eax by 4 since we push 4 bytes at a time (or round up)
mov ebx, [onlyIncrement]
inc ebx                         ;increments the length of the words - have to store values in ebx to inc
mov [onlyIncrement], ebx        ;move the incremented number back to onlyIncrement

sub ecx,4                       ;decrement ecx with 4 since we now pushed 4 bytes off the word
cmp ecx,0                       ;compare ecx to 0 if it is greater than zero, continue loop
jg loop

push edx                        ;save edx
mov eax, [onlyIncrement]
push eax                        ;save onlyIncrement

call reverseInputLines          ;this calls recursivley until no input from user is detected

pop eax
mov [onlyIncrement], eax        ;retireve the onlyincrement pushed before recursive call

print:                          ;this loop should pop all words and print them

mov eax, 4                      ;system print function call
mov ebx, 1
pop edx                         ;number of bytes to print from edx, retrieved from before recursive call
mov ecx, esp                    ;pop top of stack into dword at addr in ecx, should be the correct 4 bytes

int 0x80                        ;call the interrupt


mov ebx, 0                      ;set ebx to 0 to avoid complications
mov eax, 0                      ;set eax to 0 to avoid complications

addMethod:                      ;this method multiplies with 4 - since the multiply function didnt work
inc ebx
add eax, [onlyIncrement]        ;add onlyIncrement (number of pushes) to eax
cmp ebx, 4                      ;after 4 loops eax should be total number of bytes pushed
jl addMethod


add esp, eax                    ;moves the stack pointer back so we dont get a stack overflow

push LINE_SHIFT

mov eax, 4
mov ebx, 1
mov ecx, esp ; prints a lineshift
mov edx, 1
int 0x80

pop edx                         ;pop the lineshift, this edx dont have any functionality

ret                             ;return statement
