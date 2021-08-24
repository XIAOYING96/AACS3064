TITLE COPY THE CONTENT (P3-Q2.asm)
;Reversal 
;data1 :MILK
;data2 :KLIM

.model small
.stack
.data

	data1 	DB	"MILK",0dh,0ah,"$"
	data2 	DB	4 DUP ("*"),0dh,0ah,"$"
	msg1	DB	"Initial Content",0dh,0ah,"$"
	msg2	DB	"After Replacement",0dh,0ah,"$"
	msg3	DB	"After Reversal",0dh,0ah,"$"
	sdata1	DB	"data1: $"
	sdata2	DB	"data2: $"

.code
MAIN PROC FAR
	MOV AX,@DATA
	MOV DS,AX

	;---Code Start Here
	MOV AH,09H	;$
	MOV DX,OFFSET msg1	;LEA DX,mgs1
	INT 21H

	;----Print data1 (sdata) :content(data1)
	MOV AH,09H
	LEA DX,sdata1 ; data1:
	INT 21H

	MOV AH,09H
	LEA DX,data1 ; MILK
	INT 21H

	MOV AH,09H
	LEA DX,sdata2 ; data2
	INT 21H

	MOV AH,09H
	LEA DX,data2 ; ****
	INT 21H

	;---Modification
	MOV CX,4	;LOOP COUNT CX = 4 CHAR
	MOV DX,0	;BX = INDEX OF DATA1 OR DATA2
			;BX = BASE REGISTER (ADD)
	
	rLoop:
		MOV AL, DATA1[BX]	
		MOV DATA2[BX],AL
		INC BX			; BX = BX + 1
		LOOP rLoop		; CX = CX -1
					;CX = 0 (out of loop)
	
	;---code 2
	MOV AH,09H	;$
	MOV DX,OFFSET msg2	;LEA DX,mgs1
	INT 21H

	;----Print data1 (sdata) :content(data1)
	MOV AH,09H
	LEA DX,sdata1 ; data1:
	INT 21H

	MOV AH,09H
	LEA DX,data2 ; MILK
	INT 21H

	MOV AH,09H
	LEA DX,sdata2 ; data2
	INT 21H

	MOV AH,09H
	LEA DX,data2 ; MILK
	INT 21H
	
	;---Reversal------
	MOV CX,4	; 4 CHAR
	LEA SI,DATA1	; SI = OFFSET ADDRESS OF DATA1
	LEA DI,DATA2	; DI = OFFSET ADDRESS OF DATA2
	ADD DI,3	; DI = DI + 3 = REFERS TO 4TH CHAR
		;MOV SI = 0
		;MOV DI = 3

	continue:
		MOV AL,[SI]	;MOV AL,DATA[SI]
		MOV [DI],AL	;MOV DATA[DI],AL
		
		INC SI
		DEC DI
		LOOP continue

	;---display reversal
	MOV AH,09H	;$
	MOV DX,OFFSET msg3	;LEA DX,mgs1
	INT 21H

	;----Print data1 (sdata) :content(data1)
	MOV AH,09H
	LEA DX,sdata1 ; data1:
	INT 21H

	MOV AH,09H
	LEA DX,data1 ; MILK
	INT 21H

	MOV AH,09H
	LEA DX,sdata2 ; data2
	INT 21H

	MOV AH,09H
	LEA DX,data2 ; MILK
	INT 21H
		
	;----Terminate
	MOV AX,4C00H
	INT 21H

MAIN ENDP
END MAIN


