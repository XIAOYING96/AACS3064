.MODEL SMALL
.STACK
.DATA 
    MSG DB "******WELCOME TO OUT RESTAURANT******$"  
        
                             
    MENUTYPE DB 0DH,0AH,"+---------------------------+",0DH,0AH  
             DB "|          MENU TYPE        |",0DH,0AH  
             DB "+---------------------------+",0DH,0AH
             DB "|       1. FOOD MENU        |",0DH,0AH
             DB "|       2. DRINK MENU       |",0DH,0AH  
             DB "|       3. MAIN MENU        |",0DH,0AH
             DB "+---------------------------+",0DH,0AH,"$" 
    MSG1 DB 0DH,0AH,"PLEASE ENTER OPTION 1-3 ONLY :$" 
    MENUCHOOSE DB ?
                        
    FOODMENU DB 0dh,0ah,"+----------------------+---------------+",0dh,0ah
             DB "|    FOOD TYPE           |     PRICE   |",0DH,0AH
             DB "+------------------------+-------------+",0DH,0AH
             DB "| 1. TOMYAM SOUP         |     RM 12   |",0DH,0AH
             DB "| 2. NASI LEMAK          |     RM 7    |",0DH,0AH
             DB "| 3. CHICKEN RICE        |     RM 4    |",0DH,0AH
             DB "| 4. SOUR AND SWEET FISH |     RM 15   |",0DH,0AH
             DB "| 5. GARLIC FRIED RICE   |     RM 10   |",0DH,0AH
             DB "+------------------------+-------------+",0DH,0AH,"$" 
             
    FOOD1      DB 12
    FOOD2      DB 7
    FOOD3      DB 4
    FOOD4      DB 15
    FOOD5      DB 10 
    FDCHOICE     DB 0 
    ASKFDORDER DB "PLEASE PLACE YOU ORDER 1-5?",0DH,0AH,"-->$"
           
             
    DRINKMENU DB 0DH,0AH,"+------------------------+--------------+",0DH,0AH
              DB "|       DRINK TYPE       |     PRICE    |",0DH,0AH
              DB "+------------------------+--------------+",0DH,0AH
              DB "|     1. MILO            |   RM 2       |",0DH,0AH
              DB "|     2. ICE LIMAU       |   RM 1       |",0DH,0AH
              DB "|     3. TEH ICE         |   RM 2       |",0DH,0AH
              DB "+------------------------+--------------+",0DH,0AH,"$"  
    DRINK1 DB 2
    DRINK2 DB 1
    DRINK3 DB 2
    ASKDKORDER DB "PLEASE PLACE YOU ORDER 1-3?",0DH,0AH,"--> $" 
    DKCHOICE   DB 0
              
   MSG2         DB 13,10,"QUANTITY -->$"  
   PROMPT       DB 13,10,"DO YOU WANT TO CONTINUE ORDERING (y/n)?",0DH,0AH,"--> $"
   ERRMSG       DB 13,10,"INVALID. PLEASE ENTER OPTION 1-5 ONLY.",0DH,0AH,"$"   
   MSG3         DB 13,10,"YOU TOTAL IS :  RM $"   
   QTY          DB  0     
   TOTAL        DB  0  
   TEN          DB 10
   DIGIT1       DB 0
   DIGIT2       DB 0     
   MSG4         DB 13,10,"DO YOU WANT TO ORDER (y/n)?",0DH,0AH,"--> $"
   
     
.CODE
MAIN PROC     
     MOV AX,@DATA
     MOV DS,AX
     
     mov ah, 02h
	 mov dx, 0d0ah    ; NEW LINE
	 int 21h    
     
     MOV AH,09H
     LEA DX,MSG
     INT 21H 
	 
	 mov ah, 02h
	 mov dx, 0d0ah    ; NEW LINE
	 int 21h      
	 
	 mov ax, 02h
	 int 10h
	 
ASKAGAIN:    
     MOV AH,09H
     LEA DX,MENUTYPE
     INT 21H
     
     mov ah, 02h
	 mov dx, 0d0ah    ; NEW LINE
	 int 21h 
     
     MOV AH,09H
     LEA DX,MSG1
     INT 21H 
     
     MOV AH,01H
     INT 21H
     MOV MENUCHOOSE,AL
     
     CMP MENUCHOOSE,"1"
     JE FDMENU  
     
     CMP MENUCHOOSE,"2"
     JE DKMENU  
     
     CMP MENUCHOOSE, "3"
     JE MAIN


FDMENU:
   MOV AH,09H
   LEA DX,FOODMENU
   INT 21H 
   
   mov ah, 02h
   mov dx, 0d0ah    ; NEW LINE
   int 21h 
   
   MOV AH,09H
   LEA DX,MSG4
   INT 21H
   
   MOV AH,01H
   INT 21H
   
   CMP AL,"n"
   JZ ASKAGAIN  
   
   CMP AL,"y"
   CALL ORDERFD
   JNZ FDMENU          
            
           
DKMENU:
   MOV AH,09H
   LEA DX,DRINKMENU
   INT 21H 
        
   mov ah, 02h
   mov dx, 0d0ah    ; NEW LINE
   int 21h 
	       
	       
   MOV AH,09H
   LEA DX,MSG4
   INT 21H
   
   MOV AH,01H
   INT 21H
   
   CMP AL,"n"
   JZ ASKAGAIN  
   
   CMP AL,"y"
   CALL ORDERDK
   JNZ DKMENU         
MAIN ENDP


;-----------------------------food menu
ORDERFD PROC    
FDMENUOP:
     MOV AH,09H
     LEA DX,FOODMENU
     INT 21H
     
     MOV AH,09H
     LEA DX,ASKFDORDER
     INT 21H    
     
     MOV AH,01H  
     INT 21H
     
     MOV FDCHOICE,AL
     
     MOV AH,09H
     LEA DX,MSG2
     INT 21H    
     
     MOV AH,01H
     INT 21H
     MOV QTY,AL
        SUB QTY,30H
        
        
     MOV AH,02H
     MOV DX,0D0AH
     INT 21H
     
     CMP FDCHOICE,"1"
     JE ADDFOOD1
     
     CMP FDCHOICE,"2"
     JE ADDFOOD2
     
     CMP FDCHOICE,"3"
     JE ADDFOOD3
     JNE WRONG 
     
     CMP FDCHOICE,"4"
     JE ADDFOOD3
     JNE WRONG
      
     CMP FDCHOICE,"5"
     JE ADDFOOD3
     JNE WRONG 
     
WRONG:
    MOV AH,09H
    LEA DX,ERRMSG
    INT 21H
    JMP FDMENUOP
    
ASK:
    MOV AH,09H
    LEA DX,PROMPT
    INT 21H
    
    MOV AH,01H
    INT 21H
    CMP AL,"n"
    JE DISPLAYTOTAL
    CMP AL,"y"
    JE FDMENUOP
    JNE ASK
    
    
ADDFOOD1:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,FOOD1
    MUL BL
    ADD TOTAL,AL
    JMP ASK
    
ADDFOOD2:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,FOOD2
    MUL BL
    ADD TOTAL,AL
    JMP ASK
    
ADDFOOD3:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,FOOD3
    MUL BL
    ADD TOTAL,AL
    JMP ASK 
    
ADDFOOD4:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,FOOD4
    MUL BL
    ADD TOTAL,AL
    JMP ASK
    
ADDFOOD5:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,FOOD5
    MUL BL
    ADD TOTAL,AL
    JMP ASK

DISPLAYTOTAL:
    MOV AH,02H
    MOV DX,0D0AH
    INT 21H
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H   
    
    MOV AX,0
    MOV AL,TOTAL
    DIV TEN
    
    MOV DIGIT1,AL
    MOV DIGIT2,AH
    
    CMP DIGIT1,0
    JE LOOP
    
    MOV AH,02H
    MOV DL,DIGIT1
        ADD DL,30H
    INT 21H
    
    MOV AL,02H
    MOV DL,DIGIT2
        ADD DL,30H
    INT 21H
    
LOOP:
    MOV AH,02H
    MOV DL,TOTAL
        ADD DL,30H
    INT 21H
    
    MOV AH,02H
    MOV DX,0D0AH
    INT 21H
    
    CALL MAIN

ORDERFD ENDP 


;---------------------------drink menu    
ORDERDK PROC
    DKMENUOP:
     MOV AH,09H
     LEA DX,DRINKMENU
     INT 21H
     
     MOV AH,09H
     LEA DX,ASKDKORDER
     INT 21H    
     
     MOV AH,01H  
     INT 21H
     
     MOV DKCHOICE,AL
     
     MOV AH,09H
     LEA DX,MSG2
     INT 21H    
     
     MOV AH,01H
     INT 21H
     MOV QTY,AL
        SUB QTY,30H
        
        
     MOV AH,02H
     MOV DX,0D0AH
     INT 21H
     
     CMP DKCHOICE,"1"
     JE ADDRINK1
     
     CMP DKCHOICE,"2"
     JE ADDDRINK2
     
     CMP DKCHOICE,"3"
     JE ADDDRINK3
     
DKWRONG:
    MOV AH,09H
    LEA DX,ERRMSG
    INT 21H
    JMP DKMENUOP
    
ASKDK:
    MOV AH,09H
    LEA DX,PROMPT
    INT 21H
    
    MOV AH,01H
    INT 21H
    CMP AL,"n"
    JE DISPLAYDKTOTAL
    CMP AL,"y"
    JE DKMENUOP
    JNE ASKDK
    
    
ADDRINK1:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,DRINK1
    MUL BL
    ADD TOTAL,AL
    JMP ASK
    
ADDDRINK2:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,DRINK2
    MUL BL
    ADD TOTAL,AL
    JMP ASK
    
ADDDRINK3:
    MOV AX,0
    MOV BX,0
    MOV AL,QTY
    MOV BL,DRINK3
    MUL BL
    ADD TOTAL,AL
    JMP ASK

    
DISPLAYDKTOTAL:
    MOV AH,02H
    MOV DX,0D0AH
    INT 21H
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H   
    
    MOV AX,0
    MOV AL,TOTAL
    DIV TEN
    
    MOV DIGIT1,AL
    MOV DIGIT2,AH
    
    CMP DIGIT1,0
    JE LOOPDK
    
    MOV AH,02H
    MOV DL,DIGIT1
        ADD DL,30H
    INT 21H
    
    MOV AL,02H
    MOV DL,DIGIT2
        ADD DL,30H
    INT 21H
    
LOOPDK:
    MOV AH,02H
    MOV DL,TOTAL
        ADD DL,30H
    INT 21H
    
    MOV AH,02H
    MOV DX,0D0AH
    INT 21H
    
    CALL MAIN
ORDERDK ENDP
END MAIN