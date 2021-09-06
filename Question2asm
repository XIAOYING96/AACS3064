.MODEL SMALL
.STACK 100
.DATA
	myData DB 2,4,7,'H','A',9

.CODE
MAIN PROC
	MOV AX,@DATA
	DS,AX
	
	;----------------
	
	MOV SI,0
CHK:
	CMP myData[SI],"A"
	JNAE NEXT
	CMP myData[SI],"Z"
	JBE PRINT
	JA NEXT

NEXT:
	
	INC SI
	JMP CHK

PRINT:
	MOV AH,02H
	MOV DL,myData[SI]
	INT 21H	
	
EXIT:
	MOV AH,4CH
	INT 21H

MAIN ENDP
END MAIN
