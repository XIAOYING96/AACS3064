.MODEL SMALL
.STACK 100
.DATA
   MYDATA DB 1,2,3
   TOTAL  DB 0
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV CX,3
    MOV SI,0
    MOV AX,0
    
    A20:
        ADD DL,MYDATA[SI]
        INC SI
        LOOP A20
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