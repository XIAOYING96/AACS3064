.model small
.stack 100
.data
	count EQU 3
	char db count DUP ("A")

.code
main proc
	mov ax,@data
	mov ds,ax
	
;----- output byte : char
	mov ah,02h
	mov dl,char[0]
	int 21h

;------ output byte : char
	mov ah,02h
	mov dl,char[1]
	int 21h

;------ output byte : char
	mov ah,02h
	mov dl,char[2]
	int 21h

	mov ah,4ch
	int 21h
main endp
end main	