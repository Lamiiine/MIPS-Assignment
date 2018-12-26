%define PIT_DATA0       0x40
%define PIT_COMMAND     0x43

pit_counter dq    0x0               ; A variable for counting the PIT ticks

handle_pit:
      pushaq
            mov rdi,[pit_counter]         ; Print value in Hexa
            push qword [start_location]
            mov qword [start_location],0
            call video_print_hexa          ;call to be printed
            pop qword [start_location]
            inc qword [pit_counter]       ; Increment pit_counter
      popaq
      ret



configure_pit:
    pushaq
        mov rdi,32 ; PIT is connected to IRQ0 -> Interrupt 32
 	mov rsi, handle_pit ; The handle_pit is the subroutine that will be invoked when PIT fires
 	call register_idt_handler ; We register handle_pit to be invoked through IRQ32
 	mov al,00110110b ; Set PIT Command Register 00 -> Channel 0, 11 -> Write lo,hi bytes, 011 -> Mode 3, 0-> Bin
 	out PIT_COMMAND,al ; Write command port
 	xor rdx,rdx ; zero rdx 
 	mov rcx,1000
 	mov rax,1193180 ; 1.193180 MHz
 	div rcx ; Calculate divider -> 11931280/1000
 	out PIT_DATA0,al ; Write low byte to channel 0  port
 	out PIT_DATA0,ah ; Write high byte to channel 0  port 
popaq
    ret
