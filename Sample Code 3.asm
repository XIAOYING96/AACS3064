; Past Year 2020 December Q4(c)s
; Problem : Reversing maximum 9 input characters with a spacing between each character
; Sample 1:
; Enter Characters (max 9): 1234ABC
; After reverse: C B A 4 3 2 1
; You have entered 7 character(s)
; Sample 2:
; Enter characters (max 9): visi
; After reverse: i s i v
; You have entered 4 character(s)

.model small
.stack
.data
	char_list label byte
	max_char DB 10
	act_char DB ?
	char_data DB 10 DUP ("$")

	prompt	DB 0dh, 0ah, " Enter characters (max 9): $"
	msg1	DB 0dh, 0ah, " After reverse: $"
	msg2	DB 0dh, 0ah, " You have entered $"
	msg3	DB " character(s) $"

	rev_data DB 10 DUP ("$")

.code
main proc
	mov ax, @data	; Q4(iii) initiate address of a data segment
	mov ds, ax

	;-- Q4(iv) prompt a message to receive input chars (2 marks)
	mov ah, 09h
	lea dx, prompt
	int 21h

	mov ah, 0ah
	lea dx, char_list
	int 21h

	;--- Q4(v) Prompt message to display the reverse seq + spacing
	mov ah, 09h
	lea dx, msg1
	int 21h

	;--- (1) Reversal by index
	mov si, 0
	mov ax, 0
	mov cx, 0
	mov bx, 0
	mov bl, act_char
	mov cl, act_char
	revLoop:
		mov al, char_data[bx - 1]
		mov rev_data[si], al
		mov ah, 02h
		mov dl, rev_data[si]
		int 21h
			mov ah, 02h
			mov dl, " "
			int 21h
		inc si
		dec bx
		Loop revLoop

	;--- Q4(vi)
	mov ah, 09h
	lea dx, msg2
	int 21h

	mov ah, 02h
	mov dl, act_char
		add dl, 30h
	int 21h

	mov ah, 09h
	lea dx, msg3
	int 21h

	mov ah, 4ch						; Q4(vii) terminate - 1 mark
	int 21h
main endp
end main