.MODEL SMALL
.STACK 100
.DATA
   OPTION DB 0
   VMSG   DB 13,10,"~~~VALID~~~$"
   NVMSG  DB 13,10,"~~~INVALID~~~$"
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    ;--INPUT BYTE : 01H
    MOV AH,01H
    INT 21H
    MOV OPTION,AL      
    
    ;--COMPARE
    CMP OPTION,"0"
    JNAE NVALID
    
    CMP OPTION,"9"
    JBE VALID
    
    JNB NVALID
    
    VALID:
        MOV AH,09H
        LEA DX,VMSG
        INT 21H
        JMP EXIT
        
    NVALID:
        MOV AH,09H
        LEA DX,NVMSG
        INT 21H
        JMP EXIT
    
    EXIT:
        MOV AH,4CH
        INT 21H   
        

MAIN ENDP
END MAIN