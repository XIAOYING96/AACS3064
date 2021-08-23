TITLE yes or no(P4-Q2.asm)
;--(1) When executed .Print A automatically
;--(2) Prompt continue y or n?
;--(3) Get user input 
;--(4) If y... then continue print B...C...D...
;--(5) If n..exit
;--(6) Default case not y or n.. then error & askAgain(2)

.model small
.stack
.data
	msg1  	DB 0dh,0ah,"Do you want to continue printing (y/n)?$"
	Achar	DB "A"
	err_msg DB 0dh,0ah,"Invalid.Please enter y or n only. $"
	newline	DB 0dh,0ah,"$"

.code
main proc
	mov ax,@data
	mov ds,ax
	
	;--(1) When executed .Print A automatically
display:
	mov ah,09h
	lea dx,newline
	int 21h
	
	mov ah,02h
	mov al,Achar	;char A prints first thenB...C...
	int 21h
		int Achar	;Achar = Achar + 1
	
	
	;--(2) Prompt continue y or n?
askAgain:
	mov ah,09h
	lea dx,msg1	; the prompt
	int 21h
	
	;--(3) Get user input 
	mov ah,01h	;input with echo goes into AL = user input of 1 char
	int 21h
	
	
	
	
	;--(4) If y... then continue print B...C...D...
	;--(5) If n..exit
	;--(6) Default case not y or n.. then error & askAgain(2)
	CMP al,"y"
	JE display
	CMP al,"n"
	JE exit
	JNE error

error:
	mov ah,09h
	lea dx,err_msg	; error
	int 21h
	JMP askAgain	

exit:	
	mov ah,4ch
	int 21h
	
main endp
end main
	