#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Converting a decimal integer into its equivalent Octal number

.data 
  space : .space 32
  enter : .ascii "\nEnter a number : "
 prefix : .ascii "\n0O-"
.text 
main :
#asking the user to enter a number
li $a0 , 32
li $v0 , 4
la $a0 , enter
syscall 
li $v0 , 5
syscall 
move $a0, $v0

jal octal_f

  

li $v0 , 10
syscall 

octal_f:
move $t2,$a0
 li $t0, 10               # backwards counting --     
 la $t3, space      # loading the sapce reserved into register $t3 
 rol $t2, $t2, 2     # rotate 4 bits to the left     
 and $t5, $t2, 0x3           # mask with 111 (method read about online)            
 addi $t5, $t5, 48   # add 48 to result to get the appropriate character
 sb $t5, 0($t3)      # storing the byte loaded first into $t5    
 addi $t3, $t3, 1        # increment the address by 1     
 
 loop:     
 beqz $t0, out      # branch out if the counter is equal to zero     
 rol $t2, $t2, 3     # rotate 4 bits to the left (read about this online)     
 and $t5, $t2, 0x7           # mask with 111(to get the right most bit)             
 addi $t5, $t5, 48   # add 48 to result to get the appropriate character 
 sb $t5, 0($t3)      # storeing the ith byte  
 addi $t3, $t3, 1        # increment address counter     
 addi $t0, $t0, -1       # decrementing the loop counter by 1 
 j loop 
 
 out:     

 li $v0, 4  
 la $a0, space     
 syscall 
 li $v0, 4   
 la $a0, prefix    
 syscall  
  
 jr $ra
