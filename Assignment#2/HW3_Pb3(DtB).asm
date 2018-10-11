#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Converting a decimal integer into a binary number
.data
 	str1:	.asciiz	"Enter an integer : "
 	prefix: .ascii "-0b"

.text
main : 
li	$v0, 4 # take the integer from the user and store it
la	$a0, str1
syscall
li	$v0, 5
syscall
move	$a0, $v0

jal convertToBinary

li $v0 , 10 
syscall 
convertToBinary:

add	$t0, $zero, $a0	# put our input ($a0) into $t0
li	$t1, 0	# Zero out $t1
addi $t3, $zero, 1	# load 1 as a mask
sll $t3, $t3, 31	# move the $t3 to its normal position
addi $t4, $zero, 32	# initilaizing the counter to increment backwards(--)
Iterate:
and $t1, $t0, $t3	# and the input with $t3 and put the result in $t1
beq $t1, $zero, output	# Branch out if $t1 is equal to zero

addi $t1, $zero, 1	# Put a 1 in $t1
j output


output:
li $v0, 1
move $a0, $t1
syscall



srl $t3, $t3, 1
addi $t4, $t4, -1
bne $t4, $zero, Iterate
li $v0, 4
la $a0, prefix
syscall

jr $ra
