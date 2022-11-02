;  H E L P E R  M A C R O S
;  =============================
;
;  These macros illustrate how assembly uses the stack for passing values around,
;  in particular passing arguments to "functions".
;  Note that the macros are expanded before the actual assembler begins, you
;  could as well do that manually.

; Reference the 32-bit value that has been `push`ed nth-most recently.
%define w32FrStck(n) [esp + 4 * (n)]

; Invoke a function with two arguments passed via the stack.
%macro call2 3
  push dword %3  ; second argument
  push dword %2  ; first argument
  call %1
  add esp, 2*4   ; clean up stack
%endmacro

; Read the two arguments in a function call.
%macro funargs2 2
  mov %1, w32FrStck(1)
  mov %2, w32FrStck(2)
%endmacro

; Read the three arguments in a function call.
%macro funargs3 3
  mov %1, w32FrStck(1)
  mov %2, w32FrStck(2)
  mov %3, w32FrStck(3)
%endmacro

; Invoke a function with one 32-bit value returned,
; and one argument passed via the stack.
%macro call1_1 3
  push dword 0   ; result
  push dword %3  ; first argument
  call %2
  add esp, 4     ; clean up argument from stack
  pop %1         ; retrieve result
%endmacro

; Invoke a function with one 32-bit value returned,
; and three arguments passed via the stack.
%macro call3_1 5
  push dword 0   ; result
  push dword %5  ; third argument
  push dword %4  ; second argument
  push dword %3  ; first argument
  call %2
  add esp, 3*4   ; clean up arguments from stack
  pop %1         ; retrieve result
%endmacro

; Give the return value for a function with one argument.
%macro funret1_1 1
  mov w32FrStck(2), %1
  ret
%endmacro
