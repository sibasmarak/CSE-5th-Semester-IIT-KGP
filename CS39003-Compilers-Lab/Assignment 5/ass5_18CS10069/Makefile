test: a.out
	
	@echo "TRANSLATING TEST FILE 1 \n(2D ARRAYS and LOOPS)==>\n\n"
	./a.out < ass5_18CS10069_test1.c > ass5_18CS10069_quads1.out
	@echo "Test File 1 Successfully Translated !\n"

	@echo "TRANSLATING TEST FILE 2 \n(TYPE CASTING AND POINTERS)==>\n\n"
	./a.out < ass5_18CS10069_test2.c > ass5_18CS10069_quads2.out
	@echo "Test File 2 Successfully Translated !\n"
	
	@echo "TRANSLATING TEST FILE 3 \n(ARITHMETIC EXPRESSIONS AND NESTED BLOCKS)==>\n\n"
	./a.out < ass5_18CS10069_test3.c > ass5_18CS10069_quads3.out
	@echo "Test File 3 Successfully Translated !\n"
	
	@echo "TRANSLATING TEST FILE 4 \n(FUNCTION CALL, TERNARY, IF-ELSE)==>\n\n"
	./a.out < ass5_18CS10069_test4.c > ass5_18CS10069_quads4.out
	@echo "Test File 4 Successfully Translated !\n"
	
	@echo "TRANSLATING TEST FILE 5 \n(NESTED IF-ELSE)==>\n\n"
	./a.out < ass5_18CS10069_test5.c > ass5_18CS10069_quads5.out
	@echo "Test File 5 Successfully Translated !\n"
	
	@echo "TRANSLATING TEST FILE 6 ==>\n"
	./a.out < ass5_18CS10069_test6.c > ass5_18CS10069_quads6.out
	@echo "Test File 6 Successfully Translated !\n"
	
	@echo "TRANSLATING TEST FILE 7 \n(UNCONDITIONAL JUMP GOTO)==>\n\n"
	./a.out < ass5_18CS10069_test7.c > ass5_18CS10069_quads7.out
	@echo "Test File 7 Successfully Translated !\n"
	
	@echo "TRANSLATING TEST FILE 8 \n(NESTED FOR WHILE DO_WHILE BOOLEAN)==>\n\n"
	./a.out < ass5_18CS10069_test8.c > ass5_18CS10069_quads8.out
	@echo "Test File 8 Successfully Translated !\n"

	@echo "\nALL TEST FILES SUCCESSFULLY TRANSLATED !!\n"

a.out: lex.yy.o ass5_18CS10069.tab.o ass5_18CS10069_translator.o
	g++ lex.yy.o ass5_18CS10069.tab.o ass5_18CS10069_translator.o -lfl

ass5_18CS10069_translator.o: ass5_18CS10069_translator.cxx ass5_18CS10069_translator.h
	g++ -c ass5_18CS10069_translator.h
	g++ -c ass5_18CS10069_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

ass5_18CS10069.tab.o: ass5_18CS10069.tab.c
	g++ -c ass5_18CS10069.tab.c

lex.yy.c: ass5_18CS10069.l ass5_18CS10069.tab.h ass5_18CS10069_translator.h
	flex ass5_18CS10069.l

ass5_18CS10069.tab.c: ass5_18CS10069.y
	bison -dtv ass5_18CS10069.y -W

ass5_18CS10069.tab.h: ass5_18CS10069.y
	bison -dtv ass5_18CS10069.y -W

clean:
	rm lex.yy.c\
	   lex.yy.o\
	   a.out\
	   ass5_18CS10069.tab.c\
	   ass5_18CS10069.tab.h\
	   ass5_18CS10069.tab.o\
	   ass5_18CS10069.output\
	   ass5_18CS10069_translator.o\
	   ass5_18CS10069_translator.h.gch\
	   ass5_18CS10069_quads1.out\
	   ass5_18CS10069_quads2.out\
	   ass5_18CS10069_quads3.out\
	   ass5_18CS10069_quads4.out\
	   ass5_18CS10069_quads5.out\
	   ass5_18CS10069_quads6.out\
	   ass5_18CS10069_quads7.out\
	   ass5_18CS10069_quads8.out
