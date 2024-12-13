; Program to find and output all prime numbers less than the input number

; For running in asm8086 replace the code above start tag with this code. 
;.model small
;.stack 100h
;.data
;prompt db "Enter a number: $"
;newline db 0Dh, 0Ah, "$"
;.code
;main proc

;also add this code to the end of program
;mov ah,4ch
;int 21h
;main endp
;end main

org 100h

section .data

prompt db "Enter a number: $"

newline db 0Dh, 0Ah, "$"

section .bss

section .text

start:

    ; Print prompt

    mov dx, prompt

    mov ah, 09h       ; DOS interrupt to display string

    int 21h



    ; Read single-character input using DOS interrupt

    mov ah, 01h       ; DOS interrupt to read a single character

    int 21h

    sub al, '0'       ; Convert ASCII to digit

    mov cl, al        ; Store the digit in CL



    ; Convert to integer

    xor ch, ch        ; Clear higher byte of CX

    mov bx, cx        ; Store the number in BX



    ; Check primes from 2 to BX-1

    mov cx, 2         ; Start checking from 2

prime_loop:

    cmp cx, bx        ; If CX >= input number, stop

    jge exit



    ; Check if CX is prime

    push cx           ; Save current number

    mov dx, 0         ; Clear DX for division

    mov si, 2         ; Start divisor from 2



is_prime:

    cmp si, cx        ; If divisor >= number, it is prime

    jge print_prime

    mov ax, cx        ; Dividend = current number

    xor dx, dx        ; Clear DX for division

    div si            ; AX = CX / SI, DX = CX % SI

    cmp dx, 0         ; Check if remainder is 0

    je not_prime      ; If divisible, not prime

    inc si            ; Else, try next divisor

    jmp is_prime



not_prime:

    pop cx            ; Restore CX

    inc cx            ; Check next number

    jmp prime_loop



print_prime:

    ; Print prime number (CX)

    mov ax, cx

    call print_number

    pop cx            ; Restore CX

    inc cx            ; Check next number

    jmp prime_loop



exit:

    ; Exit program

    mov ah, 4Ch       ; DOS interrupt to terminate program

    int 21h



; Subroutine to print number in AX

print_number:

    push ax           ; Save AX

    xor cx, cx        ; Clear CX to store digits



store_digits:

    xor dx, dx        ; Clear DX for division

    mov bx, 10        ; Base 10 divisor

    div bx            ; AX = AX / 10, DX = remainder

    add dl, '0'       ; Convert remainder to ASCII

    push dx           ; Store digit on stack

    inc cx            ; Increment digit count

    test ax, ax       ; Check if AX == 0

    jnz store_digits



print_digits:

    pop dx            ; Get digit from stack

    mov ah, 02h       ; DOS interrupt to display character

    mov dl, al        ; Load digit into DL

    int 21h           ; Write digit

    loop print_digits



    ; Print newline

    mov dx, newline

    mov ah, 09h       ; DOS interrupt to display string

    int 21h



    pop ax            ; Restore AX

    ret
