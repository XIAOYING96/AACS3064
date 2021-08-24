TITLE   Multiplication (2 disgits) (P2-Q5.asm)
;--- User input its in ACSII
        ;--- User input = Dec num "6" = 36h in ACSII

;--- To compute, pls convert to number first (ACSII --> Hex)
        ;--- 36h - 30h = 6 (in Dec num) multiply

;--- To display, answer must be convert back to ACSII   
        ;--- answer 6 * 6 = 36 (30h in ACSII)
        ;--- split 36 into 3(+30h) & 6(+30h)
        ;--- display 1st ACSII digit = 3 ("33h" in ACSII)
        ;--- display 2nd ACSII digit = 6 ("36h" in ACSII)

.model small
.stack 100
.data
        msg1    DB "Please enter a digit: $"
        msg2    DB " times $"
        msg3    DB " return: $"
        input   DB ?
.code
main proc
        mov ax, @data
        mov ds, ax

        ;--- code start here
        ;--- display msg1
        mov ah, 09h     ; display a string end with $
        lea dx, msg1    ; or mov dx, offset msg1
        int 21h

        ;--- get user 1 digit input
        mov ah, 01h     ; user input of 1 char
        int 21h         ; user input enter al

        ;--- computation of input * input = result
        ;--- convert ACSII to num (-30h)
        sub al, 30h     ; al = al - 30h
        mov input, al   ; input = al 

        ;--- multiplication
        mul input       ; input * input

        ;--- splitting of 1st & 2nd digit
        mov cl, 10      ;  divisor to split
        div cl          ; ax = al / cl
        mov ch, ah      ; e.g. 36(dividend)/10(divisor)
        mov cl, al      ; e.g. 3(quotient) = al, 6(remainder) = ah
                        ; e.g. ch = ah = remainder = 6 = 2nd digit
                        ; e.g. cl = al = quotient = 3 = 1st digit

        ;--- newline
        mov ah, 02h
        mov dl, 0dh     ; carraige return (align to the left)
        int 21h
        mov dl, 0ah     ; enter (newline)
        int 21h

        ;--- print user input (ASCII) +30h
        mov ah, 02h     ; display single char
        mov dl, input   ; dl = non-ASCII number
        add dl, 30h     ; convert dl to ASCII number
        int 21h

        ;--- display msg2
        mov ah, 09h
        lea dx, msg2    ; or mov dx, offset msg2
        int 21h

        ;--- print user input (ASCII) +30h
        mov ah, 02h     ; display single char
        mov dl, input   ; dl = non-ASCII number
        add dl, 30h     ; convert dl to ASCII number
        int 21h

        ;--- display msg3
        mov ah, 09h
        lea dx, msg3    ; or mov dx, offset msg3
        int 21h

        ;--- display 1st & 2nd  digit (ASCII) +30h
          ;--- ch = ah = remainder = 2nd digit
          ;--- cl = al = quotient = 1st digit
        mov ah, 02h
        mov dl, cl      ; print 1st digit
        add dl, 30h     ; convert to ASCII
        int 21h

        mov ah, 02h
        mov dl, ch      ; print 2nd digit
        add dl, 30h
        int 21h
        
        ;--- terminate
        mov ah, 4ch
        int 21h

main endp
end main
