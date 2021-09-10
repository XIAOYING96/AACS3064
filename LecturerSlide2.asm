.MODEL SMALL
.STACK 100
.DATA

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AL,+127
    MOV AL,-128
    JA L1
    JG L2
    
    L1:
      MOV AH,02H
      MOV DL,"1"
      INT 21H
      JMP EXIT
      
    L2:
      MOV AH,02H
      MOV DL,"2"
      INT 21H
      JMP EXIT
      
      EXIT:
        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN