%include        "./macros.asm"

section .data
	cuadro db '█'
		lencuadro  equ $ - cuadro
	
	;--Contadores--
	contI db 0	;contador de intentos
		lencontI  equ $ - contI
	contD db 0	;contador de digitos
		lencontD  equ $ - contD
	
	;--Validaciones--
	numero db 4          ; número de dígitos
	digito1 db 0        ; dígitos separados
	digito2 db 0
	digito3 db 0
	digito4 db 0
	
	;--Mensajes de error--
	mensaje_error db 'Error: Todos los dígitos deben estar entre 0 y 5', 0
	mensaje_error2 db 'Error: El número debe tener 4 dígitos', 0

	
	;--Banco de Códigos--
	cod0 db '5021'
		lenCod0  equ $-cod0
	cod1 db '4130'
		lenCod1  equ $-cod1
	cod2 db '5054'
		lenCod2  equ $-cod2
	cod3 db '2345'
		lenCod3  equ $-cod3
	cod4 db '5013'
		lenCod4  equ $-cod4
	cod5 db '3204'
		lenCod5  equ $-cod5
	cod6 db '5231'
		lenCod6  equ $-cod6
	cod7 db '4302'
		lenCod7  equ $-cod7
	cod8 db '5124'
		lenCod8  equ $-cod8
	cod9 db '3412'
		lenCod9 equ $-cod9
	
	;--Variables de Impresion en Pantalla--
	msgMenu        db '                   Bienvenido al Juego de Mastermind',10,10
		db '            Seleccione una opcion:',10
		db '             1. Iniciar Juego 1',10
		db '             2. Salir',10
	lenMsgMenu    equ $ - msgMenu

        msgSubMenu1     db '                    Bienvenido al Juego de Mastermind',10,10
        	lenMsgSubMenu1  equ $ - msgSubMenu1
        msgSubMenu2     db 'Color / Código',10
        	lenMsgSubMenu2  equ $ - msgSubMenu2
        msgSubMenu3     db 'Rojo = 0',10
        	lenMsgSubMenu3  equ $ - msgSubMenu3
        msgSubMenu4     db 'Verde = 1',10
        	lenMsgSubMenu4  equ $ - msgSubMenu4
        msgSubMenu5     db 'Azul = 2',10
        	lenMsgSubMenu5  equ $ - msgSubMenu5
        msgSubMenu6     db 'Amarillo = 3',10
        	lenMsgSubMenu6  equ $ - msgSubMenu6
        msgSubMenu7     db 'Cyan = 4',10
        	lenMsgSubMenu7  equ $ - msgSubMenu7
        msgSubMenu8     db 'Morado = 5',10,10
        	lenMsgSubMenu8  equ $ - msgSubMenu8
	
	;--Mensajes a Imprimir--
        msgIntento db 'Intento '
		lenMsgIntento    equ $ - msgIntento

        msgEva db '                    Evaluación',10
		lenMsgEva    equ $ - msgEva
	
	msgCod db 'Ingrese código: '
		lenMsgCod    equ $ - msgCod
	
	msgSalida db 'Felicidades, lo ha conseguido!',10
		lenMsgSalida    equ $ - msgSalida
	
	saltoLinea db '',10
		lenSaltoLinea    equ $ - saltoLinea
		
	printA db 'número válido',10
		lenprintA    equ $ - printA
	printX db 'número inválido',10
		lenprintX    equ $ - printX

section .bss
	entrada resb 1
	aleatorio resb 1

section .text
	global _start

_start:    ;marca la entrada
	xor ecx, ecx
	xor ebx, ebx
	xor eax, eax
	xor al, al

Codigo:					;elegir un código del banco
	demeAleatorio 1
	mov al, byte[aleatorio]
	cmp al, '0'
	je Caso0
	cmp al, '1'
	je Caso1
	cmp al, '2'
	je Caso2
	cmp al, '3'
	je Caso3
	cmp al, '4'
	je Caso4
	cmp al, '5'
	je Caso5
	cmp al, '6'
	je Caso6
	cmp al, '7'
	je Caso7
	cmp al, '8'
	je Caso8
	cmp al, '9'
	je Caso9

Caso0:
	mov esi, cod0
	jmp Menu
Caso1:
	mov esi, cod1
	jmp Menu
Caso2:
	mov esi, cod2
	jmp Menu
Caso3:
	mov esi, cod3
	jmp Menu
Caso4:
	mov esi, cod4
	jmp Menu
Caso5:
	mov esi, cod5
	jmp Menu
Caso6:
	mov esi, cod6
	jmp Menu
Caso7:
	mov esi, cod7
	jmp Menu
Caso8:
	mov esi, cod8
	jmp Menu
Caso9:
	mov esi, cod9
	jmp Menu

Menu:						;interfaz gráfica del programa
	xor al, al
	imprimeEnPantalla msgMenu, lenMsgMenu
	leeTeclado
	mov cl, [entrada]
	cmp cl, '2'
	je FIN
	imprimeEnPantalla msgSubMenu1, lenMsgSubMenu1
	imprimeEnPantalla msgSubMenu2, lenMsgSubMenu2
	cambiaColor color_rojo
        imprimeEnPantalla cuadro, lencuadro
	cambiaColor color_default
	imprimeEnPantalla msgSubMenu3, lenMsgSubMenu3
	cambiaColor color_verde
        imprimeEnPantalla cuadro, lencuadro
	cambiaColor color_default
	imprimeEnPantalla msgSubMenu4, lenMsgSubMenu4
	cambiaColor color_azul
        imprimeEnPantalla cuadro, lencuadro
	cambiaColor color_default
	imprimeEnPantalla msgSubMenu5, lenMsgSubMenu5
	cambiaColor color_amarillo
        imprimeEnPantalla cuadro, lencuadro
	cambiaColor color_default
	imprimeEnPantalla msgSubMenu6, lenMsgSubMenu6
	cambiaColor color_cyan
        imprimeEnPantalla cuadro, lencuadro
	cambiaColor color_default
	imprimeEnPantalla msgSubMenu7, lenMsgSubMenu7
	cambiaColor color_morado
        imprimeEnPantalla cuadro, lencuadro
	cambiaColor color_default
	imprimeEnPantalla msgSubMenu8, lenMsgSubMenu8
	
	imprimeEnPantalla msgIntento, lenMsgIntento
	imprimeEnPantalla entrada, 1
	imprimeEnPantalla [contI], lencontI
	imprimeEnPantalla msgEva, lenMsgEva
	imprimeEnPantalla msgCod, lenMsgCod
InputC:					;recibe la entrada del ususario
	xor ecx, ecx
	leeTeclado
	mov ecx, [entrada]
	xor esi, esi
ValRango:				;validación de que cada dígito este entre 0 y 5
	mov al, byte[entrada + esi]
	cmp al, '0'
	jl NoValidoRango
	cmp al, '5'
	jg NoValidoRango
	inc esi
	cmp esi, 4
	jl ValRango
	je ValidoRango
ValidoRango:				;la validación fue superada
	xor esi, esi
	xor cl, cl
	jmp ValRep
NoValidoRango:				;la validación no fue superada
	imprimeEnPantalla printX, lenprintX
	imprimeEnPantalla msgCod, lenMsgCod
	jmp InputC
ValRep:					;validación de que se repitan dígitos en la misma entrada
	movzx eax, byte [entrada + esi]
        mov edx, esi
        inc edx
        ValRepCiclo:			;ciclo interno
		cmp edx, 4   ; Si hemos llegado al final de la entrada, salimos del ciclo interno
		jge salirCiclo
		movzx ebx, byte [entrada + edx]
		cmp eax, ebx
		je NoValidoRepetidos
		inc edx
		jmp ValRepCiclo
        salirCiclo:
		inc esi
		cmp esi, 4       ; Si hemos recorrido todos los dígitos de la entrada, salimos del ciclo externo
		jl ValRep
	jmp ValidoRepetidos  ; Si llegamos aquí, la entrada no tiene dígitos repetidos
NoValidoRepetidos:		;la validación no fue superada
	imprimeEnPantalla printX, lenprintX
	imprimeEnPantalla msgCod, lenMsgCod
	jmp InputC
ValidoRepetidos:		;la validación fue superada
	imprimeEnPantalla printA, lenprintA
	jmp FIN
	
FIN:				;sale del programa
	imprimeEnPantalla saltoLinea, lenSaltoLinea
	imprimeEnPantalla msgSalida, lenMsgSalida
	salir



