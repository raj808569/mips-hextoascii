#to convert 32 bit hexadecimal number into ascii string

.data

user_prompt:
		.asciiz "\n please enter the 32 bit hexadecimal number without the 0x and enter the alphabets A,B,C,D,E,F in uppercase\n" 		 # ask the user for 

the 32 bit hexadecimal input

get_input:
		.word 4			 				#creating space for our 32bit input

.text

main:

	la $a0,user_prompt			 #load address user_prompt from memory and store it into arguement register 0
	li $v0,4  				 #loads the value 4 into register $v0 which is the op code for print string
	syscall				#reads register $v0 for op code, sees 4 and prints the string located in $a0

	la $a0,get_input                      		#sets $a0 to point to the space allocated for writing a word
	la $a1,get_input                      		 #gets the length of the space in $a1 so we can't go over the memory limit
	li $v0,8    				#load op code for getting a string from the user into register $v0
	syscall    				#reads register $v0 for op code, sees 8 and asks user to input a string, places string in reference to $a0

	la $t0,get_input			#to calculate the ascii of input string
	li $t4,9
	li $t5,10
	jal loop
	
	li $v0,10 				#syscall to terminate the program
	syscall    				#reads $v0 and exits program

loop:
	lb $t1, 0($t0)			 # load the next character into t1
	beqz $t1, exit			# Branches to "exit" at the null character.

	addi $t2,$t1,-48			#converts first charcter of the pair to equivalent decimal		
	bgt $t2,$t4,hex			#for conversion of A,B,C,D,E,F

loop2:
	addi $t0, $t0, 1 			#increment character
	lb $t1,0($t0)			#for conversion of second character of pair 
	addi $t3,$t1,-48
	bgt $t3,$t4,hex2

loop3:
	mul $t2,$t2,$t5
	add $t2,$t2,$t3
	move $a0,$t2
	li $v0,1
	syscall
	addi $t0,$t0,1
	j loop
hex:
	
	addi $t2,$t2,-7
	j loop2

hex2:
	addi $t3,$t3,-7
	j loop3


exit:
	jr $ra


	
