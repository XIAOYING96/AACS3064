TITLE	Division (P2-Q7.asm)
;---- Sample 8/5 = 1..3
;---- Dividend = 8; Divisor = 5
;---- Quotient = 1; Remainder = 3
;---- div cl(1 byte) al = quotient; ah =remainder
;---- div cl => ax = al/cl = 8/5.. al=1; ah=3
;---- input = ASCII ; math = non-ASCII; output=ASCII


.model small
.stack

.data
	msg1 		DB 0dh,0ah, "Dividend : $"
	msg2 		DB "Divisor: $"
	msg3 		DB "Quotient: $"
	msg4 		DB "Remainder: $"
	in_dividend 	DB ?
	in_divisor 	DB ?
	out_quotient 	DB ?
	out_remainder 	DB ?

.code
main proc
	mov ax, @data
	mov ds, ax

	;--- Code starts here
	;--- display msg1 = devidend
	mov ah, 09H
	lea dx, msg1	
	int 21H

	;--- Get user input of divident + store
	mov ah, 01H		; 1 char input al =user input in ASCII
	int 21H
	mov in_dividend, al	; ASCII input
	
	;--- newline
	mov ah, 02H
	mov dx, 0d0aH
	int 21H

	;--- display msg2 = devisor
	mov ah, 09H
	lea dx, msg2	
	int 21H

	;--- Get user input of divisor + store
	mov ah, 01H		; 1 char input al =user input in ASCII
	int 21H
	mov in_divisor, al	; ASCII input
	
	;---compute output
	;--- convert ASCII to correct numeric values
	sub in_dividend, 30h	; ASCII -> num
	sub in_divisor, 30h	; ASCII -> num

	;--- perform DIVISION
	mov ax, 00H		; reset register before use
	mov al, in_dividend	; al = in_dividend; al = 8
	div in_divisor		; ax = al/in_divisor
				; ax = 8/5 = 1...3
				; al = 1
				; ah = 3

	;--- store output q&r in memory + convert to ASCII
	mov out_quotient, al	; 
	    add out_quotient, 30h	; convert to ASCCI to display
	mov out_remainder, ah	; 
	    add out_remainder, 30h	; convert to ASCCI to display

	;--- newline
	mov ah, 02H
	mov dx, 0d0aH
	int 21H	

	;--- display msg 3 quotient + output
	mov ah, 09H
	lea dx, msg3	; display qiotient
	int 21H
	mov ah, 02H
	mov dl, out_quotient
	int 21H

	;--- newline
	mov ah, 02H
	mov dx, 0d0aH
	int 21H

	;--- display msg 4 quotient + output
	mov ah, 09H
	lea dx, msg4	; display remainder
	int 21H
	mov ah, 02H
	mov dl, out_remainder
	int 21H

	;--- terminate
	mov ah, 4ch
	int 21h
main endp
end main