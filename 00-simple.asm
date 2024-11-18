; Compiler: x86-64 gcc 14.2
; Flags: -O3
; (https://godbolt.org/)

;---------------------------------------------------
; With exceptions
.LC0:
        .string "A Error"
fn(int) [clone .part.0]:
        push    rax
        mov     edi, 8
        call    __cxa_allocate_exception
        xor     edx, edx
        mov     esi, OFFSET FLAT:typeinfo for char const*
        mov     QWORD PTR [rax], OFFSET FLAT:.LC0
        mov     rdi, rax
        call    __cxa_throw
fn(int):
        test    edi, edi
        js      .L5
        xor     eax, eax
        ret
fn(int) [clone .cold]:
.L5:
        push    rax
        call    fn(int) [clone .part.0]
one():
        push    rcx
        call    fn(int) [clone .part.0]
        mov     rdi, rax
        dec     rdx
        je      .L11
        call    _Unwind_Resume
.L11:
        call    __cxa_begin_catch
        call    __cxa_end_catch
        or      eax, -1
        pop     rdx
        ret

;---------------------------------------------------
; Without exceptions

.LC0:
        .string "ERROR"
fn(int):
        test    edi, edi
        js      .L7
        xor     eax, eax
        ret
.L7:
        push    rax
        mov     edi, OFFSET FLAT:.LC0
        xor     eax, eax
        call    printf
        ud2
one():
        sub     rsp, 8
        mov     edi, OFFSET FLAT:.LC0
        xor     eax, eax
        call    printf
        ud2
