section .data
    format: db "z = %d", 10, 0  ; data bytes z = %d\n\0
section .text
    global main  ; Export main for linker
    extern printf  ; Request linking with printf in linker
sum:
    ; Preamble
    push ebp
    mov ebp, esp

    ; Body
    mov eax, dword [ebp + 8]
    add eax, dword [ebp + 12]

    ; Epilogue
    pop ebp
    ret
discriminant:
    ; Preamble
    push ebp
    mov ebp, esp
    push esi
    sub esp, 4

    ; Body
    mov eax, dword [ebp + 8] ; a
    mov ecx, dword [ebp + 12] ; b
    mov edx, dword [ebp + 16] ; c
    mov esi, 4
    mul esi  ; overwrites edx and eax
    mov dword [esp], eax
    mov eax, dword [ebp + 16]
    mul dword [esp]
    mov dword [esp], eax
    mov eax, ecx
    mul eax
    mov ecx, dword [esp]
    sub eax, ecx

    add esp, 4
    pop esi
    ; Epilogue
    pop ebp
    ret
main:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    push dword 3  ; c
    push dword 2  ; b
    push dword 1  ; a
    call discriminant
    add esp, 12

    push eax  ; result of discriminant
    push format
    call printf
    add esp, 8

    pop edi
    pop esi
    pop ebx

    pop ebp
    ret


