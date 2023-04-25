output.txt: a.out A3_42.nc
	./a.out < A3_42.nc > output.txt

a.out:	lex.yy.c
		cc lex.yy.c -lfl

lex.yy.c: A3_42.l 
		flex A3_42.l A3_42.c



clean:
		rm a.out lex.yy.c output.txt
