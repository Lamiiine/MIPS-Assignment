 ;************************************** read_disk_sectors.asm **************************************
      read_disk_sectors: ; This function will read a number of 512-sectors stored in DI 
                         ; The sectors should be loaded at the address starting at [disk_read_segment:disk_read_offset]
            pusha                         ; Save all general purpose registers on the stack

                  add di,[lba_sector] ; Add lba_sector to DI as this will be the last sector to read
 		mov ax,[disk_read_segment] ; Int 0x13/fn2 expect the address where read sector(s) will be loaded to to be in es:bx
 		mov es,ax ; We cannot set es directly, so we load it from ax
 		add bx,[disk_read_offset] ; set bx to the offset
 		mov dl,[boot_drive] ; Read from boot drive
 		.read_sector_loop:
 		call lba_2_chs ; First we call lba_2_chs to convert the lbs value stored in [lba_sector] to CHS.
 		mov ah, 0x2 ; Set Interrupt function 0x2 
 		mov al,0x1 ; reading one sector at a time
 		mov cx,[Cylinder] ; Store in cx Cylinder 
 		shl cx,0xA ; Shift left 10 bits to the value of CX  
 		or cx,[Sector] ; Store Sector into CX's first 6 bits
 		mov dh,[Head] ; store in the dh the head of the sector
 		int 0x13 ; read INT
 		jc .read_disk_error ; jump to .read_disk_error If carry flag is set 
 		mov si,dot ;  print a dot if the sector is read
 		call bios_print
 		inc word [lba_sector] ; move to the next sector
 		add bx,0x200 ; move to the next memory location
 		cmp word[lba_sector],di ; compare the array with di if something is wrong
 		jl .read_sector_loop ; loop over
		jmp .finish ; no error thus we skip the next step
		.read_disk_error:
		mov si,disk_error_msg ; print error message
		 call bios_print
 		jmp hang
		.finish:

            popa                    ; Restore all general purpose registers from the stack
            ret
