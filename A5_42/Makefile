parser.out: lex.yy.o A5_42.tab.o A5_42_translator.o
	g++ lex.yy.o A5_42.tab.o A5_42_translator.o -lfl -o parser.out

A5_42_translator.o: A5_42_translator.cpp A5_42_translator.h
	g++ -c -Wno-return-type A5_42_translator.cpp

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

A5_42.tab.o: A5_42.tab.c
	g++ -c A5_42.tab.c

lex.yy.c: A5_42.l A5_42.tab.h A5_42_translator.h
	flex A5_42.l

A5_42.tab.c A5_42.tab.h: A5_42.y
	bison -dt --report=all A5_42.y

clean:
	rm *.out A5_42_translator.o lex.yy.* A5_42.tab.* A5_42.output

test: parser.out
	./parser.out < A5_42_test1.nc > A5_42_quads1.out
	./parser.out < A5_42_test2.nc > A5_42_quads2.out
	./parser.out < A5_42_test3.nc > A5_42_quads3.out
	./parser.out < A5_42_test4.nc > A5_42_quads4.out
	./parser.out < A5_42_test5.nc > A5_42_quads5.out
	
