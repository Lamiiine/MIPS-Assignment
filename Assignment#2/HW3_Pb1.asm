#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Swapping the location of two addresses
.data
	size : .word 3
	A : .byte 1 , 2 , 3 
	B : .byte 7 , 8 , 9  
	space : .asciiz "   "
.text 
main : 
la $a0 , A #load the first array into $a0
la $a1 , B  # loading the second array into $a1
lw $a2 , size #loading the size of the array into $a2

jal swap 
jal output

li $v0 , 10
syscall

output : # output A and B 
li $t0, 0 
move $t5, $a0
loop:
      beq $t0 ,$a2 , exit #loop over the size of the array to output the swapped elements inside each one 
 	
 	add $t1 , $t5 , $t0
 	add $t2 , $a1 , $t0
 	
 	lb $t3 , 0($t1)
 	lb $t4 , 0($t2)
 	
	li $v0 ,1
	move $a0, $t3
	syscall
	
	li $v0 , 4
	la $a0, space
	syscall
	
	
	li $v0 , 1
	move $a0, $t4
	syscall 
	
	addi $t0 ,$t0, 1
	
j loop
	
	
	exit : 



jr $ra

swap : 	#a0 contains first address, a1 contains second address, size in a2

li $t0, 0
loop_1:
      beq $t0 ,$a2 , exit_1
 	
 	add $t1 , $a0 , $t0 # increment the pointer of the first array to point to the next element in array A each loop
 	add $t2 , $a1 , $t0 #  increment the pointer of the second array to point to the next element in array B each loop
 	
 	#loading the byte stored(ith element in the array)
 	lb $t3 , 0($t1) 
 	lb $t4 , 0($t2)
 	
 	# Swap the byte's locations without any operation
	sb $t3 , 0($t2)
	sb $t4 , 0($t1)
	addi $t0 ,$t0, 1
	
     j loop_1 # loop until the size of the array
	
	
	exit_1 : 
	
jr $ra
