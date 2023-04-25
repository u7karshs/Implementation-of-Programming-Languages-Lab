output.txt: a.out A4_42.nc
	./a.out < A4_42.nc > output.txt

a.out: lex.yy.o y.tab.o A4_42.o
	cc lex.yy.o y.tab.o A4_42.o -lfl

lex.yy.o: lex.yy.c
	cc -c lex.yy.c

y.tab.o: y.tab.c
	cc -c y.tab.c

main.o: A4_42.c
	cc -c A4_42.c

lex.yy.c: A4_42.l y.tab.h 
	flex A4_42.l

y.tab.c: A4_42.y
	bison -dvty A4_42.y

y.tab.h: A4_42.y
	bison -dvty A4_42.y

A4_42.c:
	touch A4_42.c

clean:
	rm output.txt a.out lex.yy.* y.tab.* y.output A4_42.o
