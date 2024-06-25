%include "./macros.asm"

section .data							; Segmento de datos inicializados
	;---Variables internas del Código--
	solucion    	db '         ',0			; variable para guardar la matriz de cada partida
		lsolucion equ $ - solucion
	solucionC   	db '         ',0			; copia de "solucion" para hacer la verificación de ganar
		lsolucion equ $ - solucionC


	solucion1   	db '492357816',0			; solución correcta 1
		lsolucion equ $ - solucion1
	solucion1_1 	db ' 9 357 1 '				; opción 1 de vaciar matriz para la solucion1
	solucion1_2 	db '  23 781 '				; opción 2 de vaciar matriz para la solucion1
	solucion1_3 	db '49 35   6'				; opción 3 de vaciar matriz para la solucion1
	solucion1_4 	db ' 9   7816'				; opción 4 de vaciar matriz para la solucion1


	solucion2   	db '672159834',0			; solucion correcta 2
		lsolucion equ $ - solucion2
	solucion2_1 	db '672   8 4'				; opción 1 de vaciar matriz para la solucion2
	solucion2_2 	db ' 7  5983 '				; opción 2 de vaciar matriz para la solucion2
	solucion2_3 	db '6   598 4'				; opción 3 de vaciar matriz para la solucion2
	solucion2_4 	db '67  5  34'				; opción 4 de vaciar matriz para la solucion2


	;--Variables usadas en Macros--
	aleatorio	db 0					; variable para guardar el resultado de demeAleatorio
	posicion	db 0					; variable para guardar el resultado de ElegirE


	;---Variables de Impresion en Pantalla---
	bienvenidaMenu 	db "  				                                                    ",10,10
			db "				  Bienvenido al juego de			    ",10,10
		
			db "        	 	                  /**           /**                	    ",10
			db "        	 	                 | **          | **                	    ",10
			db " 		 /******* /**   /**  /*******  /****** | **   /** /**   /** 	    ",10
			db "	        /**_____/| **  | ** /**__  ** /**__  **| **  /**/| **  | ** 	    ",10
			db "	       |  ****** | **  | **| **  | **| **  \ **| ******/ | **  | ** 	    ",10
			db " 		\____  **| **  | **| **  | **| **  | **| **_  ** | **  | ** 	    ",10
			db " 		/*******/|  ******/|  *******|  ******/| ** \  **|  ******/ 	    ",10
			db "	       |_______/  \______/  \_______/ \______/ |__/  \__/ \______/ 	    ",10
			db "                                                                                ",10,10

		lbienvenidaMenu equ $ - bienvenidaMenu


	menuInicio	db '            Seleccione una opcion:',10
			db '             1. Iniciar Juego',10
			db '             2. Salir',10,10

			db 'Ingrese la opción que desee: '

		lmenuInicio equ $ - menuInicio


	bienvenida	db  '			      Bienvenido al Juego de SUDOKU',10,10
		lbienvenida equ $ - bienvenida

	msgCoordenadas	db 'Coordenadas (fila columna número): '
		lmsgCoordenadas  equ $ - msgCoordenadas

        msgTiempo	db 'Tiempo Restante: '
		lmsgTiempo  equ $ - msgTiempo

	msgMensaje	db 'Mensaje: '
		lmsgMensaje  equ $ - msgMensaje

        msgESC		db 'Salir ESC',10
        	lmsgESC  equ $ - msgESC

	saltoLinea	db '',10
        	lsaltoLinea  equ $ - saltoLinea

        espacio		db '			      	   '
        	lespacio  equ $ - espacio

        ctrlL 		db 27,"[H",27,"[2J"      		; limpia la terminal (actúa como ctrl+L)
    		lctrlL equ $ - ctrlL


	;--Mensajes Error--
	msgNoerror	db 'No se ha cometido ningún error, usted puede continuar con su juego!  '
	msgCoNInvalido	db 'Entrada Inválida, tome en cuenta el formato de la entrada y matriz   '
	msgRepetido	db 'El número ingresado ya existe en la matriz, no puede repetirlo       '
	msgOcupado	db 'El campo ingresado ya está ocupado, por favor ingrese uno vacío      '
        msgError	db '                                                                     '
        	lmsgError  equ $ - msgError
	
	msgInvalida	db 'Entrada Inválida, por favor ingrese otra',10,10
        	lmsgInvalida  equ $ - msgInvalida
        
        
        ;--Mensajes Ganar o Perder--
        msgGanar	db '¡Felicidades, ha ganado el juego!',10
        	lmsgGanar equ $ - msgGanar

        msgPerder	db 'Su respuesta es incorrecta ya que no cumple con los requisitos de la sumatoria de 15. Inténtelo de nuevo!',10
        	lmsgPerder equ $ - msgPerder

        msgPerderT	db 'Se acabo el tiempo! Inténtalo de nuevo.',10
        	lmsgPerderT equ $ - msgPerderT


	;---Matriz---
	num      	db '0'					; variable para guardar el número de la entrada
		lnum equ $ - num
	
	espC     	db ' '
		lespC equ $ - espC
	
	numero   	db '0'					; variable usada para recorrer "solucion"
		lnumero equ $ - numero
	
	numCol   	db "   0     1     2"			; string de columnas usado en imprimeMatriz
		lnumCol equ $ - numCol

	abreM    	db '[' 					; caracter "[" usado en imprimeMatriz
		labreM equ $ - abreM

	cierraM  	db ']'					; caracter "]" usado en imprimeMatriz
		lcierraM equ $ - cierraM

	divisor  	db ' | '				; caracter usado como divisor en imprimeMatriz
		ldivisor equ $ - divisor

	fil0 		db '0 '					; string de fila 0 usado en imprimeMatriz
	fil1 		db '1 '					; string de fila 1 usado en imprimeMatriz
	fil2 		db '2 '					; string de fila 2 usado en imprimeMatriz
		lfil equ $ - fil2


	;--Variables Tiempo--
	tiempoTotal	dd 60					; variable que guarda el tiempo total en segundos
	ENTER1		db '',10,13
	start_time 	db 0					; toma el tiempo inicial
	end_time 	db 0					; toma el tiempo final

	; --Constantes ligadas al Kernel--
        sys_exit        EQU     1
        sys_read        EQU     3
        sys_write       EQU     4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU     0
        stdout          EQU     1


section .bss                                   			; Segmento de datos no inicializados
	entrada		resb 1					; variable para almacenar la entrada
	fila		resb 1					; variable para almacenar la fila
	columna		resb 1					; variable para almacenar la columna
	matriz 		resb 9					; variable para almacenar el string de la matriz
	errorE		resb 1					; variable para almacenar parámetro de elegirE

	tiempo1 	resd 1                 			; variable para almacenar el primer tiempo
	tiempo2		resd 1					; variable para almacenar el segundo tiempo
	numeroASCII 	resb 1					; variable para almacenar el numero en ASCII


section .text
	global _start:

_start:
	print	ctrlL, lctrlL
Menu:								; interfaz gráfica del menú principal
	;limpiar los registros
	xor	eax, eax
	xor	ecx, ecx
	xor	edx, edx
	xor	cl, cl
	xor	bl, bl
	xor	al, al
	print	bienvenidaMenu, lbienvenidaMenu
	print	menuInicio, lmenuInicio
	leeTeclado						; llamada a macro
	mov	cl, [entrada]
	cmp	cl, '2'						; si la entrada es 2, sale del programa
	je	FIN
	cmp	cl, '1'						; si la entrada es 1, inicia el juego
	print	ctrlL, lctrlL
	je	elegirM
	jmp	ErrorM

;--Incializar Matriz--
elegirM:							; elige una matriz aleatoriamente y la inicializa
	xor al, al
	xor bl, bl
	xor cl, cl
	xor dl, dl
	demeAleatorio						; llamada a macro
	mov al, byte [aleatorio]
	cmp al, 1
	jl sol1							; si "aleatorio" es 0, inicializa la solucion1
	je sol2							; si "aleatorio" es 1, inicializa la solucion2

sol1:								; copiar solucion1 en solucionC
	mov esi, solucion1
	mov edi, solucionC
	mov ecx, 9
	call copiarString					; llamada a subrutina
	jmp elegirS1

elegirS1:							; setea la matriz con los espacios vacíos
	xor ecx, ecx
	xor esi, esi
	xor edi, edi
	demeAleatorio						; llamada a macro
	mov bl, byte [aleatorio]
	cmp bl, 1
	jl opcion1_1						; si "aleatorio" es 0, salta a opcion1_1
	je opcion1_2						; si "aleatorio" es 1, salta a opcion1_2

	opcion1_1:						; elige 1 de dos matrices con espacios vacíos
		demeAleatorio					; llamada a macro
		mov cl, byte [aleatorio]
		cmp cl, 1
		jl sol1_1					; si "aleatorio" es 0, inicializa la matriz con solucion1_1
		je sol1_2					; si "aleatorio" es 1, inicializa la matriz con solucion1_2
		
		sol1_1:						; copiar solucion1_1 en solucion
			mov esi, solucion1_1
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego

		sol1_2:						; copiar solucion1_2 en solucion
			mov esi, solucion1_2
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego
	opcion1_2:						; elige 1 de dos matrices con espacios vacíos
		demeAleatorio					; llamada a macro
		mov cl, byte [aleatorio]
		cmp cl, 1
		jl sol1_3					; si "aleatorio" es 0, inicializa la matriz con solucion1_3
		je sol1_4					; si "aleatorio" es 0, inicializa la matriz con solucion1_4
		
		sol1_3:						; copiar solucion1_3 en solucion
			mov esi, solucion1_3
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego

		sol1_4:						; copiar solucion1_4 en solucion
			mov esi, solucion1_4
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego

sol2:								; Copiar solucion2 en solucionC
	mov esi, solucion2
	mov edi, solucionC
	mov ecx, 9
	call copiarString					; llamada a subrutina
	jmp elegirS2

elegirS2:							; setea la matriz con los espacios vacíos
	xor ecx, ecx
	xor esi, esi
	xor edi, edi
	demeAleatorio						; llamada a macro
	mov bl, byte [aleatorio]
	cmp bl, 1
	jl opcion2_1						; si "aleatorio" es 0, salta a opcion2_1
	je opcion2_2						; si "aleatorio" es 1, salta a opcion2_2

	opcion2_1:						; elige 1 de dos matrices con espacios vacíos
		demeAleatorio					; llamada a macro
		mov cl, byte [aleatorio]
		cmp cl, 1
		jl sol2_1					; si "aleatorio" es 0, inicializa la matriz con solucion2_1
		je sol2_2					; si "aleatorio" es 0, inicializa la matriz con solucion2_2
		
		sol2_1:						; copiar solucion2_1 en solucion
			mov esi, solucion2_1
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego

		sol2_2:						; copiar solucion2_2 en solucion
			mov esi, solucion2_2
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego
	opcion2_2:						; elige 1 de dos matrices con espacios vacíos
		demeAleatorio					; llamada a macro
		mov cl, byte [aleatorio]
		cmp cl, 1
		jl sol2_3					; si "aleatorio" es 0, inicializa la matriz con solucion2_3
		je sol2_4					; si "aleatorio" es 0, inicializa la matriz con solucion2_4
		
		sol2_3:						; copiar solucion2_3 en solucion
			mov esi, solucion2_3
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego

		sol2_4:						; copiar solucion2_4 en solucion
			mov esi, solucion2_4
			mov edi, solucion
			mov ecx, 9
			call copiarString			; llamada a subrutina
			jmp Juego

;--Inicio del Juego--
Juego:								; interfaz gráfica del programa
	;limpia los registros
	xor rcx, rcx
	xor rdx, rdx
	xor rax, rax

	mov  eax, 13                        			; interrupcion que toma el 1er tiempo EPOCH 
	xor rbx, rbx
	int  0x80

	mov dword [tiempo1], eax        			; almacena la cantidad de segundos desde el 1er tiempo

	
	print	saltoLinea, lsaltoLinea
	print	saltoLinea, lsaltoLinea
	print	bienvenida, lbienvenida
	print	saltoLinea, lsaltoLinea
	
	imprimeMatriz						; imprimir la matriz seleccionada para jugar
	print	saltoLinea, lsaltoLinea
	
	call matrizLlena					; llamada a subrutina
	cmp ecx, 0						; verifica si la matriz está llena
	jne ganarOperder					; si está llena, salta a "ganarOperder"

	print	msgESC, lmsgESC
	print	msgTiempo, lmsgTiempo
	call	tiempo						; llamada a subrutina
	print	msgMensaje, lmsgMensaje
	call	Error						; llamada a subrutina
	print	msgError, lmsgError
	print	saltoLinea, lsaltoLinea
	
	print	msgCoordenadas, lmsgCoordenadas
	
	;limpia los registros
	xor	eax, eax
	xor	ebx, ebx
	xor	ecx, ecx
	xor	edx, edx
	
	leeTeclado						; llamada a macro
	cmp	byte[entrada], 0x1B				; verifica si la entrada fue la tecla ESCAPE
	print	ctrlL, lctrlL
	je	Menu						; si lo fue, sale al menú principal
	
	leeCoordenada						; llamada a macro
	cmp	eax, 0						; verifica si la coordenada es válida
	je	ErrorCoN					; si es inválida, salta a ErrorCoN

	mov	byte[errorE], 0
	call	Error

	mov eax, 13                                 		; interrupcion que toma el 2do tiempo EPOCH
	xor rbx, rbx
	int 0x80

	mov dword [tiempo2], eax       				; almacena la cantidad de segundos desde el 2do tiempo
	
	call	agregarM					; llamada a subrutina
	jmp	Juego						; salta para iniciar siguiente ronda

ganarOperder:							; verifica si el jugador gana o pierde
	xor ecx, ecx
	xor al, al
	mov ecx, 9						; contador para recorrer los nueve dígitos

	comparar:						; compara la solucion final con la correcta
		mov al, byte [solucion + ecx - 1] 		; lee el dígito de la solucion final
		cmp al, byte [solucionC + ecx - 1] 		; lo compara con el dígito de la solucion correcta
		jne perder 					; si no son iguales, salta a "perder"
	loop comparar

ganar:								; si llega acá, ya recorrió la solución y era correcta
	print	ctrlL, lctrlL
	print	msgGanar, lmsgGanar
	jmp Menu

perder:
	print	ctrlL, lctrlL
	print	msgPerder, lmsgPerder
	jmp Menu

perderT:
	print	ctrlL, lctrlL
	print	msgPerderT, lmsgPerderT
	mov byte[tiempoTotal], 60
	jmp Menu

;--Errores--
ErrorM:								; imprime error en entrada de menu
	print	saltoLinea, lsaltoLinea
	print	msgInvalida, lmsgInvalida
	jmp	Menu

ErrorCoN:							; imprime error en entrada de coordenadas o número
	mov	byte[errorE], 2
	call	Error
	jmp	Juego

;objetivo de la subrutina: llamar a la subrutina elegirE
Error:								; subrutina que elije el mensaje de error correspondiente
	call elegirE errorE					; llamada a macro
	ret


;--Subrutinas--
;objetivo de la subrutina: copiar los carácteres de un string a otro
copiarString:
	copiar:
		mov al, byte [esi]				; mueve el byte del string origen a al
		mov byte [edi], al				; lo pasa al byte de string destino
		inc esi						; siguiente byte del string origen
		inc edi						; siguiente byte del string destino
	loop copiar						; decrementa el contador de bucle y salta si no es cero
	ret

;objetivo de la subrutina: agregar num al espacio (fila, columna) en la matriz si es válido
agregarM:
	;limpia los registros
	xor cl, cl
	xor al, al
	xor dl, dl
	xor ecx, ecx
	
	calculePosicion fila, columna				; llamada a macro
	mov cl, byte[posicion]                  		; guarda la posicion en cl
	mov al, byte [solucion + ecx] 				; lee el primer carácter del string

replace:
	cmp byte [solucion + ecx], ' '				; revisa que el espacio este vacio
	jne errorVacio						; si no está vacío  salta a "errorVacio"
	call revisarRepetidos					; llamada a subrutina
	cmp eax, 0
	je errorRep						; si num ya está en la matriz, salta a errorRep
	
	mov dl, byte[num]
	mov byte [solucion + ecx], dl  				; agrega num en la posición (fila, columna)
	jmp exit
	
errorVacio:
	mov byte[errorE], 4					; determina el error correspondiente
	call Error						; llamada a subrutina
	jmp exit
		
errorRep:
	mov byte[errorE], 3					; determina el error correspondiente
	call Error						; llamada a subrutina
	jmp exit

exit:
	add	byte[fila], '0'					; transforma fila a char
	add	byte[columna], '0'				; transforma columna a char
	ret
	
;objetivo de la subrutina: revisar si num ya existe en la matriz
revisarRepetidos:						
	mov al, [num]
	mov bl, 0               				; inicializa el índice en 0

	revisarDigito:
		cmp bl, 9              				; compara el índice con la longitud del string
		je noRepetido             			; si llega al final del string, salta a "noRepetido"
		cmp al, [solucion + ebx]			; compara num con el byte actual de solucion
		je siRepetido                  			; si son iguales, salta a "repetido"
		inc bl                    			; incrementa el índice
		jmp revisarDigito           			; ciclo para validar el siguiente byte

	noRepetido:
		mov eax, 1                			; si no está repetido, se establece como válido (1)
		ret

	siRepetido:
		mov eax, 0                			; si está repetido, se establece como inválido (0)
		ret

;objetivo de la subrutina: revisar si quedan espacios vacíos o si ya se lleno toda la matriz
matrizLlena:
	xor ebx, ebx
	xor ecx, ecx
	mov cl, [espC]
	mov bl, 0                				; inicializa el índice en 0

	revisarByte:
		cmp bl, 9              				; compara el índice con la longitud del string
		je noEspacios             			; si llega al final del string, salta a "noEspacios"
		cmp cl, [solucion + ebx] 			; compara el byte actual de solucion con un espacio ' '
		je siEspacios                  			; si son iguales, salta a "siEspacios"
		inc bl                    			; incrementa el índice
		jmp revisarByte           			; ciclo para validar el siguiente byte

	noEspacios:
		mov ecx, 1                			; si la matriz está llena, se establece como inválido (1)
		ret

	siEspacios:
		mov ecx, 0                			; si la matriz no está llena, se establece como válido (0)
		ret


;--Subrutinas dadas por el profesor--
;objetivo de la subrutina: Convertir un numero a codificacion ASCII
numTOascii:
        xor rcx,rcx                                             ; Limpia registro ecx
        xor rdx,rdx                                             ; Limpia registro edx

divida:
        inc ecx
        mov edx, 0
        mov esi, 10
        idiv esi
        add edx, '0'
        push rdx
        cmp eax, 0
        jnz divida

        xor esi, esi
		
retornaNumero:
        pop rax
        mov [numeroASCII+esi],eax
        inc esi
        loop retornaNumero
        ret

;objetivo de la subrutina: calcular el tiempo transcurrido y la diferencia con el tiempo total
tiempo:
	;limpiar los resgitros
        xor rcx,rcx
        xor rdx,rdx
        xor rax,rax

	mov ebx,dword [tiempo1]					; se asigna ebx = tiempo1	
	mov eax,dword [tiempo2]					; se asigna eax = tiempo2
	mov cl,byte [tiempoTotal]				; cl = 60 (cantidad de 120s)
								; el registro ECX es el que tiene el tiempo en segundos, por lo tanto es el que se utilizara
								; para determinar si pasaron los 120s o no								

	mov eax, ecx                    			; tiempoTotal es una variable que almacena un número
	call numTOascii                 			; llamada a subrutina
	print numeroASCII, 3         				; imprime numeroASCII por defecto de 3 dígitos de longitud
	print ENTER1, 2

	sub byte [tiempoTotal], 6
	cmp byte [tiempoTotal], 0
	jle perderT                                  		; salta a "perderT" si el contador es menor o igual a 0
	ret

;--Final del Código--
FIN:
	salir							; llamada a macro
