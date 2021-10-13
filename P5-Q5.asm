TITLE BOOLEAN CALCULATOR (P5-Q5.asm)
;---- Create a simple Boolean calculator
;---- (1) Display Selection Menu
;---- (2) Get user input choice
;---- (3) Detect / Compare user input & JMP
;---- (4) Call / Prompt user to get input X & Y (0-9) (0000 0000-0000 1001)
;---- (5) RET => Display Result
;   NOTE : Entry of 0-9 is computed as HEX
;   NOTE : For NOT (Mask F is added) 0000 1001 1111 1001 F9
;   X & Y : Please enter only number 0-9

.MODEL SMALL
.STACK
.DATA
	MENU DB 0DH,0AH," --------- MENU ---------",0DH,0AH
	     DB 0DH,0AH," 1. X AND Y        ",0DH,0AH
	     DB 0DH,0AH," 2. X OR Y         ",0DH,0AH
	     DB 0DH,0AH," 3. NOT X          ",0DH,0AH
	     DB 0DH,0AH," 4. X XOR Y        ",0DH,0AH
	     DB 0DH,0AH," 5. EXIT PROGRAM   ",0DH,0AH
	     DB 0DH,0AH," PLEASE ENTER YOUR CHOICE : $"
	STRX DB 0DH,0AH,"  X :   $"
	STRY DB 0DH,0AH,"  Y :   $"
	SOUT DB 0DH,0AH," OUTPUT  :  $"
	INPUT DB 0
	X     DB 0
	Y     DB 0
	OUTPUT DB 0
	ERR	DB 0DH,0AH," *** INVALID ! PLEASE ENTER 1-5 ONLY ***",0DH,0AH,"$"
	
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
;---- (1) Display Selection Menu
AGAIN:
	MOV AH,09H
	LEA DX,MENU
	INT 21H

;---- (2) Get user input choice
	MOV AH,01H
	INT 21H
	MOV CHOICE,AL

;---- (3) Detect / Compare user input & JMP
	CMP CHOICE,"1"
	JE ISAND

	CMP CHOICE,"2"
	JE ISOR

	CMP CHOICE,"3"
	JE ISNOT

	CMP CHOICE,"4"
	JE ISXOR

	CMP CHOICE,"5"
	JE EXIT
	JNE ERROR

ISAND:
	CALL GETINPUT
		MOV BL,X
		AND BL,Y ;BL = BL AND Y
	JMP DISPLAY 

ISOR:
	CALL GETINPUT
		MOV BL,X
		AND BL,Y ;BL = BL or Y
	JMP DISPLAY 
	
ISNOT:
	CALL GETINPUT
		MOV BL,X
		NOT BL ;1001 = 9 = 09H NOT 09H 0000 1001 ==> 1111 0110 = F6
		    AND BL,0FH;0F mask the high 4 bits
	JMP DISPLAY 

ISXOR:
	CALL GETINPUT
		MOV BL,X
		XOR BL,Y ;BL = BL XOR Y
	JMP DISPLAY 
ERROR:
	MOV AH,09H
	LEA DX,ERR
	INT 21H	

;---- (5) RET => Display Result
DISPLAY:
	MOV OUTPUT,BL

	MOV AH,09H
	LEA DX,SOUT ;OUT
	INT 21H

	MOV AH,02H
	MOV DL,0AH ;NEWLINE
	INT 21H

	MOV AH,02H
	LEA DL,OUTPUT
		ADD DL,30H ;DISPLAY NEED TO CHANGE TO ASCII
	INT 21H
	JMP AGAIN

EXIT:
	MOV AH,4CH
	INT 21H	

MAIN ENDP


;---- (4) Call / Prompt user to get input X & Y (0-9) (0000 0000-0000 1001)
GETINPUT PROC
	MOV AH,09H
	LEA DX,STR	;X:
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV X,AL
		SUB X,30H	;ASCII CONVERT TO NUMBER 0-9

;---------------------------------------------------------------------
	MOV AH,09H
	LEA DX,STRY	;Y:
	INT 21H
	
	MOV AH,01H
	INT 21H
	MOV Y,AL
		SUB Y,30H	;ASCII CONVERT TO NUMBER 0-9
	
	RET ; RETURN TO THE NEXT LINE OF THE LAST FUNCTION THAT CALLED THIS FUNCTION 
GETINPUT ENDP

END MAIN	       