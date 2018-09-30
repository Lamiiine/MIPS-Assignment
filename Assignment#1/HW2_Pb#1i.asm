#	Author : Mohammed Lamine Abdellaoui
# 	Date : 30/09/2018
#	Description : Perform the following operation : a = b-c + A[B[i]] 
#		      
#		       


.data

output: .asciiz "a = "
A: .word 1,2,2,3,8,5
B: .word 1,1,1,1,0,1 

.text

add $t0,$zero, 1 # load value into a: a=1
add $t1,$zero,2 # load value into a: b=2
add $t2,$zero,2 # load value into a: c=2
add $t3,$zero,4 # load value into a: d=4
add $t4,$zero,3 # load value into a: i=3
 
la $s0,A #loading first element's address into base address $s0 
la $s1,B ##loading first element's address into base address $s1

sub $t0, $t1, $t2 # a =b-c
sll $t4, $t4, 2 #shift the location twice(same as 2^2) to reacg B[i]

#lw $a0, 4($s1)
add $a0, $s1, $t4 # get the address of B[i] and store it in a0
lw $a0, ($a0) # load the value stored in address (a0) into a0

sll $a0,$a0,2 #shifting twice again for the array A[B[i]]
add $a0, $a0, $s0 # get the value address of A[B[i]] 
lw $a0,($a0) #load the value stored in a0 and load into register $a0
add $t0 ,$t0, $a0  # Perform the addition resulted from the (b-c)+ A[B[i]] 

li $v0, 4 #syscall to output the string " a =" 
la $a0 ,output
syscall 


li $v0, 1 # syscall to print out the integer which is the output of the operation
add $a0, $t0,0
syscall

li $v0, 10
syscall 