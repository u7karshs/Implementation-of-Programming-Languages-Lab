# Assignment 2

This assignment tests your ability to understand the instructions used in Assembly Languages and implement them using C.

----------------------------------------------------------------------------------

Command to run (LINUX): 

	g++ -g A2_226201003.cpp
	./a.out

----------------------------------------------------------------------------------

Assumptions / Changes considered:
1. File named "input.txt" with the input assembly code in the same directory as the assembler.cpp file.
		
	1.1. Changes in i.e "input.txt" is space-padded appropriately

2. Label, Opcode and Operand each have a field size of exactly 8 characters (padding included) (All UPPERCASE)

	2.1. Space-Padded string are as and when required
	
 	2.2. Don't use tabs for padding

3. Three files "intermediate.txt", "listing.txt" and "output.txt" will be generated at the end of the execution. 
   
	3.1. intermediate.txt	: OUTPUT after 1st pass
	
	3.2. listing.txt		: OUTPUT after 2nd pass
	
	3.3. output.txt			: OUTPUT OBJECT file

4. Comments must have "." symbol in the Label field.
	This is reused in 2nd pass

5. SIC (Simplified Instruction Computer) instruction set Mnemonic/Opcode are considered.

6. Considered max character size of Label to be 6.

7. There are nospaces before and after ',' while using indirect addressing

8. The hexadecimal constants of type 'X' are assumed to be of even number of digits.

9. Error will be printed on the terminal if any.
