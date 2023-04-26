parser.out: lex.yy.o A6_42.tab.o A6_42_translator.o A6_42_target_translator.o
	g++ lex.yy.o A6_42.tab.o A6_42_translator.o A6_42_target_translator.o -lfl -o parser.out

A6_42_target_translator.o: A6_42_target_translator.cpp A6_42_translator.h
	g++ -c A6_42_target_translator.cpp

A6_42_translator.o: A6_42_translator.cpp A6_42_translator.h
	g++ -c -Wno-return-type A6_42_translator.cpp

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

A6_42.tab.o: A6_42.tab.c
	g++ -c A6_42.tab.c

lex.yy.c: A6_42.l A6_42.tab.h A6_42_translator.h
	flex A6_42.l

A6_42.tab.c A6_42.tab.h: A6_42.y
	bison -dt --report=all A6_42.y

libA6_42.a: lib_A6_42.o
	ar -rcs libA6_42.a lib_A6_42.o

lib_A6_42.o: lib_A6_42.c myl.h
	gcc -c lib_A6_42.c



clean:
	rm *.a *.o *.output test* *.out lex.yy.c A6_42.tab.c A6_42.tab.h *.asm

test1: parser.out libA6_42.a
	./parser.out A6_42_test1 > A6_42_quads1.out
	gcc A6_42_test1.s -L. -lA6_42 -no-pie -o test1
	mv A6_42_test1.s A6_42_test1.asm
	@echo "Executed test 1:\n"
	
	
test2: parser.out libA6_42.a
	./parser.out A6_42_test2 > A6_42_quads2.out
	gcc A6_42_test2.s -L. -lA6_42 -no-pie -o test2
	mv A6_42_test2.s A6_42_test2.asm
	@echo "Executed test 2:\n"
	
	
test3: parser.out libA6_42.a
	./parser.out A6_42_test3 > A6_42_quads3.out
	gcc A6_42_test3.s -L. -lA6_42 -no-pie -o test3
	mv A6_42_test3.s A6_42_test3.asm
	@echo "Executed test 3:\n"
	
	
test4: parser.out libA6_42.a
	./parser.out A6_42_test4 > A6_42_quads4.out
	gcc A6_42_test4.s -L. -lA6_42 -no-pie -o test4
	mv A6_42_test4.s A6_42_test4.asm
	@echo "Executed test 4:\n"
	
	
test5: parser.out libA6_42.a
	./parser.out A6_42_test5 > A6_42_quads5.out
	gcc A6_42_test5.s -L. -lA6_42 -no-pie -o test5
	mv A6_42_test5.s A6_42_test5.asm
	@echo "Executed test 5:\n"
	
