//This test file extensively checks the expressions both boolean and algebraic
//and also the funciton calling and returning process in detail

int printStr(char *c);
int printInt(int i);
int readInt(int *eP);
int a;
int b = 1;
char c;
char d = 'a';

int add (int a, int b) {
  int ans;
  int c = 2, d, arr[10];
  int*p;
  printStr("    ==== Entered into the function ====\n");
  ans = a+b;
  d = 2;
  if (a>=d) {
    a++;
  }
  else {
    c = a+b;
  }
  printStr("    ==== Returning from function   ====\n");
  return ans;
}
int main () {
  int c = 2, d, arr[10];
  int*p;
  int x, y, z;
  int eP;
  printStr("\n    ####################################################\n    ##                                                ##\n    ##           Tracing function steps               ##\n    ##      Adding two numbers in a Function          ##\n    ##                                                ##\n    ####################################################\n    \n\n");
  printStr("\n    Enter two numbers :\n");
  printStr("\n    Enter first numbers  : ");
  x = readInt(&eP);
  printStr("    Enter second numbers : ");
  y = readInt(&eP);
  printStr("\n    ==== Passing to the function   ====\n");
  z = add(x,y);
  printStr("\n    Sum is equal to : ");
  printInt(z);
  printStr("\n");
  return c;
}
