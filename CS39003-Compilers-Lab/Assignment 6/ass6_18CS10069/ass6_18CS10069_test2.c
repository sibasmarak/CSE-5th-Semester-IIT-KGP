//This testfile checks the functioning of the library functions printInt, readInt and printStr

int printInt(int num);
int printStr(char * c);
int readInt(int *eP);

// user-defined function (with pointer parameters)
// return an int value
int test(int *a)
{
    return a;
}

int main()
{
    int a,b;
    int *e;
    
    printStr("        #########################################################\n        ##                 TESTING FUNCTIONS                   ##\n        #########################################################        \n");
    
    b = 3;
    e = &b;

    // checking printStr() and printStr()
    printStr("\n\n        Passing parameter to function :\n        int test(int *a)    \n");
    printStr("\n        Value passed to function: ");
    printInt(b);
    printStr("\n");
    
    a = test(b);
    printStr("\n        Address returned from function is: ");
    printInt(a);
    printStr("\n");
    
    printStr("\n        #####################################################\n        ##              READ AN INTEGER                    ##\n        ##                TESTING I/O                      ##\n        #####################################################\n        \n");
    printStr("\nEnter an Integer : ");
    b = readInt(e);
    printStr("The integer that was read is : ");
    printInt(b);
    printStr("\n");
    

    return 0;
}