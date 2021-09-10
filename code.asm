.model
.stack
.data  
 MENU DB 0dh, 0ah, "------------- MENU ----------", 0dh, 0ah
			DB "1. TOM YAM		RM 5", 0dh, 0ah
			DB "2. NASI LEMAK		RM 3", 0dh, 0ah  
			DB "3. CHICKEN RICE		RM 2", 0dh, 0ah
			DB "------------------------------", 0dh, 0ah, "$"  
 askOrder DB	13, 10, "Please place your order 1-3?", 0dh, 0ah, " --> $"
 askQuantity DB 13,10,"Please enter you quantity :$"   
 COUNT DB 0                                                     ;******** COUNT start from 0 NOT 3!!!!!
 err_msg DB 13,10,"**Invalid! PLease enter again!$"
 limit DB 13,10,"You have reached your limit or 3 orders!$"    
 
 ;message
 msg DB 13,10,"TOTAL :$" 
 msg1 DB 13,10,"Do you want to see the tax?$"
 msg2 DB 13,10,"Total Price:$"
 
 ;quantity
 qty DB 0   
 qty1 DB 0  
 
 ;DIVIDE
 ten DB 10    
 hun DB 100
 
 ;total
 total1 DB 0  
 total2 DB 0
 
 ;food price
 F1 DB 5 
 F2 DB 3
 F3 DB 2    
 
 ;digit
 digit1 DB 0
 digit2 DB 0  
 digit3 DB 0  
 digit4 DB 0
 digit5 DB 0   
 digit6 DB 0 
 digit7 DB 0   
 digit8 DB 0
 
 choice DB 0   
 
 ;tax 
 taxf1 DB 6
 taxf2 DB 4  
 tq1   DB 0
 tq2   DB 0
 
 ;TOTAL
 bigtaxtotal DB 0
 bigpricetotal DB 0
 
.code
main proc 
   mov ax,@data
   mov ds,ax
  
orderAgain:   
   mov ah,09h
   lea dx,menu
   int 21h
   
   mov ah,09h
   lea dx,askOrder      
   int 21h
   
   mov ah,01h
   int 21h
   mov choice,al
   
   cmp choice,"1"
   je addFood1  
   
   cmp choice,"2"
   je addFood2
   JNE error

   
addfood1:
    inc count
   mov ah,09h
   lea dx,askQuantity
   int 21h
   
   mov ah,01h
   int 21h
   mov qty,al
        sub qty,30h  
        
   MOV AL,0         ;**** AL not AH
   MOV AL,f1        ;*** wrong put in AL NOT AH
   mul qty
   add total1,al  
   
   LOOP_TAXF1:
        mov al,0
        mov al,taxf1
        mul qty
        
        add tq1,al
   jmp CHKCOUNT     
   
addfood2:
    inc count
   mov ah,09h
   lea dx,askQuantity
   int 21h
   
   mov ah,01h
   int 21h
   mov qty1,al
        sub qty1,30h  
        
   MOV AL,0         ;**** AL not AH
   MOV AL,f2        ;*** wrong put in AL NOT AH
   mul qty1
   add total2,al    
   
   LOOP_TAXF2:
        mov al,0
        mov al,taxf2
        mul qty1
        
        add tq2,al
   jmp CHKCOUNT     
   
CHKCOUNT:
    CMP COUNT, 3
    JL ORDERAGAIN
    JGE display   
      
error:
    mov ah,09h
    lea dx,err_msg
    int 21h
    jmp ORDERAGAIN  

display:
    mov ah, 09h
    lea dx, limit
    int 21h    
    
    mov ah,09h
    lea dx,msg1
    int 21h
    
    mov ah,01h
    int 21h
    
    cmp al,"y"
    call cal_tax   
    jmp exit
    cmp al,"n"
    call cal_pricetotal
    jmp exit
     
exit: 
    mov ah,4ch
    int 21h 
             
main endp    

cal_tax proc
    mov al,tq1
    add al,tq2
    
    mov bigtaxtotal,al   
    
    cmp bigtaxtotal,100
    jmp three
    
    cmp bigtaxtotal,10
    jmp two
    
three:
    mov al,bigtaxtotal     
    div hun
    mov digit8,dl 
    
    cmp al,10
    loop:
        div ten
        mov digit4,al
        mov digit5,ah
    
        mov ah,02h
        mov dl,digit4
            add dl,30h
        int 21h
       
        mov ah,02h
        mov dl,"."
        int 21h
       
        mov ah,02h
        mov dl,digit5
        add dl,30h
        int 21h       
    
two:    
    mov al,bigtaxtotal     
    div ten
    mov digit4,al
    mov digit5,ah
    
    mov ah,02h
    mov dl,digit4
        add dl,30h
    int 21h
       
    mov ah,02h
    mov dl,"."
    int 21h
       
    mov ah,02h
    mov dl,digit5
        add dl,30h
    int 21h   
   
cal_tax endp   

cal_pricetotal proc
      mov ah, 02h
      mov dx,0d0ah
      int 21h
      
      mov ah,09h
      lea dx,msg
      int 21h
      
      mov ax,0
      mov al,total1   
      add al,total2  
      
      mov bigpricetotal,al
      
      mov al,bigpricetotal
      div ten 
      
      mov digit1,al
      mov digit2,ah
      
      cmp digit1,10 ;check 2 digit
      je one
      
      mov ah,02h
      mov dl,digit1
        add dl,30h
      int 21h 
      
      mov ah,02h
      mov dl,digit2
        add dl,30h
      int 21h
   
      
one:
    mov ah,02h
    mov dl,total1
        add dl,30h
    int 21h
    
    mov ah,02h
    mov dx,0d0ah
    int 21h  
cal_pricetotal endp         

end main