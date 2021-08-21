.model small
.stack
.data
	data1	DB	"STRESSED",0dh,0ah,"$"
	data2	DB	8 DUP ("#"),"$"
	msg1	DB	"Data1: I am $"
	msg2	DB	"Data2: I",03H,"$"

.code
main proc
	MOV AX,@DATA
	MOV DS,AX
	
	;---original & data1
	MOV AH,09H
	LEA DX,msg1
	INT 21H

	LEA DX,DATA1
	INT 21H

	;--modification
	MOV CX,8
	LEA SI,DATA1
	LEA DI,DATA2
	ADD DI,7

	changing:
		MOV AL,[SI]
		MOV [DI],AL
		INC SI
		DEC DI
		LOOP changing

	;--modification & data2
	MOV AH,9H
	LEA DX,msg2
	INT 21H

	LEA DX,DATA2
	INT 21H

	LEA DX,DATA2
	INT 21H

	MOV AH,4CH
	INT 21H

MAIN ENDP
END MAIN