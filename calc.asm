section .bss
    choice resb 2
    buffer resb 10
    numf resq 1
    nums resq 1
    res resq 1
    rem resq 1
    temp resb 1
    eaxc resd 1
    ebxc resd 1
    ecxc resd 1
    edxc resd 1
section .data
    hello DB "choose your option:",0xA,"add >> +",0xA,"subtract >> -",0xA,"multiply >> *",0xA,"divide >> /",0xA,">"
    hellol equ $-hello
    wo DB "wrong option"
    fnum DB "enter first number: "
    fnuml equ $-fnum
    snum DB "enter second number: "
    snuml equ $-snum
    remainder DB " remainder: "
    reml equ $-remainder
    ten dd 10
section .text
    global _start
    
_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, hellol
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, choice
    mov edx, 2
    int 0x80
    
    mov byte [choice+eax-1], 0x00
    cmp byte [choice], '+'
    je addl
    cmp byte [choice], '-'
    je subl
    cmp byte [choice], '*'
    je mull
    cmp byte [choice], '/'
    je divl
    jne err
err:
    mov eax, 4
    mov ebx, 1
    mov ecx, wo
    mov edx, 12
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
addl:
    mov eax, 4
    mov ebx, 1
    mov ecx, fnum
    mov edx, fnuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp loop
done:
    mov [numf], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, snum
    mov edx, snuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop2:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done2
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp loop2
done2:
    mov [nums], eax

    mov eax, [numf]
    mov ebx, [nums]
    add eax, ebx
    
    mov [res], eax

    mov eax, [res]
    mov ecx, buffer+10
    mov byte [ecx], 0
loop3:
    xor edx, edx
    div dword [ten]
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz loop3
    
    mov eax, 4
    mov ebx, 1
    mov edx, buffer + 10
    sub edx, ecx
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
subl:
    mov eax, 4
    mov ebx, 1
    mov ecx, fnum
    mov edx, fnuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop4:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done4
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp loop4
done4:
    mov [numf], eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, snum
    mov edx, snuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop5:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done5
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp loop5
done5:
    mov [nums], eax

    mov eax, [numf]
    mov ebx, [nums]
    sub eax, ebx
    mov [res], eax
    
    mov eax, [res]
    
    mov [ebxc], ebx
    mov [ecxc], ecx
    mov [edxc], edx
    
    test eax, eax
    jns loop6s
    
    neg eax
    mov [eaxc], eax
    
    mov eax, 4
    mov ebx, 1
    mov byte [temp], 0x2D
    mov ecx, temp
    mov edx, 1
    int 0x80
    
    mov eax, [eaxc]
    mov ebx, [ebxc]
    mov edx, [edxc]
    mov ecx, [ecxc]
loop6s:
    mov ecx, buffer+10
    mov byte [ecx], 0
loop6:
    xor edx, edx
    div dword [ten]
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz loop6
    
    mov eax, 4
    mov ebx, 1
    mov edx, buffer+10
    sub edx, ecx
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
mull:
    mov eax, 4
    mov ebx, 1
    mov ecx, fnum
    mov edx, fnuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop7:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done7

    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    test eax, eax
    jnz loop7
done7:
    mov [numf], eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, snum
    mov edx, snuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop8:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done8
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    test eax, eax
    jnz loop8
done8:
    mov [nums], eax
    
    mov eax, [numf]
    mov ebx, [nums]
    imul eax, ebx
    mov [res], eax
    
    mov eax, [res]
    mov ecx, buffer+10
    mov byte [ecx], 0
loop9:
    xor edx, edx
    div dword [ten]
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz loop9
    
    mov eax, 4
    mov ebx, 1
    mov edx, buffer+10
    sub edx, ecx
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
divl:
    mov eax, 4
    mov ebx, 1
    mov ecx, fnum
    mov edx, fnuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop10:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done10
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    test eax, eax
    jnz loop10
done10:
    mov [numf], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, snum
    mov edx, snuml
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    mov byte [buffer+eax-1], 0x00
    
    mov esi, buffer
    xor eax, eax
    xor ebx, ebx
loop11:
    mov bl, byte [esi]
    cmp bl, 0x00
    je done11
    
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    test eax, eax
    jnz loop11
done11:
    mov [nums], eax
    
    mov eax, [numf]
    mov ebx, [nums]
    xor edx, edx
    div ebx
    mov [res], eax
    mov [rem], edx
    
    mov eax, [res]
    mov ecx, buffer+10
    mov byte [ecx], 0
loop12:
    xor edx, edx
    div dword [ten]
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz loop12
    
    mov eax, 4
    mov ebx, 1
    mov edx, buffer+10
    sub edx, ecx
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, remainder
    mov edx, reml
    int 0x80
    
    mov eax, [rem]
    mov ecx, buffer+10
    mov byte [ecx], 0
    
loop13:
    xor edx, edx
    div dword [ten]
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz loop13
    
    mov eax, 4
    mov ebx, 1
    mov edx, buffer+10
    sub edx, ecx
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80
