output_18CS10069.txt: a.out ass3_18CS10069_test.c
	./a.out < ass3_18CS10069_test.c > ass3_18CS10069.txt

a.out: lex.yy.c
	cc lex.yy.c -lfl

lex.yy.c: ass3_18CS10069.l
	flex ass3_18CS10069.l ass3_18CS10069.c

clean:
	rm a.out lex.yy.c