.MODEL SMALL
.STACK 100
.DATA
	STR1 DB "ENTER PASSWORD : $"
	UPSW DB "AACS"
	IPSW DB 4 DUP (0)
	VMSG DB 13,10,"WELCOME....$"
	IMSG DB 13,10,"INVALID PASSWORD.TRY AGAIN.$"
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,STR1
	INT 21H
	
	
	MOV CX,4
	MOV SI,0
	
GETPSW:
	MOV AH,01H
	INT 21H
	MOV IPSW[SI],AL
	INC SI
	LOOP GETPSW
	
;-----------------------------------------------
	MOV SI,0

CHK:	
	CMP SI,4
	JE PRINT
	JNE CHKNEXT

	
CHKNEXT:
	MOV BL,IPSW[SI]
	CMP BL,UPSW[SI]
	JE NEXT
	JNE ERROR
	
	
NEXT:
	INC SI
	JMP CHK
	
	
PRINT:	
	MOV AH,09H
	LEA DX,VMSG
	INT 21H
	JMP EXIT

ERROR:	
	MOV AH,09H
	LEA DX,IMSG
	INT 21H
	JMP EXIT

	MOV AH,4CH
	INT 21H

MAIN ENDP
END MAIN