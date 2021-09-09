.model small
.stack
.data
    myData  DB  1,2,3,4
    total   DB  0
    
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ax,0
    mov bx,offset myData
    mov cx,03h
    
    here:
        add al,[bx]
        inc bx
        dec cx 
        jnz here
        mov total,al
        
        mov ah,02h
        mov dl,total
        add dl,30h
        int 21h
        
        mov ah,4ch
        int 21h
        
main endp
end main