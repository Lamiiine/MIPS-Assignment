
; Checking the a20 gate if it is enabled
check_a20_gate:
    pusha                                   ; Save all general purpose registers on the stack
	   mov bx , 0
label_1: 
           mov ax,0x2402
	   int 0x15
	   jc error ; look up the jump carry, and jmp to error(define below)
	   cmp al,0x0 ; compare the value in al with 0 and act upon the result
	   jne  end ; if the result of the comparaison is not equal, then jump to end
	   mov si , a20_not_enabled_msg
	   call bios_print	
           cmp bx ,1
	   jne enable_a20  ; else jump to enable the a20 gate
;----------Hardware Message------------   
	mov si,a20_hardware_error
	call bios_print
	jmp hang
;Enabling the a20 gate function	
enable_a20:
	pusha
	mov ax,0x2401 
	int 0x15
	jc error
	mov bx , 1
	jmp label_1 ; if not error jump to check bx again if 0 or 1
; Error function to handle the different types of errors
error:
	cmp ah, 0x1 ; one type of errors is ah not equal to 0x1, 
	je SecureMode ; if equal then jump to SecureMode label to print a message
	cmp ah , 0x86 ; if it's not in secure mode, we check if the value is equal to 0x86
	je notSupported ; if equal to 0x86 then jump to the label notSupported to print a message
	unknownError: ; else, print an unknown Error
	mov si , unknown_a20_error
	call bios_print	
	jmp hang
;------------------SecureMode Label	
SecureMode:
	mov si , keyboard_controller_error_msg
	call bios_print
	jmp hang
;-----------------notSupported label
notSupported:
	mov si , a20_function_not_supported_msg
	call bios_print	
	jmp hang
error_1:
mov si , a20_not_enabled_msg
call bios_print
jmp hang

end:
    mov si , a20_enabled_msg
    call bios_print
    popa                                ; Restore all general purpose registers from the stack
    ret


