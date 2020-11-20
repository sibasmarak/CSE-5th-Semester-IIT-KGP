/*
*** Welcome to Compilers lab assignment 4
*** Name: Siba Smarak Panigrahi
*** Roll: 18CS10069
*/
extern double p1();
const float p2 = .2e-3;
restrict volatile short p3 = 5;

static int demo(int p)
{
    if(p > 30)
    {
        p = p % 5;
        return p;
    }
    else
    {
        return p + 2;
    }
}

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

    do{
        n -= 1;
    }while(n > 1);
    
    if(t <= 30)
    if(t <= 15)
        n++;
    else
        n--;
    else 
        n += 2;

    // hey see, here is a single line comment!
    int i, j;
    for(i = 5; i >= 0; i--)
    {
        for(j = 0; j < 5; j++)
        {
            n++;
        }
    }
}