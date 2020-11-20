int printStr(char *c);
int printInt(int i);
int readInt(int *eP);

int main () {
  printStr("\n    #######################################################\n    ##                                                   ##\n    ##      Print first N fibonacci numbers              ##\n    ##         CHECK FOR BINARY OP AND LOOP              ##\n    ##                                                   ##\n    #######################################################\n\n");


  printStr("ENTER THE VALUE FOR N (<=45): ");
  int i,ep;
  i=readInt(&ep);
  printStr("\nYOU ENTERED THE VALUE: ");
  printInt(i);

  printStr("\n\nTHE FIRST ");
  printInt(i);
  printStr(" FIBONACCI NUMBERS ARE :\n\n        ");

  int j,a=0,b=1,c;

  if(i>0) printInt(a);
  printStr(" ");
  if(i>1) printInt(b);
  printStr(" ");

  for(j=2;j<i;j++){
    c = a+b;
    printInt(c);
    printStr(" ");
    a = b;
    b = c;

    int r=j/10;
    if(r*10==j){
      printStr("\n        ");
    }
  }

  printStr("\n");
  return;
}