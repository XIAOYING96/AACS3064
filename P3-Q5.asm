TITLE FIBBONACCI NUMBER (P3-Q5.ASM)
;----USE loop to cal first 6 values of fib
;----Fib(1) = 1, Fib(2) = 1, 1 Fin(n) = Fib(n-1) + fib(n-2)
;----Place each values in the array & display it


.model small
.stack
.data
	arr		DB 	6 DUP(?)
	input		DB	?
	index		DB	0
	msg		DB	"Please Enter < 7 number of Fib(n) : $"
	newline		DB	0dh, 0ah, "$"
	space		DB	" "

.code
main proc
	mov ax, @data
	mov ds, ax

	;----Code starts here
	;----Display Message
	mov ah, 09h
	lea dx, msg
	int 21h

	;----User input < 7
	mov ah, 01h	;al = user input
	int 21h
	mov input, al
		sub input, 30h

	;----Newline
	mov ah, 09h
	lea dx, newline
	int 21h

	;----START Fib(n) = Fib(n-1) + Fib(n-2)
	mov index, 0
myLoop:

	;----index 0 & 1 (<2) start here
	CMP index, 0
	JE put1		;put 1 inside arr at index = 0
	CMP index, 1
	JE put1		;put 1 inside arr at index = 1

	;---- index 3 & beyond BUT < 7
	; For 3rd number onwards Fib(n) = Fib(n-1) + Fib(n-2)
	mov bx, 0		; reset base add as index reg
	mov bl, index		; bl = cuurrent arr index value
	dec bx			; bx = n - 1
	mov dl, [arr + bx]	; dl = value = fib(n-1)
	dec bx			; bx = n - 1
	add dl, [arr + bx]	; add dl = value = fib(n-1) + fib(n-1)

	;----Place into array, for 3rd and beyond
	mov bx, 0	;reset my base reg for index
	mov bl, index	;buffer back in my current index
	mov [arr + bx], dl	; mov ans for fib(n-2) + fib(n-1) into curr arr index

	;---Jump to continueNext
	JMP continueNext
put1:

	mov bl, index		; place bl = cur index of 0/1
	mov [arr + bx], 1	; place 1 into array

continueNext:
	inc index
	mov cl, index
	CMP cl, input	;terminate
	JL myLoop	;jump tomyLoop ONLY IF cl < input
	
	;----Display Array value
	mov index, 0	;reset my index
	mov dx, 0	;reset my dx = 0
	mov bx, 0	;reset my bx = 0

	DisplayLoop:
		mov ah, 02h
		mov bl, index
		mov dl, [arr + bx]
			add dl, 30h
		int 21h

	;---Display space
		mov ah, 02h
		mov dl, space
		int 21h

	;----int & print remaining array
		inc index
		mov al, index	;al = current index 	
		CMP al, input
		JL DisplayLoop

	;----Terminate
	mov ah, 4ch
	int 21h

main endp
end main
	