.MODEL SMALL
.STACK 100
.DATA
	TITMSG DB 0dh,0ah,"   ___  _     __   ___        __   _  _____  __     ___  __  _____  ___  __ "
           DB 0dh,0ah,"  / __\/_\   / /  / __/\ /\  / /  /_\/__   \/__\   / _ \/__\ \_   \/ __\/__\"
       DB 0dh,10," / /  //_\\ / /  / / / / \ \/ /  //_\\ / /\/_\    / /_)/ \//  / /\/ /  /_\ "
     DB 0dh,10,"/ /__/  _  / /__/ /__\ \_/ / /__/  _  / / //__   / ___/ _  /\/ /_/ /__//__ "
       DB 0dh,0ah," \____\_/ \_\____\____/\___/\____\_/ \_\/  \__/   \/   \/ \_\____/\____\__/ $"
                                                                            

	MSG DB "Enter Price: RM $"
	MSG1 DB "Enter Quantity: $" 
	MSG2 DB "Total price : RM$"
	MSG3 DB "Do you want to continue? (Y=yes,N=no)$"
	NL DB 13,10,"$"
	TEN DB 10
	HUNDRED DB 100
	PRICE DB ?
	MPRICE DW ?
	QTY DB ?
	CHOICE DB ? 
	INPUT DB ? 
	ERRORMSG DB "INVALID ! PLEASE TRY AGAIN!$"   
	MSG4 DB "Do you want to order food(Y/N)?$" 
	
	FOODMENU	DB 10,13,"+-------------------------------+------------------+"
	     		DB 10,13,"|         FOOD MENU             |       PRICE      |"
	     		DB 10,13,"+-------------------------------+------------------+"
	     		DB 10,13,"| 1. TOMYAM MI SOUP             |       RM 12.50   |"
	     		DB 10,13,"| 2. NASI LEMAK                 |       RM 8.50    |"
	     		DB 10,13,"| 3. FRIED CHICKEN RICE         |       RM 10.20   |"
 	    		DB 10,13,"| 4. GARLIC FRIED RICE          |       RM 6.00    |"
	     		DB 10,13,"| 5. SWEET AND SOUR FILLET RICE |       RM 9.30    |"
	     		DB 10,13,"+-------------------------------+------------------+$"
	                                                                               
	FOODCHOOSE DB ?                                                                              
	
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX   
	
	CALL DIS_FOOD  
	MOV AH,09H		;NEW LINE
	LEA DX,NL
	INT 21H	
	
MAIN ENDP 
    
PURCHASE PROC    
    
AGAIN:
	MOV AH,09H	
	LEA DX,TITMSG 
	INT 21h

	MOV AH,09H		;NEW LINE
	LEA DX,NL
	INT 21H 
	
	MOV AH,09H		;NEW LINE
	LEA DX,NL
	INT 21H

	MOV AH,09H		
	LEA DX,MSG  ;prompt price message
	INT 21H  
	
	MOV AH,01H		
	INT 21H
	SUB AL,30H
	MOV PRICE,AL
	

	MOV AH,09H		
	LEA DX,NL
	INT 21H

	MOV AH,09H		;prompt quantity
	LEA DX,MSG1
	INT 21H
        
    MOV AH,01H                     
	INT 21H
	SUB AL,30H
	MOV QTY,AL

	MOV AH,09H		;NEW LINE
	LEA DX,NL
	INT 21H

	MOV AH,09H		;PRINT TOTAL PRICE
	LEA DX,MSG2
	INT 21H

	MOV AL,PRICE
	MUL QTY
	MOV MPRICE,AX
	
	CMP MPRICE,100		;CMP PRICE TO CHECK 3 DIGITS 
	JGE LOOP1
		
	MOV AH,0H		;DIV TEN
	MOV AX,MPRICE		
	DIV TEN
	MOV BX,AX
	
	MOV AH,02H
	MOV DL,BL
	ADD DL,30H
	INT 21H

	MOV AH,02H
	MOV DL,BH
	ADD DL,30H
	INT 21H	

	MOV AH,09H		;NEW LINE
	LEA DX,NL
	INT 21H			
	
	JMP CONT

	LOOP1: 
		
		MOV AH,0H		;DIV TEN
		MOV AL,BH		
		DIV TEN
		MOV BX,AX
	
		MOV AH,02H
		MOV DL,BL
		ADD DL,30H
		INT 21H

		MOV AH,02H
		MOV DL,BH
		ADD DL,30H
		INT 21H	

		MOV AH,09H		;NEW LINE
		LEA DX,NL
		INT 21H
	
	CONT:	
		MOV AH,09H		;NEW LINE
		LEA DX,NL
		INT 21H	
	
		MOV AH,09H		;CONTINUE?
		LEA DX,MSG3
		INT 21H

		MOV AH,01H		;INPUT CHOICE
		INT 21H
		MOV CHOICE,AL

		MOV AH,09H		;NEW LINE
		LEA DX,NL
		INT 21H

		MOV AH,09H		;NEW LINE
		LEA DX,NL
		INT 21H

		CMP INPUT,"N"
		JE EXIT
		JMP AGAIN   
		
	INVALID:
	    mov ah,09h
	    lea dx,ERRORMSG	
	    int 21h
	    JMP AGAIN		

	EXIT:
		MOV AX,4C00H
		INT 21H
PURCHASE ENDP 

MENU PROC 
    

   DIS_FOOD:
          MOV AH,09H
          LEA DX,FOODMENU
          INT 21H
          
          MOV AH,09H		;NEW LINE
		  LEA DX,NL
		  INT 21H	
		  
		  MOV AH,09H		;NEW LINE
		  LEA DX,NL
		  INT 21H	
		  
		  MOV AH,09H		;NEW LINE
		  LEA DX,NL
		  INT 21H	      
           
       QUESTION:
          
          MOV AH,09H		;CONTINUE?
	      LEA DX,MSG4
	      INT 21H   
	      
	      MOV AH,09H		;NEW LINE
		  LEA DX,NL
		  INT 21H	
		
		  MOV AH,09H		;NEW LINE
		  LEA DX,NL
		  INT 21H	
	      
	      MOV AH,09H		;NEW LINE
		  LEA DX,NL
		  INT 21H	
        
	      MOV AH,01H		;INPUT CHOICE
	      INT 21H
	      MOV FOODCHOOSE,AL   
	
	      CMP AL,"Y"
	      CALL PURCHASE
	
	      CMP AL,"N"
	      JE EXIT
	      JNE IINVALID
	      
	    IINVALID:
            mov ah,09h
	        lea dx,ERRORMSG	; error
	        int 21h
	        JMP QUESTION	
          
MENU ENDP
END MAIN