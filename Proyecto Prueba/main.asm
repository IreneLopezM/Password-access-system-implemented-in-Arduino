;
; Proyecto Prueba.asm
;
; Created: 19/06/2021 08:26:03 p. m.
; Author : eliza
;


; Replace with your application code
	.def cont_letras=r14
	.def suma=r15
	.def temp=r16
	.def cont1=r17
	.def cont2=r18
	.def cont3=r19
	.def contLCD=r20
	.def usart=r21
	.def temp2=r22
	.def aux=r23
	.def cont16=r24
	.def vacio=r25
	.cseg
	.org 0
	rjmp reset

	.org $024
	rjmp recibe

reset:	ldi temp,$ff
	out ddrc,temp
	out ddrb,temp
	out portc,temp
	out portb,temp 
	ldi temp,$fe
	out ddrd,temp 
	ldi cont16,0
	ldi vacio,0
	ldi temp,$00
	mov cont_letras,temp
	rcall delay_100m 

;** USART
	ldi temp,$98
	sts ucsr0b,temp
	ldi temp,103
	sts ubrr0l,temp
	sei

;** mover constantes de memoria de programa a memoria de datos 
	ldi temp,$10
	ldi XL,$00
	ldi XH,$01
	ldi ZL,low(LCD*2)
	ldi ZH,high(LCD*2)
lazo: lpm r1,Z+
	st X+,r1
	dec temp
	brne lazo

;** Inicializar LDC
	ldi temp,$28
	out portd,temp
	ldi temp,$20
	out portd,temp
	rcall delay_10m
;* Funcion set 
	ldi contLCD,$00
	rcall conf_LCD
;* Display on/off
	ldi contLCD,$04
	rcall conf_LCD
;* Mode set
	ldi contLCD,$08
	rcall conf_LCD
;* Clear display 
	ldi contLCD,$0c
	rcall conf_LCD

main: ldi temp,$ff
	out ddrc,temp
	out ddrb,temp
	out portc,temp
	out portb,temp
	ldi temp,$f0
	out ddrc,temp
	ldi temp,$ff
	out ddrb,temp
	ldi temp,$0f
	out portc,temp
	nop 
	nop
	ldi temp,$00
	out portb,temp
	nop
	nop
	nop
preguntar:	in temp,pinc
	cpi temp,$0f
	breq preguntar
;* empieza el ciclo de filas
	sbrs temp,0
	rjmp peso_fila0
	sbrs temp,1
	rjmp peso_fila1
	sbrs temp,2
	rjmp peso_fila2
	sbrs temp,3
	rjmp peso_fila3

;* cambio de config puertos b y c
fin_filas:
	ldi temp,$ff
	out ddrc,temp
	out ddrb,temp
	out portc,temp
	out portb,temp
	ldi temp,$ff
	out ddrc,temp
	ldi temp,$f0
	out ddrb,temp
	ldi temp,$00
	out portc,temp
	nop
	nop
	ldi temp,$0f
	out portb,temp
	nop
	nop
	nop
;* empieza el ciclo de columnas 
	in temp,pinb 
	sbrs temp,0
	rjmp peso_col0
	sbrs temp,1
	rjmp peso_col1
	sbrs temp,2
	rjmp peso_col2
	sbrs temp,3
	rjmp peso_col3
fin_cols: ;* boton enviar 
	ldi temp,$0e
	cp suma,temp
	breq enviar
;* checar si hay cambio de teclas 
	ldi temp,$0f
	cp suma,temp
	breq inc_contador
;* pesos del cambio de teclas - letras
	ldi temp,$01
	cp cont_letras,temp
	breq A_N
	ldi temp,$02
	cp cont_letras,temp
	breq O_Z
;* numeros
	ldi temp,$30
	rjmp suma_peso
A_N: ldi temp,$41
	rjmp suma_peso
O_Z: ldi temp,$4f
suma_peso: add suma,temp
	mov usart,suma
	sts udr0,usart
	sbrc cont16,4
	rcall llenar
	rcall letras
	rcall delay_100m
	rcall delay_100m
	inc cont16
	rjmp main
inc_contador: inc cont_letras
	ldi temp,$03
	cp cont_letras,temp
	breq dec_contador
	rcall delay_100m
	rcall delay_100m
	rjmp main
dec_contador: ldi temp,$00
	mov cont_letras,temp
	rcall delay_100m
	rcall delay_100m
	rjmp main
enviar: mov usart,suma
	sts udr0,usart
	rcall delay_100m
	rcall delay_100m
	ldi contLCD,$0c
	rcall conf_LCD
	rjmp main


peso_fila0: ldi temp,$00
	mov suma,temp
	rjmp fin_filas
peso_fila1: ldi temp,$04
	mov suma,temp
	rjmp fin_filas
peso_fila2: ldi temp,$08
	mov suma,temp
	rjmp fin_filas
peso_fila3: ldi temp,$0c
	mov suma,temp
	rjmp fin_filas

peso_col0: ldi temp,$00
	add suma,temp
	rjmp fin_cols
peso_col1: ldi temp,$01
	add suma,temp
	rjmp fin_cols
peso_col2: ldi temp,$02
	add suma,temp
	rjmp fin_cols
peso_col3: ldi temp,$03
	add suma,temp
	rjmp fin_cols


LCD: .db $28, $20, $88, $80, $08, $00, $e8, $e0, $08, $00, $68, $60, $08, $00, $18, $10
bienvenido: .db $42, $49, $45, $4e, $56, $45, $4e, $49, $44, $4f
error: .db $45, $52, $52, $4f, $52, $45, $4e, $49, $44, $4f

;** interupcion

recibe: lds usart,udr0
	ldi temp,$31
	cp usart,temp
	breq msj_bienvenido
	ldi temp,$32
	cp usart,temp
	breq msj_error
	sbrc cont16,4
	rcall llenar
	rcall letras
	inc cont16
	rjmp salir1
msj_bienvenido:
	ldi contLCD,$0c
	rcall conf_LCD
	ldi usart,$42
	rcall letras
	ldi usart,$49
	rcall letras
	ldi usart,$45
	rcall letras
	ldi usart,$4e
	rcall letras
	ldi usart,$56
	rcall letras
	ldi usart,$45
	rcall letras
	ldi usart,$4e
	rcall letras
	ldi usart,$49
	rcall letras
	ldi usart,$44
	rcall letras
	ldi usart,$4f
	rcall letras
	ldi temp,$ff
	out ddrb,temp
	ldi temp,$10
	out portb,temp
	rjmp salir1
msj_error:
	ldi contLCD,$0c
	rcall conf_LCD
	ldi usart,$45
	rcall letras
	ldi usart,$52
	rcall letras
	ldi usart,$52
	rcall letras
	ldi usart,$4f
	rcall letras
	ldi usart,$52
	rcall letras
	ldi temp,$ff
	out ddrb,temp
	ldi temp,$20
	out portb,temp
salir1:	reti

;** subrutinas

conf_LCD:
;parte alta
	mov XL,contLCD
	ld temp,X 
	out portd,temp
	inc contLCD
	mov XL,contLCD
	ld temp,X 
	out portd,temp
;parte baja
	inc contLCD
	mov XL,contLCD
	ld temp,X 
	out portd,temp
	inc contLCD
	mov XL,contLCD
	ld temp,X 
	out portd,temp
	rcall delay_10m
	ret


letras: 
;parte alta
	mov temp2,usart
	andi temp2,$0f
	mov temp,usart
	sub temp,temp2
	mov aux,temp
	ldi temp2,$0c
	add temp,temp2
	out portd,temp
	mov temp,aux
	ldi temp2,$04
	add temp,temp2
	out portd,temp
;parte baja 
	mov temp,usart
	lsl temp
	lsl temp
	lsl temp
	lsl temp
	mov aux,temp
	ldi temp2,$0c
	add temp,temp2
	out portd,temp
	mov temp,aux
	ldi temp2,$04
	add temp,temp2
	out portd,temp
	rcall delay_10m
	ret


llenar: cpi vacio,24
	breq salir 
	ldi usart,$20
	rcall letras
	inc vacio
	rjmp llenar 
salir: ldi cont16,0
	ldi vacio,0
	ret


delay_10m: ldi cont1,80
lazo2:    ldi cont2,200
lazo1:    nop
    nop
    nop
    nop
    nop
    nop
    nop 
    dec cont2
    brne lazo1
    dec cont1
    brne lazo2
    ret 


delay_100m:ldi cont1,4
lazo5:	ldi cont2,200
lazo4:	ldi cont3,200
lazo3:	nop
	nop
	nop
	nop
	nop
	nop
	nop
	dec cont3
	brne lazo3
	dec cont2
	brne lazo4
	dec cont1
	brne lazo5
	ret
