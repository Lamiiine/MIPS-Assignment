#	Author : Mohammed Lamine Abdellaoui
# 	Date : 30/09/2018
#	Description : Reading the size of array from the user, and checking the values stored 
#		      by the user if they are Odd or Even and sum all Odd numbers, and finally
#		      Print them out 

.data
	arraySize: .asciiz " Please enter the size of the array :"
	sum : .asciiz "	The sum of odd numbers entered is  "
.text

# Reading the size of the array from the user  
li $v0,4 	# System call code for Print String
la $a0,arraySize 	# Load address of arraySize into $a0
syscall	 # Execute the Print String system call

li $v0,5 # System call code for Read Integer
syscall # Execute the read Integer system call
add $t0,$v0,$zero	 # Store the first integer value into $t0
sll $a0 ,$v0 ,2    # sll performs $a0 = $v0 x 2^2
li $v0 ,9    #9 is the system code for service(sbrk) whoes work is        
syscall     #to allocate dynamic memory

li $t1 , 0
move $t2 ,$v0
li $t4, 0
loop:
    beq $t1, $t0, end #branch out of the loop if value stored in $t1 == $t0

    # read intgers and store them in the array
    li $v0, 5
    syscall
    sw $v0 ,0($t2) # Store word in 
    andi $t3,$v0,1 # Extract the first bit of $v0 and store it in $t0
   beqz $t3,even_num # Branch out if the bit is equal to 0 which means the number is even
   add $t4, $v0,$t4  #add the value in $v0 to register $t4 , that is going to sum the even numbers entered by the user
   
   even_num:
     addi $t1, $t1, 1 # Increment the counter of the loop by adding 1 to its actual value
     addi $t2 ,$t2 ,4 #	since integers are stored in 4 bytes     
   j loop

end:
li $v0,4 	# System call code for Print String
la $a0,sum 	# Load address of sum into $a0
syscall	 # Execute the Print String system call

li $v0 , 1
add $a0,$t4, $zero
syscall # syscall to print out the sum of the odd numbers entered by the user  

li $v0,10 # System call code for terminating current program
syscall # Execute system call to return control to operating system
