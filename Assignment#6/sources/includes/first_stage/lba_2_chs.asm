 ;************************************** lba_2_chs.asm **************************************
 lba_2_chs:  ; Convert the value store in [lba_sector] to its equivelant CHS values and store them in [Cylinder],[Head], and [Sector]
                  ; [Sector] = Remainder of [lba_sector]/[spt] +1
                  ; [Cylinder] = Quotient of (([lba_sector]/[spt]) / [hpc])
                  ; [Head] = Remainder of (([lba_sector]/[spt]) / [hpc])
            pusha                               ; Save all general purpose registers on the stack

                  xor dx,dx ; Zero out dx
 mov ax, [lba_sector] ; Move [lba_sector] to ax
 div word [spt] ; DX:AX/word[spt] -> DX = remainder, AX = quotient
 inc dx ; Add 1 to the remainder to get the CHS sector
 mov [Sector], dx ; Store in memory
 xor dx,dx ; Zero out dx, and ax already have the quotient
 div word [hpc] ; DX:AX/word [hpc]
 mov [Cylinder], ax ; Store the quotient value AX to [Cylinder]
 mov [Head], dl ; Store the remainder value DL into [Head]

            popa                                ; Restore all general purpose registers from the stack
            ret
