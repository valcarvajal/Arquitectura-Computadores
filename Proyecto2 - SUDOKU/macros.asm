;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Macros utiles para programacion en nasm  ;
;  Version 1.0 2022 por emmrami	            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Si se vna a realizar nuevas macros para un proyecto definirlas aca
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;objetivo de la macro: agarra la fila, columna y numero de la entrada,
	;los guarda en variables y revisa que sean entradas válidas
	%macro leeCoordenada 0
		;guarda las coordenadas en variables
		mov     edi,    entrada        		; dirección de memoria para guardar la entrada
		mov     al,     byte[edi]      		; lee el primer carácter
		mov     byte[fila],    al      		; guarda el valor en la variable "fila"
	    
		;validación de fila
		cmp     byte[fila], '0'
		jl      invalida     			; si es menor que '0', salta
		cmp     byte[fila], '2'
		jg      invalida     			; si es mayor que '2', salta

		mov     edi,    entrada+2      		; dirección de memoria del segundo carácter
		mov     al,     byte[edi]      		; lee el segundo carácter
		mov     byte[columna], al      		; guarda el valor en la variable "columna"

		;validación de columna
		cmp     byte[columna], '0'
		jl      invalida  			; si es menor que '0', salta
		cmp     byte[columna], '2'
		jg      invalida  			; si es mayor que '2', salta

		mov     edi,    entrada+4      		; dirección de memoria del tercer carácter
		mov     al,     byte[edi]      		; lee el tercer carácter
		mov     byte[num], al       		; guarda el valor en la variable numero

		;validación de número
		mov	bl, byte [num]
		sub	bl, '0'				; transforma num a entero
    	    
		cmp	bl, 1
		jl	invalida			; si es menor que 1, salta
		cmp	bl, 9
		jg	invalida			; si es mayor que 9, salta
		jmp	valida				; si llegó hasta acá, entonces es una entrada válida
	
	invalida:
		mov     eax, 0                  	; valor de retorno 0 (no es numérico o está fuera de rango)
		jmp     final
	
	valida:
		mov     eax, 1                  	; valor de retorno 1 (es válido)
		jmp     final
	
	final:
		add bl, '0'				; transforma num de vuelta a string
		mov byte [num], bl
	%endmacro


	;objetivo de la macro: imprime la matriz con el siguiente formato y llena con el string correspondiente
	;
	;    0     1     2
	; 0 [ ] | [ ] | [ ]
	; 1 [ ] | [ ] | [ ]
	; 2 [ ] | [ ] | [ ]
	;
	%macro imprimeMatriz 0
		print	espacio, lespacio
		print	numCol, lnumCol			; números de columnas " 0  1  2 "
		print	saltoLinea, lsaltoLinea

		mov	al, byte [solucion]		; lee el primer carácter del string
		mov	byte [numero], al		; lo guarda en la variable "número"
		print	espacio, lespacio
		print	fil0, lfil			; número de la primera fila " 0 "
		print	abreM, labreM			; carácter " [ "
		print	numero, lnumero
		print	cierraM, lcierraM		; carácter " ] "
		print	divisor, ldivisor		; carácter " | "

		xor	ebx, ebx
		mov	al, byte [solucion + 1]		; lee el segundo carácter
		mov	byte [numero], al
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	divisor, ldivisor

		xor 	ebx, ebx
		mov 	al, byte [solucion + 2]		; lee el tercer carácter
		mov 	byte [numero], al
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	saltoLinea, lsaltoLinea

		xor 	ebx, ebx
		mov 	al, byte [solucion + 3]		; lee el cuarto carácter
		mov 	byte [numero], al
		print 	espacio, lespacio
		print 	fil1, lfil			; número de la segunda fila " 1 "
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	divisor, ldivisor

		xor 	ebx, ebx
		mov 	al, byte [solucion + 4]		; lee el quinto carácter
		mov 	byte [numero], al
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	divisor, ldivisor

		xor 	ebx, ebx
		mov 	al, byte [solucion + 5]		; lee el sexto carácter
		mov 	byte [numero], al
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	saltoLinea, lsaltoLinea

		xor 	ebx, ebx
		mov 	al, byte [solucion + 6]		; lee el séptimo carácter
		mov 	byte [numero], al
		print 	espacio, lespacio
		print	fil2, lfil			; número de la tercera fila " 2 "
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	divisor, ldivisor

		xor 	ebx, ebx
		mov 	al, byte [solucion + 7]		; lee el octavo carácter
		mov 	byte [numero], al
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	divisor, ldivisor

		xor 	ebx, ebx
		mov 	al, byte [solucion + 8]		; lee el último carácter
		mov 	byte [numero], al
		print 	abreM, labreM
		print 	numero, lnumero
		print 	cierraM, lcierraM
		print 	saltoLinea, lsaltoLinea
	%endmacro


	;objetivo de la macro: calcula la posición en el string en base al número de fila y columna
	;realiza la operacion (fila * 3 + columna)
	;parámetros: variables numéricas fila y columna
	%macro calculePosicion 2
		sub	byte[%1], '0'
		sub	byte[%2], '0'
	
		xor	ah, ah
		push	ax 				; guarda ax en la pila
		mov 	al, byte[%1] 			; mueve la fila a al
		mov 	bl, byte[%2] 			; mueve la columna a bl
		mov 	cl, 3
		mul 	cl 				; al = fila * 3
		add 	al, bl 				; al + b
		mov 	[posicion], al 			; guarda el resultado en posicion
		pop 	ax 				; restaura el valor original de ax
	%endmacro


	;objetivo de la macro: setea la variable msgError como el error correspondiente
	;parámetro: variable numérica errorE (un byte)
	%macro elegirE 1
		mov	bl, byte [%1]
		cmp	bl, 1
		jl 	no_error
		cmp 	bl, 2
		je 	formato
		cmp	bl, 3
		je	repetido
		jg	ocupado
	no_error:					; si bl = 0, no hay errores en la entrada
		mov esi, msgNoerror			; string fuente
		mov edi, msgError			; string destino
		mov ecx, 69
		call copiarString			; llamada a subrutina
		jmp fin	
	formato:					; si bl = 2, hay un error de formarto en la coordenada o el número
		mov esi, msgCoNInvalido			; string fuente
		mov edi, msgError			; string destino
		mov ecx, 69
		call copiarString			; llamada a subrutina
		jmp fin
	repetido:					; si bl = 3, el número ya existe en la matriz
		mov esi, msgRepetido			; string fuente
		mov edi, msgError			; string destino
		mov ecx, 69
		call copiarString			; llamada a subrutina
		jmp fin
	ocupado:					; si bl = 4, el campo está ocupado
		mov esi, msgOcupado			; string fuente
		mov edi, msgError			; string destino
		mov ecx, 69
		call copiarString			; llamada a subrutina
		jmp fin
	fin:
		;se limpian los registros
		xor ebx, ebx
		xor esi, esi
		xor edi, edi
		xor ecx, ecx
		xor bl, bl
		int 80h
	%endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Las siguientes macros se pueden utilizar para los proyectos, si es el caso no modificar las mismas;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    ; --Variables ligadas a colores ANSI para consolda--
	color_rojo 	DB 	1Bh,'[31m'
	color_verde 	DB 	1Bh,'[32m'
	color_azul      DB	1Bh,'[34m'
	color_amarillo  DB 	1Bh,'[33m'
	color_cyan 	DB 	1Bh,'[36m'
	color_morado	DB	1Bh,'[35m'
	color_blanco	DB	1Bh,'[37m'
	color_default	DB	1Bh,'[0m '	

    ; --Constantes ligadas al Kernel--
        sys_exit        EQU     1
        sys_read        EQU     3
        sys_write       EQU     4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU     0
        stdout          EQU     1


        ;objetivo de la macro: cambiar el color de la letra en consola
        ;ejemplo de funcionamiento: cambiaColor variableEnMemoria 
        ;ejemplo de uso:            cambiaColor color_rojo 
	%macro cambiaColor 1
    		mov eax, 4
   	 	mov ebx, 1
    		mov ecx, %1
    		mov edx, 5 
   		int 80h
	%endmacro	


	;objetivo de la macro: imprimir un texto en pantalla
	;macro "imprimeEnPantalla" con otro nombre
	;parámetros: variable ASCII y su longitud en bytes
	%macro print 2
		mov     eax,	sys_write		; opción 4 de las interrupciones del kernel
                mov     ebx,	stdout        		; standar output
                mov     ecx,	%1            		; mensaje
                mov     edx,	%2            		; longitud
                int     0x80
        %endmacro


	;objetivo de la macro: captura un dato ASCII ingresado mediante teclado por parte del usuario
	;y lo almacena en la variable de memoria "entrada"
        %macro leeTeclado 0
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     entrada       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8             ; número de bytes a leer.
                int     0x80
        %endmacro


	;objetivo de la macro: genera un número aleatorio entre 0 y 1
	%macro demeAleatorio 0
	    	rdtsc ;The rdtsc (Read Time-Stamp Counter) instruction is used to determine how many CPU ticks took place since the processor was reset. 
    		and ah, 00000001b  ;hace un and para obtener numeros del 0 al 1 
    		;add ah,'0'     ; convierte valor numero en su equivalente ASCII para despliegue 
    		mov [aleatorio],ah ; almacena en "aleatorio" el numero obtenido 	
	%endmacro


        ;objetivo de la macro: sale del programa hacia la terminal
        %macro salir 0
                mov eax,1
		mov ebx,0
                int 80h
        %endmacro

