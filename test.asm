.model small
.stack
.data
	myData DB 2,4,7,'H','A',9

.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov si,0

	chk:
		CMP myData[si],"A"
		JNAE next
		cmp myData[si],"Z"
		jbe print
		ja next
	next:
		inc si
		jmp chk

	print:
		mov ah,02h
		mov dl,myData[SI]
		int 21h

	exit:
		mov ah,4ch
		int 21h

main endp
end main

	
	