;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 	Kurtis B Waldner


; "build" file:
;		echo "building..."
;		nasm -f elf32 -g -F dwarf Lab0x05-main.asm
;		nasm -f elf32 -g -F dwarf Lab0x05-library.asm
;		echo "linking..."
;		ld -m elf_i386 Lab0x05-main.o Lab0x05-library.o -o go
;		./go


; run command:
;		./build


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

section .text      
	global _start     
	extern _replaceChar
	    
_start:

; which character r we searching for
	 mov edx, msg1len         
	 mov ecx, msg1
	 mov ebx, stdout
	 mov eax, sys_write
	 int 0x80
	 
	 mov edx, BUFFERSIZE 
    	 mov ecx, inBuffer 
    	 mov ebx, stdin        
   	 mov eax, sys_read   
    	 int 0x80
    	 
    	 cmp eax, 2
    	 jg _errormessage
    	 
    	 mov esi, inBuffer
    	 xor eax, eax
    	 mov eax, [esi]
    	 mov byte[search], al
    	 
; what is it's replacement? 
	 mov edx, msg2len         
	 mov ecx, msg2
	 mov ebx, stdout
	 mov eax, sys_write
	 int 0x80
	 
	 mov edx, BUFFERSIZE 
    	 mov ecx, inBuffer 
    	 mov ebx, stdin        
   	 mov eax, sys_read   
    	 int 0x80
    	 
    	 cmp eax, 2
    	 jg _errormessage
    	 
    	 xor eax, eax
    	 xor esi, esi
    	 mov esi, inBuffer
    	 mov eax, [esi]
    	 mov byte[replace], al

; What is the entire text we are working with?	 
	 mov edx, msg3len         
	 mov ecx, msg3
	 mov ebx, stdout
	 mov eax, sys_write
	 int 0x80

	 mov edx, BUFFERSIZE  
    	 mov ecx, text 
    	 mov ebx, stdin        
   	 mov eax, sys_read   
    	 int 0x80
    	 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    	 xor esi, esi
    	 
;pointer to begginning of array
    	 mov esi, text
    	 mov [pointer], esi
    	 
;length of array
    	 dec eax
    	 mov [length], eax

;paramaters for the calling function	 (last parameter pushed first)
	push dword[replace] ; ebp+20
	push dword[search]  ; ebp+16
	push dword[length]  ; ebp+12
	push dword[pointer] ; ebp+8
	
;call the function
	call _replaceChar
	
;pop parameters off the stack --really just add # of bytes for four parameters to esp 
	add esp, 20
	
;save the result from the function that was stored in eax
	mov [modifiedText], eax
	
;let's take a look at your new text...
	mov edx, msg4len	         
	mov ecx, msg4
	mov ebx, stdout
	mov eax, sys_write
	int 0x80
	
;print the modified text
	mov edx, BUFFERSIZE        
	mov ecx, [modifiedText]
	mov ebx, stdout
	mov eax, sys_write
	int 0x80
	
_exit:
	    mov edx, 1           
	    mov ecx, 0x0A
	    mov ebx, stdout
	    mov eax, sys_write
	    int 0x80 
	    
	    mov edx, msg5len         
	    mov ecx, msg5
	    mov ebx, stdout
	    mov eax, sys_write
	    int 0x80            

	    mov ebx, 0         
	    mov eax, 1         
	    int 0x80  

_errormessage:
	    mov edx, msg6len         
	    mov ecx, msg6
	    mov ebx, stdout
	    mov eax, sys_write
	    int 0x80 
	    
	    mov byte[inBuffer], 0x00000000
	    
	    jmp _start 

section .data
	msg1 db 'Which character are you searching for? ', NEWLINE, 0
	msg1len equ $-msg1
	
	msg2 db 'What character do you want to replace it with?', NEWLINE, 0
	msg2len equ $-msg2
	
	msg3 db 'Enter lines of text followed by a blank line', NEWLINE, 0
	msg3len equ $-msg3
	
	msg4 db 'Let us take a look at your new text....', NEWLINE, 0
	msg4len equ $-msg4
	
	msg5 db 'Wrapping up now, will see you later! ', NEWLINE, 0
	msg5len equ $-msg5

	msg6 db 'Error: Only enter one character until prompted otherwise...', NEWLINE, 0
	msg6len equ $-msg6
	
section .bss

	inBuffer resb 2
	text resb BUFFERSIZE
	outBuffer resb 1
	search resb 4
	replace resb 4
	pointer resb 4
	length resb 4
	modifiedText resb BUFFERSIZE
;;;;;;;;;;;;;; Constants ;;;;;;;;;;;;;;;;;;;;;;
sys_read  equ 0x03
sys_write equ 0x04
stdin     equ 0x00
stdout    equ 0x01
stderr    equ 0x02
BUFFERSIZE equ 100
SPACE     equ 0x20  
NEWLINE   equ 0x0A

