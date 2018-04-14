section .text
	global _replaceChar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;function;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
_replaceChar:
;save the stack frame pointer of the caller
	push ebp
	
;make the current top of stack the fram pointer of this function call (the callee)
;reference point for the parameters and local variables that were passed to funciton
	mov ebp, esp
	
;esi holds first parameter (pointer)
	xor esi, esi
	mov esi, [ebp + 8]
	
;eax holds search key
	xor eax, eax
	mov al, [ebp + 16]
	
;ecx holds the length of string
	xor ecx, ecx
	mov ecx, [ebp + 12]
	
;edi holds the replacement key
	xor edx, edx
	mov dl, [ebp + 20]
	
;counter
	xor edi, edi
	_loop:
		cmp byte [esi+edi], al
		je _replace
		cmp edi, ecx
		je _end
		inc edi
		jmp _loop
	
	_replace:
		mov [esi+edi], dl
		jmp _loop
	
	_end:
;move the result in eax
	xor eax, eax
	mov eax, esi
	
;restore the caller's stack frame pointer
	pop ebp
	
;pop the return address off the stack and into the IP (instruction resumes where the caller left off)
	ret
		
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;function;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
