TITLE	Division (P2-Q7.asm)

.model small
.stack

.data
	msg1 		DB 0dh,0ah, "Dividend : $"
	msg2 		DB "Divisor: $"
	in_dividend 	DB ?
	out_quotient 	DB ?

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

	;--divide tax
	mov al,in_dividend
	sub 6

	;---convert into percentage
	div al,100
	
	;---compute output
	;--- convert ASCII to correct numeric values
	sub in_dividend, 30h	

	;--- perform DIVISION
	mov ax, 00H		
	mov al, in_dividend	
	div in_divisor		
				
	;--- store output q&r in memory + convert to ASCII
	mov out_quotient, al	; 
	    add out_quotient, 30h	; convert to ASCCI to display

	;--- newline
	mov ah, 02H
	mov dx, 0d0aH
	int 21H	

	;--- display msg 3 quotient + output
	mov ah, 02H
	mov dl, out_quotient
	int 21H


	;--- terminate
	mov ah, 4ch
	int 21h
main endp
end main