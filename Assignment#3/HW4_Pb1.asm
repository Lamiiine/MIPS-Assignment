#		Author : Mohammed Lamine Abdellaoui
#		Date : 21/10/2018
#		Description : Implementing a bubble sort that receives an array of words (size) and its address and using the Bubble 
#			     sort algorithm we sort the array in an increasing order

.macro Out
li $v0, 10
syscall
.end_macro

.data
.align 4 # aligning to 4 becasue of words
ArraySize: .asciiz "Enter the size of the array : "
#promptIntList: .asciiz   "Waiting for a number: "
new_line:          .asciiz   "\n"
str:   .asciiz   "Your sorted array : "
space:         .asciiz   " "

.text
main:
#Asking the user to input the size of the array
    li $v0, 4             
    la $a0, ArraySize  
    syscall               
    
    li $t7,0		# setting $t7 as a counter to limit the user input loop
    li $v0,5		# getting the size of the array in $v0 
    syscall
    #moving the size of the array stored in $v0 into $s2
    move $s2,$v0	
    li $v0, 4              
    li $s0,0               
loop:
    #Read an integer from the user to be put in the stack 
    li $v0, 5              
    syscall
    # increment the counter that ends the loop over the array's size
    addi $t7,$t7,1               
    sub $sp,$sp,4        # reserve a space in the stack
    sw $v0,0($sp)         # store user input onto the stack
    addi $s0, $s0, 4       # store stack counter in s0
    beq $s2,$t7,generalLoop # branch out to general loop if the array is filled
    j loop            # jump back to loop
generalLoop:
     
    move $t0,$sp           # outerloop counter
    add $t4,$sp,$s0        # nested loop conditional stop
    sub $t4,$t4,4 # subtracting 4 for a word
InnerLoop:
    move $t1,$sp         # move the inner loop counter into the stack 
    sub $t6,$t0,$sp        # conditional stopping argument
    sub $t6,$t4,$t6
nestedLoop:
    lw $t2,0($t1)         # get first int
    lw $t3,4($t1)          # get second int
    slt $t5,$t2,$t3        # setting $t5 to 1 if arr[0] < arr[1] 
    bne $t5,$zero,Flag # branch out to flag if $t5 reaches 0
    #Swaping method without using a third, temporary variable
    add $t2,$t2 ,$t3           # add $t2 to $t3 and put the answer to $t2
    sub $t2,$t2,$t3           # subtract what's in $t2 from $t3
    sub $t2,$t2, $t3           # subtracting what's in $t3 from $t2
    sw $t2,0($t1)          # store the word swaped back into the stack 
    sw $t3,4($t1)         # store the second swaped element into $t3
    Flag:
     addi $t1,$t1,4         # increment to next int
     bne $t1,$t6,nestedLoop # branch out to nestedLoop if not equal to $t6
    addi $t0,$t0,4          # increment outer loop counter
    bne $t0,$t4,InnerLoop # branch out to InnerLoop if $t0 not equal to $t4
    # print a string referenced by str : "Your sorted array"
    li $v0,4                
    la $a0,str      
    syscall                 
    jal test_0      # print the sorted array
    j end                  # jump to end

test_0:
     move $t5,$sp         # print counter
     add $t2,$s0,$t5        # end condition
 print_sortedA:
   #Print an integer	
    li $v0, 1              
    lw $a0,0($t5)          
    syscall   
    
    #space between the element of thr sorted array
    li $v0,4                
    la $a0,space            
    syscall
    
    addi $t5,$t5,4           # incrementing to next word in the array
    bne $t5,$t2,print_sortedA  # branch out to print the sorted array if not equal to the counter $t2
    #print new line
    li $v0,4                
    la $a0,new_line              
    syscall                  
    jr $ra                   # return address to main

end:
Out    
