#	Author : Mohammed Lamine Abdellaoui
# 	Date : 30/09/2018
#	Description : Two different operation to be implemented using 2 instrsuctions only
#		     a = b / 32
#		     c = d % 8


.data 
output : .asciiz "a = "
newLine : .asciiz "\n"
output_1 : .asciiz "c = "

.text
# a = b / 32 
 li $t1,96
 srl $t0, $t1, 5 #shifting b to the right by 5 is the same as dividing by 2^5=32
 
li $v0, 4 # print out the string "a = "
la $a0,output
syscall  

li $v0, 1
add $a0, $t0,$zero
syscall 

li $v0, 4 # print a new line to differentiate between first and second opeartion
la $a0,newLine
syscall  

# c = d % 8 
li $t3 , 9 #loading a value 9 to register $t3
and $t2, $t3, 7 # anding a number n with k-1 the numerator of the the modulus gives us the mod 


li $v0, 4
la $a0,output_1
syscall  

li $v0, 1
add $a0, $t2,$zero
syscall 