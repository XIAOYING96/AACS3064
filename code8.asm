TITLE Find Largest Number (9-6.asm)
;--- (1) Prompt user to enter 5 Decimal DIgit
;--- (2) Accept user input (assume user input 5 dec)
;--- (3) Find largest value in the list
;--- (4) Display Largest value on the screen
;--- Smaple Output:
;--- Please enter 5 decimal digit >> 35827
;--- The largest value in the list >> 8

.model small
.stack
.data
	prompt DB "Please enter 5 decimal digits >> $"
	msg    DB "The largest value in the list >> $"
	input  DB 5 DUP (0)
	largest DB 0

.code
main proc
	mov ax,@data
	mov ds,ax

	;--- (1) Prompt user to enter 5 Decimal Digit
	mov ah,09h
	lea dx,prompt
	int 21h
	
	;--- (2) Accept user input (assume user input 5 dec)
	mov cx,5	;5 decimal in loop center
	mov si,0	;index

getinput:
	mov ah,01h	;user input = al
	int 21h
	mov input[si],al
	inc si
	LOOP getinput
	
	;--- (3) Find largest value in the list
	mov cl,input[0]
	mov largest,cl	; place 1st digit inside largest temp
	mov si,1

checkLargest:
	cmp si,5
	je display
	
	mov cl,input[si]
	cmp largest,cl
	ja more
	jb less
	
more:
	inc si
	jmp checkLargest
	
less:
	mov largest,cl
	inc si
	jmp checkLargest

	;--- (4) Display Largest value on the screen
display:	
	mov ah,09h
	lea dx,msg
	int 21h
	
	mov ah,02h
	mov dl,largest
	int 21h

	mov ah,4ch
	int 21h
main endp
end main