TITLE TEST

.model small
.stack

.data 
	msg1	DB	0dh,0ah,"Enter you password >> $"
	input	DB	?
	PWC	DB	5	DUP(0)

.code
main proc
	mov ax, @data
	mov ds,ax

	;--display message
	mov ah,09h
	lea dx,msg1
	int 21h

	;--get user input
	mov ax,05h
	mov dl,03h
	int 21h
	mov PWC[dx],al
	

	mov ah,05h
	mov dl,input
	int 21h

	mov ah,07h
	int 21h

	mov ah,05h
	mov dl,al
	int 21h
	
	mov ah,4ch
	int 21h

main endp
end main


	