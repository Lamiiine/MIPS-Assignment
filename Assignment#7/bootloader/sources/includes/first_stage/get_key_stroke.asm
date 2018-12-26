;************************************** get_key_stroke.asm **************************************      
        get_key_stroke: ; A routine to print a confirmation message and wait for key press to jump to second boot stage
            pusha                               ; Save all general purpose registers on the stack


                 mov ah,0x0 ; Int 0x16/fun0 wait for a keyboard input
 		 int 0x16 ; Issue interrupt 0x16


            popa                                ; Restore all general purpose registers from the stack
            ret 
