#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Checking if an input string in a hexadecimal number of not and evaluating its decimal value

.data
hexNum: .asciiz "0123456789abcdef" 
str: .space 30
newLine : .ascii "\n"
.text
#reading a string from the user
li $v0,8 
la $a0,str
li $a1, 30 #allocating a space of 30 (can be changed)

la $s0,hexNum
la $t6,str#shir
add $t6,$t6,3	#input's string length
syscall
li $t3 ,256
li $v0,0
jal hexa_f 

#################### Test the Evaluation ############################
#li $v0,1 
#addi $a0,$t5,0
#syscall
 ##################End of Test Evaluation ###########################
li $v0 , 1
addi $a0,$v1,0
syscall # Execute the print string system call
li $v0,10 
syscall

hexa_f:
 
li $t5, 0 # the total sum(decimal value) initilized by 0

outerLoop: # A loop  to iterate over all $string input bytes
lb $t1,($a0) # Load byte pointed to by $a0 to $t1 
	InnerLoop:
	lb $t2,($s0) #load byte of address $s0 into $t2
	beq $t1,$t2,out_1  #  branch out_2 if equal to the loaded value in $t2 
	beq $t2,102,Invalid_input # branch out totally when you reach the character f (ASCII value of f is 102)
	add $s0,$s0,1 # incrementing the pointer to the string
	j InnerLoop 
out_1:	
la $s0,hexNum #loading the hexadecimal string into $s0
blt $t1,58,result # compare element of the string and branch out if less than 9
sub $t1, $t1 , 87 # subtracting 87 to get its equivalent in decimal (97-87 = 10)

j skip
result:
sub $t1, $t1 , 48 # subtracting 48 from $t1 (value of 0)
skip:
# Transfor Hexa decimal to decimal using multiplication and division algorithm
mul $t4,$t1,$t3 # holding the multiplication in a temporary regitser is a temp
add $t5,$t4,$t5 # we add the value to where the final result is being stored
div $t3,$t3,16 # divide the result by 16 (base)

add $a0,$a0,1 # Moving the pointer to next bit in the string 

beq $a0,$t6,valid_input  # branch out if the input bit is invalid

j outerLoop

#storing 0 in $v1 if the function works correctly
valid_input:
li $v1,0
j out
#Storing 1 in $v1 is the function got an invalid input
Invalid_input:
li $v1,1
out:

jr $ra
