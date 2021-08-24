TITLE Upper to lower case A , a (P2-Q2.asm)

.model small
.stack 100
.data

	letter DB "a"	; ASCII for A = 41H , a = 61H


.code
main proc 
	mov ax,@data	; set/init add for DS
	MOV ds,ax

	;-----Display capital "A" (letter = 41H)
	mov ah,02h	;display 1 char
	mov dl,letter	;letter = 41h rep "A"
	int 21h

	;-----Display a "," 2C hex
	mov ah,02H	
	mov dl,2ch	;dl = 2ch(represent ",")
	int 21H

	;-----Convert Big A to small a (41H ==> 61H) + 20H
	sub letter, 20H	;letter = letter + 20H = 61h

	;-----Display my converted small a 
	mov ah,02h	; display 1 single char
	mov dl,letter	;letter = 61h = REP "a"
	int 21h

	;-----Terminate Program
	mov ah,4ch
	int 21h
main endp
end main 