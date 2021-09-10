.MODEL SMALL
.STACK 100
.DATA

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV BX,+32
    MOV BX,-35
    JNG  L1
    JNGE L2
    JGE  L3
    
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
      
    L3:
      MOV AH,02H
      MOV DL,"3"
      INT 21H
      JMP EXIT  
      
    EXIT:
        MOV AH,4CH
        INT 21H

MAIN ENDP
END MAIN