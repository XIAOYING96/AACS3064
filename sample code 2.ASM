.MODEL
.STACK
.DATA 
	MSG1 DB 10,13,"ENTER TOTAL PRICE :$"
	MSG2 DB 10,13,"THE TOTAL IS :$"
	MSG3 DB 10,13,"QUANTITY >$"
	DISCOUNT DB 15
	quantity DB ?	
	sPRICE DB 50 DUP ("$")
	PRICE  DB ?
	Digit1 DB ?
	Digit2 DB ?
	Digit3 DB ?
	TEN DB 10
	SQUANTITY DB ?
	NEWPRICE DW ?
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

	;--Prompt message “ enter total price"
	MOV AH,09H
	LEA DX,MSG1
	INT 21H

	;--let user enter price
		mov ah, 3Fh				; read an array of bytes from keyboard-0		
		mov bx, 0				; bx = 0 (select keyboard)
		mov cx, 50				; simple put 50 cx = 127 (maximum bytes to read)
		lea dx, sPRICE			; stored in DS:DX
		int 21h		

	;---prompt message " quantity "
	MOV AH,09H
	LEA DX,MSG3
	INT 21H

	mov ah, 3Fh	
	mov ax,0
	mov cx,60								
	lea dx, sQUANTITY			
	int 21h	
	


	mov bx, 0
	mov ax, 0

	;--CONVERT ASCII INTO DECIMAL
	SUB sPRICE[bx],30H			; 1st ascii digit subtraction
	    mov AL, sPRICE[0]		; MOV user inpur string sPRICE to AL
		MUL TEN					; MULTIPLY first digit from 3 to 30 
	SUB sPRICE[bx + 1],30H		; 2nd ascii digit subtraction
	    add AL, sPRICE[bx + 1]	; AL = AL + sprice[1] = 30 + 5 = 35 in number
	MOV PRICE, AL				; NOW move the real price 35 into PRICE

	SUB SQUANTITY,30H
	
	;--CALCULATE DISCOUNT 15 
	MOV AX, 0
	MOV AL, PRICE
	MOV BL,quantity
	MUL BL 	
	MOV NEWPRICE, AX
	
	MOV DX, 0
	MOV CX, 0
	;--SPLITTING 3 DIGITS
	MOV CX,10	
	DIV CX						; 525/10 = 52...remain 5
	MOV DIGIT3, DL				; DL = 5 & AX = 52
	DIV CL						; 2nd time div 10 for 52/10 = 5(AL).. remain 2(AH)
	MOV DIGIT1, AL
	MOV DIGIT2, AH

	;--NEWLINE
	MOV AH,02H
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H

	;--DISPLAY MSG 2
	MOV AH, 09H
	LEA DX, MSG2
	INT 21H
		
	;--PRINT 5
	MOV AH,02H
	MOV DL,DIGIT1	; NOT DH its supposed to be DL
	   ADD DL,30H	; NOT DH its supposed to be DL
	INT 21H

	;--PRINT DOT
	MOV AH,02H
	MOV DL,"."
	INT 21H

	;--PRINT DIGIT2
	MOV AH,02H
	MOV DL,DIGIT2
		ADD DL,30H
	INT 21H 

	;--PRINT DIGIT3
	MOV AH,02H
	MOV DL,DIGIT3
		ADD DL,30H
	INT 21H 
	
	;--TERMINATE
	MOV AH,4CH
	INT 21H
MAIN ENDP
END MAIN