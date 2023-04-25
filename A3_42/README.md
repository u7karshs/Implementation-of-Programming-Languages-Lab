# Assignment 3
FLEX (fast lexical analyzer generator) is a tool for generating lexical analyzers (scanners or lexers). 
You are expected to use FLEX to design a Lexical Analyzer, which is the first phase of a Compiler


--------------------------------------------------------------
Contents:

A3_42.c  : Contains main function
A3_42.l  : Contains FLEX specifications
A3_42.nc : nanoC file (to test FLEX token specifications)

Makefile : To make/ make clear the test nanoC file
	     This produces output.txt

output.txt : Generated after running Makefile 

--------------------------------------------------------------

Steps to run:

1. Place nanoC code in A3_42.nc (which is to be tested)
2. open terminal (current directory) and type 
	 make

3. This will generated {a.out, lex.yy.c, output.txt}
	output.txt => contains the desired output

4. To clean the old compiled file type
	make clean

5. Repeat from step 1 for other test files
