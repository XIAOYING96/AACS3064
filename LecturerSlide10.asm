.MODEL SMALL
.STACK 100
.DATA
   STR1 DB "MY ASSEMBLY LANGUAGE$"
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    SETTING:
        MOV AX,0600H
        MOV BH,71H 
        MOV CX,0500H
        MOV DX,0C4FH
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