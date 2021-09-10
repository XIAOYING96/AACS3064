.model small
.stack 100
.data
    myData DB 2,4,7,'H','A',9

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov si,0
    
    CHK:
        cmp myData[si],"A"
        jnae next   
        cmp myData[si],"Z"
        jbe print
        ja next
        
    next:
        inc si
        jmp chk
        
    print:
        mov ah,02h
        mov dl,mydata[si]
        int 21h
        
    exit:
        mov ah,4ch
        int 21h
        
        
main endp
end main