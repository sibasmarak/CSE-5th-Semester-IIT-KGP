#ifndef _MYL_H
#define _MYL_H
#define ERR 1
#define OK 0
int printStr(char *);
int printInt(int);
int readInt(int *eP);		// *eP is for error, if the input is not an integer						
int readFloat(float *);		// return value is error or OK
int printFloat(float);
#endif