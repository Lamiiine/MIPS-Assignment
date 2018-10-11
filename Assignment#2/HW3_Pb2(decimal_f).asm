#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Checking if an input string in a decimal number of not and evaluating its decimal value
.data
decNum: .asciiz "0123456789"
str: .space 30
.text
#reading a string from the user
li $v0,8 
la $a0,str
li $a1, 30 # allocating a space of 30 (can be changed)
la $s0,decNum
la $t9,str#shir
add $t9,$t9,3	#input's string length( can be changed without further complication)
syscall

li $t5 ,100
li $v0,0
jal decimal_f 
#################### Test the Evaluation ############################
#li $v0,1 
#addi $a0,$t4,0
#syscall
#################### End of Test the Evaluation ############################

li $v0 , 1
addi $a0,$v1,0
syscall # Execute the print string system call
li $v0,10 
syscall
decimal_f: 
li $t4, 0
outerLoop: # A loop label to iterate over all $a2 bytes
lb $t1,($a0) # Load byte pointed to by $a0 to $t1 
	InnerLoop:
	lb $t2,($s0) #load byte of address $s0 into $t2
	beq $t1,$t2,out_3 #  branch out_2 if equal to the loaded value in $t2 
	beq $t2,57,Invalid_input # branch out totally when you reach the character f (ASCII value of 9 is 57)
	add $s0,$s0,1 # incrementing the pointer to the string
	j InnerLoop
out_3:	
la $s0,decNum  #loading the decimal string into $s0
# Transfor Hexa decimal to decimal using multiplication and division algorithm
sub $t1, $t1 , 48
mul $t3,$t1,$t5 
add $t4,$t3,$t4
div $t5,$t5,10
add $a0,$a0,1 # Moving the pointer to next bit in the string 

beq $a0,$t9,validInput  # branch out if the input bit is invalid
j outerLoop
validInput:
#storing 0 in $v1 if the function works correctly
li $v1,0

j out
Invalid_input:
#Storing 1 in $v1 is the function got an invalid input
li $v1,1
out:
jr $ra
