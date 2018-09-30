#	Author : Mohammed Lamine Abdellaoui
# 	Date : 30/09/2018
#	Description : Transform this C code into MIPS Assembly 
#	i = 0 ; b = 0 ; while(B[i]) b+=A[i++]	      

.data
	output: .asciiz "b = " 
	A: .word 3,2,5,4,5,3,1
	B: .word 2,2,3,4,0,6,1
	
.text 
la $s0,A
la $s1,B

li $t4, 0 #loading 0 to register $t4 which represents i(i=0)
li $t1 , 0 # loading 0 to register $t1 which represents b (b=0)

whileLoop :

	add $t5, $t4,0 # adding the value of i to the new temporary register $t5
	sll $t5, $t5, 2 #shift left twice to get the required number(2^2)
	add $a0, $s1, $t5 # calculate location of a0=B[i]
	lw $a0, ($a0) # Store the value associated with address a0 into register a0

	beqz $a0, end #branch out of the loop if $a0==0

	add $a0, $t5, $s0 # add the base address of array A to the value's address and store into $a0
	lw $a0,($a0)

	add $t1,$t1,$a0 #Perform the addition and store in $t1 which represents b
	add $t4,$t4,1 # Increment the counter by adding 1 to it 
	j whileLoop
	end:
	
li $v0, 4 # syscall intructiong to print the string defined in data segment
la $a0 , output
syscall 

li $v0, 1
add $a0, $t1,0
syscall

