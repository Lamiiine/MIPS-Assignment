;************************************** detect_boot_disk.asm **************************************      
      detect_boot_disk: ; A subroutine to detect the the storage device number of the device we have booted from
                        ; After the execution the memory variable [boot_drive] should contain the device number
                        ; Upon booting the bios stores the boot device number into DL
            pusha                                     ; Save all general purpose registers on the stack


                  mov si,fault_msg ; Store in si the fault_msg
 	xor ax,ax ; store zero in ax. AH=0 for Reset Disk Drive
 	int 13h ; Issue BIOS interrupt 0x13
 	jc .exit_with_error ; If carry flag is set then an error occurred. Jump to exit_with_error and already in si
 	mov si,booted_from_msg
 	call bios_print
 	mov [boot_drive], dl ; Else, get the boot drive number from the dl register
 	cmp dl,0 ; Check if dl is zero. This means it is the floppy.
 	je .floppy ; If the disk number is 0x0 then jump to .floppy
 	call load_boot_drive_params ; If not,we call load_boot_drive_params to override [spt] and [hpc]
 	mov si,drive_boot_msg ; Store the address of the sting drive_boot_msg into si
 	jmp .finish ; Skip over the .floppy code
 	.floppy:
 	mov si,floppy_boot_msg ; Store the address of the sting floppy_boot_msg into si
 	jmp .finish
 	.exit_with_error:
 	jmp hang
 	.finish:
 call bios_print ; Call bios_print to print whatever message is store in

                  
            popa                                ; Restore all general purpose registers from the stack
            ret
