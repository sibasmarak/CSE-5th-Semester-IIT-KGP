a.out: main.o libass2_18CS10069.a
	c++ main.o -L. -lass2_18CS10069

main.o: main.c toylib.h
	c++ -Wall -c main.c

libass2_18CS10069.a: ass2_18CS10069.o
	ar -rcs libass2_18CS10069.a ass2_18CS10069.o

ass2_18CS10069.o: ass2_18CS10069.cpp toylib.h
	c++ -Wall -c ass2_18CS10069.cpp

clean:
	rm a.out main.o libass2_18CS10069.a ass2_18CS10069.o