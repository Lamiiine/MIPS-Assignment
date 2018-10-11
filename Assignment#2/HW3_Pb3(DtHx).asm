#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Converting a decimal integer into a hexadecimal number
.data
     str_1: .asciiz "Enter a number : "
     str_2: .asciiz "\n Hexadecimal value: "
     str_3: .ascii "-0x" 
     result: .space 8     
 .text  

  main:
  # asking the user to input a decimal number
 la $a0, str_1
 li $v0, 4     
 syscall    
  # reading an input from the user
 li $v0, 5   
 syscall    
 move $t2, $v0    
 
 la $a0, str_2     
 li $v0, 4     
 syscall     
 
  li $t0, 8           
  la $t3, result
  jal Hexa_f
  
  la $a0, result #loading the result address into $a0    
  li $v0, 4     
  syscall 
  la $a0 , str_3 # string for the prefix related to hexa -0x  
  li $v0 , 4
  syscall 
  
    
  li $v0, 10    
  syscall

     
  Hexa_f:
  
     Loop:  
      beqz $t0, out      # branch out if counter $t0 is equal to zero   
      rol $t2, $t2, 4     # rotate 4 bits to the left   
      and $t4, $t2, 0xf          # mask with 1111  
      ble $t4, 9, addition     # branch out to sum if less than or equal to nine    
      addi $t4, $t4, 55           # add 55 to $t4 if the entered the loop   
      j end   
       addition:        
        addi $t4, $t4, 48   # add 48 to result    
        end:
        sb $t4, 0($t3)      # store hex digit into result   
        addi $t3, $t3, 1        # incrementing the address counter by 1   
        addi $t0, $t0, -1       # decrementing the loop counter by 1
        j Loop 
         
         out:       
    jr $ra