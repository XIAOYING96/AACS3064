.MODEL SMALL
.STACK 100
.DATA
   STR1 DB 20 DUP ('')
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,3FH
    MOV BX,00
    MOV CX,20
    LEA DX,STR1
    INT 21H
        
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP
END MAIN