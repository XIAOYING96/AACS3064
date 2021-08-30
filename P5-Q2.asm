TITLE Encryption (P5-Q2.asm)
;--- Encryption means ==> Readable --> Not-Readable  
;--- Usually (use a key to encryption)
;--- (0) Define parameter list & storage for msg, key & str input     
;--- (1) Prompt secret word
;--- (2) Prompt key (1-9)
;--- (3) Encrypt with key (AL)
;--- (4) Disply Encrypted word

.model 
.stack
.data  
    msg1   DB  "Enter secret word: $"
    msg2   DB 0dh,0ah,"Enter encryption key(1-9):$"
    msg3   DB 0dh,0ah,"The encryption word is$"
    key    DB ?
    enWord DB 20 DUP("$")
    
    secret_list label byte
    maxin  DB 20
    actin  DB ?
    Sinput DB 20 DUP("$")
    
.code
main proc 
    mov ax,@data
    mov ds,ax

    ;--- (1) Prompt secret word
    mov ah,09h
    lea dx,msg1
    int 21h
    
    ;--- Get the user input string useing 0ah
     mov ah,0Ah
    lea dx,secret_list  ;CAREFUL!!!
    int 21h
    
    ;--- (2) Prompt key (1-9)   
    mov ah,09h
    lea dx,msg2
    int 21h
    
    ;--- Get user key input 1 char
    mov ah,01h
    int 21h   
    mov key,al
        sub key,30h    ;ascii to number
    
    
    ;--- (3) Encrypt with key (AL)     
    mov bx,0
    mov cl,actin ; loop counter
    
encrypting:
    
    mov al,Sinput[bx]
        add al,key  ;ascii in al ch by ch add with key
    mov enWord[bx],al 
    inc bx
    LOOP encrypting     
    
    ;--- (4) Disply Encrypted word   
     mov ah,09h
    lea dx,msg3
    int 21h
    
    mov ah,09h
    lea dx,enWord
    int 21h
     
    
    mov ah,4ch
    int 21h
    
main endp
end main