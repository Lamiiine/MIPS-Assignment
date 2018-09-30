#	Author : Mohammed Lamine Abdellaoui
# 	Date : 30/09/2018
#	Description : Printing out Floyd's Triangle using MIPS Assembly

.data 
	newLine : .asciiz "\n"

.text
li $t1, 1 #counter of outerwhile i. i=1

forLoop_1: 
beq $t1,10,outerLoopS # Branch out of the forLoop_1 if value of $t1 == 10
li $t2, 1 #loading  1 to the forLoop_2 counter
#add $t3,$t1,1 #store i+1 into t3

forLoop_2:
add $t4,$t1,1 #Storing the value of $t1 +1 in a temporary register "$t4" so not protect the value stored in $t1 and the flow of the forLoop_1 
#branching forLoop_2 if the value stored in the temporary register $t4 and compare to the forLoop_2 initital condition stored in $t2
beq $t4,$t2,innerLoopS #Label for to stop inner loop: S stands for Stop


li $v0, 1
add $a0, $t2,0
syscall 	#syscall to print out the value stored in $t2(the counter of forLoop_2)

add $t2,$t2,1 #incrementing the counter of forLoop_2 

b forLoop_2

innerLoopS: 

li $v0,4 
la $a0,newLine 
syscall #using syscall to print out a new line after the end of every step in forLoop_2


add $t1,$t1,1 #Incerement the counter of the forLoop_1 using addition


b forLoop_1

outerLoopS:
addi $v0,$0,10
syscall #syscall to terminate the program after the end of each loop
