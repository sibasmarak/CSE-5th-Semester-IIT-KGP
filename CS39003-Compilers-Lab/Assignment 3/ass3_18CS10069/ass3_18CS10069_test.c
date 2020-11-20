/*
*** Welcome to Compilers lab assignment 3
*** Name: Siba Smarak Panigrahi
*** Roll: 18CS10069
*/

#include "stdio.h"
#define ASSGN 3
struct student{
    int roll;
    char name[30];
};

void main()
{
    float f = .87e-03;
    int n = 32;
    double d = 25.;
    float t = 43.46;
    char ch = 'ascii';
    char buff[30] = "Here is a good one!\n\t";
    char arr[4] = "";
    /* this comment is a multi line comment. 
    We will briefly check one single line just after this! */

    do while
    {
        n -= 1;
    }(n > 1)

    // hey see, here is a single line comment!
    if(t <= 30)
        n++;
    else
        n--;
    printf("print: %d\n", n+1);
}