%macro color 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2 
    int 80h
%endmacro

section .data

        color_rojo db  1Bh, '[31m','█',0
        long_rojo equ $ - color_rojo
        color_verde db  1Bh, '[32m','█',0
        long_verde equ $ - color_verde
        color_azul db  1Bh, '[34m','█',0
        long_azul equ $ - color_azul
        color_amarillo db 1Bh, '[33m','█',0
        long_amarillo equ $ - color_amarillo
        color_cyan db 1Bh, '[36m','█',0
        long_cyan equ $ - color_cyan
        color_morado db 1Bh, '[35m','█',0
        long_morado equ $ - color_morado
        color_blanco db 1Bh, '[37m','█',0
        long_blanco equ $ - color_blanco

section .text

global _start

_start:

	color color_rojo,long_rojo
	color color_verde,long_verde
	color color_azul,long_azul
	color color_amarillo,long_amarillo
	color color_cyan,long_cyan
	color color_morado,long_morado	
	color color_blanco,long_blanco

    mov eax, 1
    xor ebx, ebx
    int 80h
