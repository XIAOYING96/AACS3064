
.model small
.stack
.data
	msg1	DB	"In english : You like english and esspresso , excellent !$"
	msg2	DB	100 DUP	("$")
	segg	DB	"egg$"
	isFirst DB	0
	newline DB	0ah,0dh,"$"

.code
main proc
	mov ax,@data
	mov ds,ax
	
	;--(1) Print msg1 - unchanged
	mov ah,09h
	lea dx,msg1
	int 21h

	mov ah,09h
	lea dx,newline
	int 21h
	
	;--(2) Scan msg1 for first e
	mov si,0
	mov bx,0
	mov cx,0
	mov di,0
	
	;--(3) If it is first e ==> replace with egg
	;--(4) If not e ==> display no change to string chars
	;--(5) EXIT, once "$" terminate is detected
	;--msg1 "In english : You like english and esspresso , excellent !" 
checking:
	mov al,msg1[si]
	CMP al,"$"	;termination condition
	JE output	;if string ended go to output-> display & exit
	
	CMP al,"e"
	JNE noChange
	
	mov cl,isFirst
	CMP cl,0
	JE noChange
	CMP cl,1
	JE replace

replace:
	mov cx,3	;e-g-g == 3 chars = loop counter
      eggLoop:
	mov al,segg[di]
	mov msg2[si + bx],al
	inc bx
	inc di
	LOOP eggLoop
	
	mov di,0
	dec bx
	inc si
	JMP checking
	
noChange:
	mov msg2[si + bx],al
	inc si
	
	CMP al," "
	JE set1
	JNE set0
       
      set1:
	mov isFirst,1
	JMP checking

      set0:
	mov isFirst,0
	JMP checking

output:
	mov ah,09h
	lea dx,newline
	int 21h	
	
	mov ah,09h
	lea dx,msg2
	int 21h

	mov ah,4ch
	int 21h
main endp
end main