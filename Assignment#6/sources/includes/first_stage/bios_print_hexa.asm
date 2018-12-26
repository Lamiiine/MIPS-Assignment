      bios_print_hexa:  ; A routine to print a 16-bit value stored in di in hexa decimal (4 hexa digits)
            pusha                                     ; Save all general purpose registers on the stack
            mov cx,0x8                                ; Set loop counter for 4 iterations, one for eacg digit
            mov ebx,edi                                ; we move DI(value to be printed)  into bx because we don't want to 								;change change ot
            .loop:                                    ; Loop over the four digits
                  mov esi,ebx                           ; Move  bx into si
                  and esi,0xF0000000                     ; get the first left most hexa digits which represents 4bits
                  shr esi,0x1c                          ; Shift right the  SI 12 bits  
                  mov al,[hexa_digits+esi]             ; get the right most hexa digit from the array we have           
                  mov ah, 0x0E                        
                  int 0x10                           ; INT 0x10 to print character function 
                  shl ebx,0x4                         ; Shift left bx 4 bits to have the next digit in its place 
                  dec cx                              ; decrement loop counter
                  cmp cx,0x0                          ; compare the loop counter with 0.
                  jg .loop                            ; Loop again we did not yet finish the 4 digits
            popa                                      ; get general purpose registers from the stack
            ret


      bios_print_hexa_with_prefix:  ; print a hexadecimal number in 16 bits
            pusha                                     ; store general purpose registers on the stack
            mov si,hexa_prefix                        ; output the prefix 0*x
            call bios_print                                 
            call bios_print_hexa
            popa                                      ; Restore all general purpose registers from the stack
            ret
