%define PAGE_PRESENT_WRITE 0x3  ;011b
%define PML4_ADDRESS 0x100000
%define PDP_ADDRESS  0x101000
%define PD_ADDRESS   0x102000
%define PTE_ADDRESS  0x103000
%define PTR_MEM_REGIONS_TABLE  0x21018
%define PTR_MEM_REGIONS_COUNT  0x21000


paging_build:
pushaq
pml4_ptr dq PML4_ADDRESS
pdp_ptr dq PDP_ADDRESS
pd_ptr dq PD_ADDRESS
pte_ptr dq PTE_ADDRESS
temp_ptr dq PTE_ADDRESS



physiAdd dq 0x0
regionCounter dq 0x0
max_size dq 0x0

pml4_counter dq 0x0
pdp_counter dq 0x0
pd_counter dq 0x0
pte_counter dq 0x0

paging_0:
    pushaq
        call getSize
        mov rax, qword[pml4_ptr]
        mov rbx, qword[pdp_ptr]
        or rbx, PAGE_PRESENT_WRITE
        mov [rax], rbx
        add qword[pml4_counter], 0x1    
        
        mov rax, qword[pdp_ptr]
        mov rbx, qword[pd_ptr]
        or rbx, PAGE_PRESENT_WRITE
        mov [rax], rbx
        add qword[pdp_counter], 0x1

        mov rax, qword[pd_ptr]
        mov rbx, qword[pte_ptr]
        or rbx, PAGE_PRESENT_WRITE
        mov [rax], rbx
        add qword[pd_counter], 0x1
        jmp .pte_loop
        
        .pml4_loop:
            add qword[temp_ptr], 0x1000
            mov qword[pdp_counter], 0x0
            mov rax, qword[temp_ptr]
            mov qword[pdp_ptr], rax
            or rax, PAGE_PRESENT_WRITE
            add qword[pml4_ptr], 0x8
            mov rbx, qword[pml4_ptr]
            mov[rbx], rax
            add qword[pml4_counter], 0x1
            
            .pdp_loop:
                add qword[temp_ptr], 0x1000
                mov qword[pd_counter], 0x0
                mov rax, qword[temp_ptr]
                mov qword[pd_ptr], rax
                or rax, PAGE_PRESENT_WRITE
                add qword[pdp_ptr], 0x8
                mov rbx, qword[pdp_ptr]
                mov[rbx], rax
                add qword[pdp_counter], 0x1
                
                .pd_loop: 
                    call unlock_memory
                    add qword[temp_ptr], 0x1000
                    mov qword[pte_counter], 0x0
                    mov rax, qword[temp_ptr]
                    mov qword[pte_ptr], rax
                    or rax, PAGE_PRESENT_WRITE
                    add qword[pd_ptr], 0x8
                    mov rbx, qword[pd_ptr]
                    mov[rbx], rax
                    add qword[pd_counter], 0x1
                    .pte_loop:
                            cmp qword[physiAdd], 0xFFFFF
                            jl .ignore
                            call .check_address_type
                            .ignore:
                            xor rax, rax
                            xor rbx, rbx
                            mov rax, qword[pte_ptr]
                            mov rbx, qword[physiAdd]
                            or rbx, PAGE_PRESENT_WRITE
                            mov [rax], rbx
                            add qword[physiAdd], 0x1000
                            add qword[pte_ptr], 0x8
                            add qword[pte_counter], 0x1
                            cmp qword[pte_counter], 0x200
                            jl .pte_loop
                            
                            cmp qword[pml4_counter], 0x4
                            je finish_mapping

                            cmp qword[pdp_counter], 0x200
                            je .pml4_loop
                            
                            cmp qword[pd_counter], 0x200
                            je .pdp_loop
                                            
                            jmp .pd_loop

; Prompt a message to the user that Mapping the memory is done 
finish_mapping: 
mov rsi , mappingDone
call video_print
    popaq
    ret

unlock_memory:
    pushaq
        xor rdx, rdx
        mov rdx, qword[pml4_ptr]
        mov cr3, rdx    
    popaq
    ret

; Not able to do it, to be checked with Ibrahim
.check_address_type:
pushaq



.regions:
popaq
ret
; getting the maximum size
getSize:
pushaq
mov rax, qword[PTR_MEM_REGIONS_COUNT]
mov qword[regionCounter], rax
sub rax, 0x1
mov rbx, 24
mul rbx
add rax, PTR_MEM_REGIONS_TABLE

mov r8, qword[rax]
add rax, 0x8
add r8, qword[rax]

mov qword[max_size], r8
popaq
ret
