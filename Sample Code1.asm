.MODEL
.STACK
.DATA
.CODE
MAIN PROC
	MOV Y,0
	MOV A,15
	MOV CX,5

LOOPFOR:
	MOV AX,Y
	SUB AX,A
	ADD AX,3
	ADD AX,Y
	MOV Y,AX
	DEC A
	LOOP LOOPFOR

;DISPLAY (Y)
	MOV AH,02H
	MOV DL,Y
	ADD DL,30H
	INT 21H

;DISPLAY (A)
	MOV AH,02H
	MOV DL,A
	ADD DL,30H
	INT 21H
MAIN ENDP
END MAIN