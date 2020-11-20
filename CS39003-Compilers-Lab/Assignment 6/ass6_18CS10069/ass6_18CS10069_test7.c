int printStr(char *c);
int printInt(int i);
int readInt(int *eP);

int main () {
    int eP;
    printStr("\n        #############################################################\n        ##                                                         ##\n        ##            PRINT LOWER TRIANGLE PATTERN                 ##\n        ##    CHECK FOR CONDITIONAL STATEMENT AND NESTED LOOP      ##\n        ##                                                         ##\n        #############################################################\n\n        \n");    
    printStr("        ENTER SIZE OF THE TRIANGLE ");

    int b,n,i,j;
    n = readInt(&ep);

    for (i = 0; i < 2*n-1; i++)
    {
        printStr("\n        ");
        for (j = 0; j <= i; j++)
        {
            printStr("*");
        }
    }
    return 0;
}