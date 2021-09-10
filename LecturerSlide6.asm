.MODEL SMALL
.STACK 100
.DATA
   MYDATA DB 1,2,3
   TOTAL  DB 0
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AX,0
    MOV BX,OFFSET MYDATA
    MOV CX,03H
    
    A20:
        ADD AL,[BX]
        INC BX
        DEC CX
        JNZ A20
        MOV TOTAL,AL
        
    PRINT:
        ADD TOTAL,30H
        MOV AH,02H
        MOV DL,TOTAL
        INT 21H
        
    EXIT:
        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN