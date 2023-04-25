# Assignment 4

BISON is a tool for generating parsers. 
You are expected to use BISON to design a syntax analyzer, which is the second phase of the Compiler.

--------------------------------------------------------------
Contents:

A4_42.c  : Contains main function
A4_42.l  : Contains FLEX specifications
A4_42.y  : Contains BISON specifications
A4_42.nc : nanoC file (to test FLEX token specifications)

Makefile : To "make" / "make clean" to test nanoC file (nc)
	     This produces output.txt / removes output.txt

output.txt : Generated after running Makefile 

--------------------------------------------------------------

Steps to run:

1. Place nanoC code in A4_42.nc (which is to be tested)

2. open terminal (current directory) and type 
	 make

3. FLEX will generated {lex.yy.c, lex.yy.o}

4. BISON will generated {y.tab.c, y.tab.h, y.tab.o, y.output}

5. main.c will generated {A4_42.o, a.out, output.txt}

6. output.txt => contains the desired output
	
7. To clean the old compiled file type
	make clean

8. Repeat from step 1 for other test files

-----------------------------------------------------------

Modifications made to execute properly:

1. Used Kleen closure for translation unit.
2. Removed paranthesis in function defination. 
	(direct_declarator: IDENTIFIERS LEFT_PARENTHESIS parameter_list_opt RIGHT_SQUARE_BRACKET)
3. Multiple compound statements are space padded.
	
