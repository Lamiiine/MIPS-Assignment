#	Author : Mohammed Lamine Abdellaoui
# 	Date : 10/10/2018
#	Description : Converting a decimal integer to its equivalent integer

.data
	space : .space 32
.text

main:
li $v0 , 5
syscall 
move $a0 , $v0

jal convertToDecimal


li $v0 , 10
syscall 

convertToDecimal:
li $v0 , 1
syscall
jr $ra

