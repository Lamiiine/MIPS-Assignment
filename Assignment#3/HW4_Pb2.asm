#		Author : Mohammed Lamine Abdellaoui
#		Date : 21/10/2018
#		Description : A recursive function that takes start, end and a target value to loook up for
#			     in a sorted array inserted into a binary search tree. The output should include the index of the target
#			    value if found, else it would be -1
#
#
.macro Out 
 li $v0, 10
 syscall
.end_macro
.data

invalid: .asciiz "does not exit within the range  -1"
 start: .word 2, 3, 8, 10, 16
  end: # points to the last address of the sorted array

 .text
 main:

 li $a0, 21 # loading the target value in $a0(Note this can be changed by the user)
 la $a1, start # loading the address of start array entry
 la $a2, end  # loading the address of the end array 
 
 jal bst_recu # call for the BST function 
 #check the value returned in $v0 (if it exists in the tree we output its index, else we output -1)
 beqz $v0,empty
 la $a1, start # address of start array entry
 move $a0, $v0
 sub $a0 , $a0 , $a1 # subtract to get the key address of the target element
 srl $a0,$a0,2 #divide by 4 to get the key address of the target value (an approach to be )
 li $v0,1
 syscall
 exit:
 Out
 #-----------------------------BST Function -------------------------#
bst_recu : 
 subu $sp, $sp, 4 # allocate 4 bytes on stack
 sw $ra, 4($sp) # store the return address in the stack

 subu $t0, $a2, $a1 # load the size of the array in $t0 
 bnez $t0, search # branch out to search again if the the array's size is not 0

 move $v0, $a1 # address of start entry of the array
 lw $t0, ($v0) # load the element pointed to 
 beq $a0, $t0, again # branch out to equal to target value? yes => again
 li $v0, 0 # load 0 to $v0
 j again # done, again
 search:
 sra $t0, $t0, 3 # get the offset value of the middle value in the BST
 sll $t0, $t0, 2 # shift left and the store the result in $t0
 addu $v0, $a1, $t0 # get the address of the middle value in the BSTree
 lw $t0, ($v0) # loading the middle value into $t0
 beq $a0, $t0, again # branch out if the target value if equal to the middle value
 blt $a0, $t0, l_leaf # branch out if the target is less than the value in $t0
 
 # Search in the right leaf
 r_leaf:
 addu $a1, $v0, 4 # search continues right of m
 jal bst_recu # recursive call
 j again # done, again
 # Search in the left leaf
 l_leaf:
 move $a2, $v0 # search in the left leaf
 jal bst_recu # cal best_recu (recursive)
 again:
 lw $ra, 4($sp) # load the return address 
 addu $sp, $sp, 4 # return the stack to its normal size


 jr $ra # return the last result after getting out of the "again" 
 empty:
 la $a0,invalid
 li $v0,4
 syscall
# Return to exit in the main (not optimal, to be 	) 
 j exit