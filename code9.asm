TITLE VOWEL (9-5.asm)
;--- Count vowels in "This is my favourite"
;--- Sample output :
;--- a=1, e=1,i=3,o=1,u=0

.model small
.stack
.data
	msg DB "This is my favourite$"
	cA  DB 30H
	cE  DB 30H
	cI  DB 30H
	cO  DB 30H
	cU  DB 30H
	mA  DB 0dh,0ah," a = $"
	mE  DB " e = $"
	mI  DB " i = $"
	mO  DB " o = $"
	mU  DB " u = $"	

.code
main proc
	mov ax,@data
	mov ds,ax

	;--- init my index register
	mov si,0
	
AGAIN:
	mov bh,msg[si]

	cmp bh,"a"
	JE countA

	cmp bh,"e"
	JE countE
	
	cmp bh,"i"
	JE countI

	cmp bh,"o"
	JE countO

	cmp bh,"u"
	JE countU

	cmp bh,"$"
	JE DISPLAY

	inc si
	LOOP AGAIN
	
countA:
	inc cA	
	inc si
	JMP AGAIN

countE:
	inc cE	
	inc si
	JMP AGAIN

countI:
	inc cI	
	inc si
	JMP AGAIN

countO:
	inc cO	
	inc si
	JMP AGAIN

countU:
	inc cU	
	inc si
	JMP AGAIN

DISPLAY:
	;--- NEWLINE
	MOV AH,02H
	mov DX,0d0ah
	INT 21H

	;--- PRINT AEIOU
	MOV AH,09H
	LEA DX,mA
	int 21h
		mov ah,02h
		mov dl,cA
		int 21h


	MOV AH,09H
	LEA DX,mE
	int 21h
		mov ah,02h
		mov dl,cE
		int 21h

	
	MOV AH,09H
	LEA DX,mI
	int 21h
		mov ah,02h
		mov dl,cI
		int 21h

	MOV AH,09H
	LEA DX,mO
	int 21h
		mov ah,02h
		mov dl,cO
		int 21h


	MOV AH,09H
	LEA DX,mU
	int 21h
		mov ah,02h
		mov dl,cU
		int 21h

	;--- exit
	mov ah,4ch
	int 21h

main endp
end main