# Assignment 1
This assignment is based on Assembly Language Programming using NASM. 

-------------------------------------------------------------------------------------

SET-A: A1A_226201003    [Q13]

commands to execute:-

	nasm -f elf64 A1A_226201003.asm -o A1A_226201003.o
	gcc -no-pie A1A_226201003.o -o A1A_226201003
	./A1A_226201003


=> enter the (+ve) interger one by one on the console
=> output gives the gcd of entered number on console


-------------------------------------------------------------------------------------

SET-B: A1B_226201003    [Q3]

command to execute:-

	nasm -f elf64 A1B_226201003.asm -o A1B_226201003.o
	gcc -no-pie A1B_226201003.o -o A1B_226201003
	./A1B_226201003


=> 'test.txt' contains the text that is supposed to processed
=> 'test.txt' being in the same directory as the '.asm' file
=> 'test.txt' file should be saved-as Default encode = UTF-8
	(check for this if required after processing)
 
=> By executing the code the non-printable characters are replaced and
   output is printed on the console and in the same file

=> 'End-Of-Line' and 'Enter', both are considered to be non-printable
=> Extended ascii table is considered to be non-printable
=> i.e considered printable character to be >33 && <126 (decimal)
