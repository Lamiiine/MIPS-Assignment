#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Validating a string input if it is binary or not
.data

string : .space 20 # space alloacted for the string can be changed 
.text 
main : 
	#read a string from the user
	li $v0 , 8 
	la $a0 , string
	li $a1 , 20
	syscall 
	
	la $a0 , string   # load the string in a0 as per the problem's requirement
 	
jal binary_f #call the function binary_f to perform on the entered string 

#out the value of v1(whether 0 or 1) depending on the validity of the function's input
li $v0 ,1 
addi $a0 , $v1 , 0
syscall

# out of the program
li $v0 , 10
syscall

# function to check whether an input string is in binary form or not 
binary_f:
li $t4 , 0 # load 0 to the counter register

next_bit :
 	add $t3 , $a0 , $t4 # accessing ith element in the string using the counter register and add it to register $t3
	lb $t2 , 0($t3)  # load the byte element in register $t2
	beq $t2 , $zero , end # loop over the string until NULL element in the string 
	seq $t0 , $t2 , 48 # set $t0 equal to 0 if element in $t2 is equal to 0
	seq $t1 , $t2 , 49 # set $t1 equal to 1 if element in $t2 is equal to 1
	or $t2 , $t1 , $t0 # or to check if one of them is true and put truth value into $t2
	beq $t2 , $zero , Invalid_input # if the previous operation (or) gives false(0) it will branch out to Invalid_input directly
	sll $v0 , $v0 , 1 # shifting the value of $v0 by 1( like multiplying by 2)
	beq $t1 , $zero , skip #if the value of $t1 is 0 we skip the next step to loop again
	addi $v0 , $v0 , 1 # if the value of $t1 == 1 we add 1 to $v0
	
skip : 
addi $t4 , $t4 , 1 #incerementing the counter 
j next_bit  # jump to the next bit (next element in the string)
end : 
li $v1 , 0 # end here if the input is valid and load 0 into $v1 
j out
Invalid_input : # load value 1 into $v1 when the inupt is invalid
li $v1 , 1
out:
jr $ra
	
		
