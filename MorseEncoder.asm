.data 
inputMessage: .asciz "Enter a message (A-Z, a-z, 0-9): "
newLine: .asciz "\n"
originalLabel: .asciz "Original: " 
morseLabel: .asciz "Morse: " 

morseTable: 
	.string ".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --.. ----- .---- ..--- ...-- ....- ..... -.... --... ---.. ----."
	#A->Z and 0->9 Morse equivalent 

input: .space 100

.text
.global main 

main: 
	#Prompt the user for input
	li a7, 4
	la a0, inputMessage
	ecall 
	
	#Read the inputted string 
	li a7, 8
	la a0, input 
	li a1, 100
	ecall
	
	# to print "Original: "
	li a7, 4
	la a0, originalLabel
	ecall
	
	# Printing the user input
	li a7, 4
	la a0, input
	ecall
	
	# Print /n
	li a7, 4
	la a0, newLine
	ecall
	
	# Print "Morse: "
	li a7, 4
	la a0, morseLabel
	ecall

	#To start reading the input 
	la t0, input

readCharacters: 
	#Get the character
	lb t1, 0(t0)
	#Check if we reached the end of the string 
	beq t1, x0, terminate 
	
	#Check if we have a space or we have a new line 
	#ASCII code of space is 32 (space = ' ')
	li t2, 32
	beq t1, t2, printSpace 
	li t2, 10
	beq t1, t2, skip
	
	#Convert lowercase to uppercase 
	li t2, 97	# ASCII 'a'
	li t3, 122      # ASCII 'z'
	blt t1, t2, digitIndex
	bgt t1, t3, digitIndex
	addi t1, t1, -32	# Convert to uppercase

digitIndex: #0->9 in the table have indices 26-35
	#ASCII of '0' is 48
	#ASCII of '9' is 57
	li t2, 48
	li t3, 57
	blt t1, t2, characterIndex
	bgt t1, t3, characterIndex 
	sub t1, t1, t2
	addi t1, t1, 26 #Morse index for 0–9 starts at 26
	j encode 
	
characterIndex: #A->Z in the table have indices 0->25
	#ASCII of 'A' is 65 
	#ASCII of 'Z' is 90 
	li t2, 65
	li t3, 90
	blt t1, t2, skip 
	bgt t1, t3, skip
	sub t1, t1, t2 



encode: #This is to get the Morse code from the table 
	la t2, morseTable 
	li t3, 0	# word counter
	li t4, 0 	# offset counter
	
scanTable:
	beq t3, t1, printMorseLetter
	lb t5, 0(t2)
	beq t5, x0, skip
	addi t2, t2, 1
	li t6, 32           # space marks end of a Morse letter
	beq t5, t6, nextWord
	j scanTable

nextWord:
	addi t3, t3, 1
	j scanTable

# Here we print Morse code character by character 
printMorseLetter:
	lb t5, 0(t2)
	li t6, 32
	beq t5, t6, printSpace
	beq t5, x0, printSpace
	li a7, 11
	mv a0, t5
	ecall
	addi t2, t2, 1
	j printMorseLetter


printSpace: #spaces for the output 
	li a7, 11
	li a0, 32
	ecall
	
skip: 
	addi t0, t0, 1
	j readCharacters 

terminate: #end of the program  
	li a7, 4
	la a0, newLine 
	ecall

	li a7, 10
	ecall
	
	