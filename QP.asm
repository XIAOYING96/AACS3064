.model small
.stack
.data
	NUM DB 1,5,2,4,11,10,6
	evennum DB ?
	oddnum DB ?
	divide DB 2
	MSG1 DB 0DH,0AH,"There are $"
	MSG2 DB " odd numbers and $"
	MSG3 DB " even number in the NUM.$"
.code
main proc

	mov ax,@data
	mov ds,ax

	mov si,0

cal:
	CMP si,7
	JE printmsg
	mov al,NUM[si]
	div divide
	cmp ah,00
	JNZ odd
	JMP eveneven
	

eveneven:
	mov al,evennum
	add al,1
	mov evennum,al
	INC SI
	JMP cal
odd:
	mov al,oddnum
	add al,1
	mov oddnum,al
	INC SI
	JMP cal

printmsg:
	MOV AH,09h
	LEA DX,MSG1
	INT 21H
	mov ah,02h
	mov dl,oddnum
	add dl,30h
	int 21h
	MOV AH,09h
	LEA DX,MSG2
	INT 21H
	mov ah,02h
	mov dl,evennum
	add dl,30h
	int 21h
	MOV AH,09h
	LEA DX,MSG3
	INT 21H

	MOV AH,4CH
	INT 21H

main endp
end main
	