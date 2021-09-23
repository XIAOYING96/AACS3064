TITLE Reverse_Color_String_Input
;-- Note NUmbers without H are  Decimal
; 0dh = 13 in decimal  & 0ah = 10 in decimal

.model small
.stack
.data
	data1	DB "STRESSED", 0dh, 0ah, "$"
	data2	DB 8 DUP ("#"), 0dh, 0ah, "$"
	msg1	DB "Data1: I am $"
	msg2	DB "Data2: I ", 03H, " $"
	msg3	DB "Press 1 for Quiz", 0dh, 0ah, "Press 2 for Date", 0dh, 0ah, "Press 3 to Quit", 0dh, 0ah,"Ans: ","$"
	msg4    DB "Iron Man's Family Name (in lower case)? $"
	msg5	DB "Today's Date is: $"
	msg6	DB "Choose a Color R or B"
	newline DB  0dh, 0ah, "$"
	mright	DB "YES! Bravo! $" ; RED
	mwrong	DB "Oops! $"	   ; CYAN
	nocolor DB "Wrong Color. Please Type Capital R or B only!$"
	input	DB 5 DUP("0"),"$"
	answer	DB "stark$"
	month	DB	?
	day		DB	?
	year	DB	"2021$"
	user_in	DB ?

.code
main proc 
		mov ax, @data
		mov ds, ax

		;--- original & data1
		mov ah, 09h
		lea dx, msg1
		int 21h

		lea dx, data1
		int 21h

		;--- modification
		  mov cx, 8			; 8 characters, loop 8 times (lengthof data1)
		  lea si, data1		; Offset Address of data1 --> STRESSED
		  lea di, data2		; Offset Address of data2 --> ########
		   add di, 7		; di = last index of char in STRESSED (0-7) = 8 chars

		; mov si, 0			; alternative after mov cx, 8 line
		; mov di, 7			; get index of last char in data1

		changing:
			mov al, [si]	; mov al, data[si]
			mov [di], al	; mov data[di], al
			inc si
			dec di
			loop changing

		;--- modified & data2
		mov ah, 9h
		lea dx, msg2
		int 21h

		lea dx, data2
		int 21h

		;--- Main Menu
menu:	
		;--newline
		mov ah, 09h
		lea dx, newline
		int 21h

		mov ah, 09h
		mov dx, offset msg3
		int 21h

		;--- user input choice
		mov ah, 01h
		int 21h			; ascii input in AL
		sub al, 30h

		;--newline
		mov ah, 09h
		lea dx, newline
		int 21h

		;--- compare AL
		cmp al, 1
		JE quiz
		cmp al, 2
		JE date0
		cmp al, 3
		JE quit

quit :	jmp exit
date0:	jmp date
quiz:
		mov ah, 09h
		lea dx, msg4
		int 21h

		;-- get input from keyboard
		mov ah, 3Fh				; read an array of bytes from keyboard-0		
		mov bx, 0				; bx = 0 (select keyboard)
		mov cx, 5				; cx = 127 (maximum bytes to read)
		lea dx, input			; stored in DS:DX
		int 21h			

		;--newline
		mov ah, 09h
		lea dx, newline
		int 21h

		;--- compare with answer
		mov cx, 5
		mov bx, 0
		check:
			mov al, input[bx]
			inc bx					; increment index
			cmp al, answer[bx-1]
			LOOPE check				; loop if equal
		
		JE right					; if input - answer = 0 = EQUAL -> goto right
		JNE wrong					; if input - answer = NON 0 -> goto wrong

		wrong:
			mov ah, 09h
			lea dx, mwrong
			int 21h
			JMP menu		; go back to main menu

		right:
			mov ah, 09h
			lea dx, mright
			int 21h

	again:	lea dx, msg6
			int 21h

			mov ah, 01h
			int 21h
			mov user_in, al

			;--newline
			mov ah, 09h
			lea dx, newline
			int 21h

			cmp user_in, "R"
			JE setR

			cmp user_in, "B"
			JE setB
			JNE setDefault

		setR:
			mov bl, 04h			; red chars
			lea dx, mright
			jmp display

		setB:
			mov bl, 3Bh			; cyan & light cyan		
			lea dx, mright
			jmp display

		setDefault:
			mov bl, 08h			; green & light green
			lea dx, nocolor
			jmp display

		display:
			;--- color display INT 10h
			mov ah, 09h
			mov cx, 12			; 12 characters to change
			int 10h				; bl = attribute depend on setR or setB

			mov ah, 09h
			int 21h

		JMP menu				; go back to main menu

date:
		mov ah, 09h
		mov dx, offset msg5
		int 21h

		;--- get Today's DATE
		mov ah, 2ah				; get system date
		int 21h					; cx = year dh = month dl = day al= dayofweek

		;--- display day-month-year (dl-dh-cx)
		mov day, dl				; day = dl-did not split 2 digit yet. Wrong if > 10
		mov month, dh			; month = dh-did not split 2 digit yet. Wrong for 11 & 12
		
		mov cx, 0				; reset cx
		mov ax, 0				; reset ax

		;--- DAY
		;--- DAY-Spliting of dl=day + add 30h into ascii
		mov cl, 10				; 10 to split digit
		mov al, day				; al = dl day
		div cl					; ax = ax/10 = al=digit 1 ah=digit2
		mov ch, ah
		mov cl, al

		mov ah, 02h
		mov dl, cl				; day-digit 1
			add dl, 30h
	    int 21h
		mov dl, ch				; day-digit 2
			add dl, 30h
		int 21h

		mov ah, 02h
		mov dl, "-"
		int 21h

		;--MONTH
		mov cx, 0				; reset cx
		mov ax, 0				; reset ax
		;--- MONTH-Spliting dh = month + add 30h into ascii
		mov cl, 10				; 10 to split digit
		mov al, month			; al = dl month
		div cl					; ax = ax/10 = al=digit 1 ah=digit2
		mov ch, ah
		mov cl, al

		mov ah, 02h
		mov dl, cl				; month-digit 1
			add dl, 30h
	    int 21h
		mov dl, ch				; month-digit 2
			add dl, 30h
		int 21h

		mov dl, "-"
		int 21h

		mov ah, 09h
		mov dx, offset year
		int 21h
		
		JMP menu				; go back to main menu

exit:	mov ah, 4ch
		int 21h
main endp
end main

