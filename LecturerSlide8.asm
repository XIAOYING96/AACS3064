.MODEL SMALL
.STACK 100
.DATA
   STR1 DB "MY ASSEMBLY LANGUAGE$"
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    SETTING:
        MOV AH,02H
        MOV BH,00
        MOV DX,080FH
        INT 10H
        
    PRINT:
        MOV AH,09H
        LEA DX,STR1
        INT 21H
        
    EXIT:
        MOV AH,4CH
        INT 21H
        
MAIN ENDP
END MAIN