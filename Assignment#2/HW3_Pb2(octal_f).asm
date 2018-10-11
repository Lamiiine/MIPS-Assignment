#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Checking whether a string input is in its octal form or not
.data
octalNum: .asciiz "01234567"
str: .space 30
.text
#reading a string from the user
li $v0,8 
la $a0,str
li $a1, 30 #allocating a space of 30 (can be changed)
la $s0,octalNum

la $t9,str
add $t9,$t9,4	# Setting the string's input size to be 4, can be modified without any further complication
syscall
li $t5 ,512 # 8^3 since we allowed only 4 locations( can be changed adequatly along with the number of characters)
li $v0,0
jal octal_f 
#################### Test the Evaluation ############################
#li $v0,1 
#addi $a0,$t4,0
#syscall
##################End of Test Evaluation ###########################

li $v0 , 1
addi $a0,$v1,0
syscall # Execute the print string system call


li $v0,10 
syscall


octal_f: 
li $t4, 0
outerLoop: # A loop  to iterate over all $string input bytes
lb $t1,($a0) #  Load byte pointed to by $a0 to $t1 
	
	InnerLoop:
	lb $t2,($s0) #load byte of address $s0 into $t2
	beq $t1,$t2,out_1 #branch out_1 if equal to the loaded value in $t2
	beq $t2,55,Invalid_input  # branch out totally when you reach the character 8 (ASCII value of f is 55)
	add $s0,$s0,1  # incrementing the pointer to the string
	j InnerLoop
out_1:	
la $s0,octalNum # loading the octal string into $s0
# Transfor octal to decimal using multiplication and division algorithm
sub $t1, $t1 , 48
mul $t3,$t1,$t5 #
add $t4,$t3,$t4
div $t5,$t5,8
add $a0,$a0,1 # Increment $a0 to point to the next character of the source
beq $a0,$t9,validInput  # branch out if the input bit is invalid
j outerLoop

validInput:
# storing 0 in $v1 if the function works correctly
li $v1,0
#jr $ra 
j out
Invalid_input:
#storing 1 in $v1 if the function works correctly
li $v1,1
out:
jr $ra
