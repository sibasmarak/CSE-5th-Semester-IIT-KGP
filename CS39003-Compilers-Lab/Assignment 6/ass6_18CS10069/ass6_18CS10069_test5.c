//test file to check basic statements, expression, readInt and printInt library 
//functions created in assignment 2
//also checks the recursive fibonacci function to check the function call and return methodology


int printStr(char *c);
int printInt(int i);
int readInt(int *eP);


int fib(int a){
  printStr("\nENTERING THE FUNCTION FOR ( I ) : ");
  printInt(a);
  int b=a-1,c,d;
  if(b<=0) return 1;
  else {
    c=fib(b);
    b=b-1;
    d=fib(b);
    c=c+d;
    return c;
  }
  return 1;
}

int main () {
  int a = 5, b = 2, c;
  int read;
  read = 5;
  int eP;
  if (a<b) {
    a++;
  }
  else {
    c = a+b;
  }

  printStr("\n    #####################################################\n    ##                                                 ##\n    ##       RECURSIVE FIBONACCI SIMULATION            ##\n    ##            TEST FUNCTION CALLS                  ##\n    ##            AND LIBRARY MYL.H                    ##\n    ##                                                 ##\n    #####################################################\n    \n");
  printStr("ENTER THE NUMBER N FOR FIBOACCI: ");
  read = readInt(&eP);
  printStr("ENTERED NUMBER ");
  c = printInt(read);
  printStr("\n");

  printStr("------------TESTING RECURSIVE FIBOACCI-----------\nENTERING THE FUNCTION: \n");
  int out=0;
  out=fib(read);
  printStr("\n\nReturned from recursive fibonacci function successfully!!\n");
  printStr("----------- SUCCESSFULLY TERMINATED ----------");

}