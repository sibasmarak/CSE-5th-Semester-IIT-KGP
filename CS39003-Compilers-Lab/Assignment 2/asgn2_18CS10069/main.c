#include "stdio.h"
#include "stdlib.h"
#include "toylib.h"
int main()
{
    printf("*** Welcome To Assignment 2 - 18CS10069 ***\n------------------------------------------------------------------\n\n");
    printf("#1 ---------------------- Interface for printStringUpper() ----------------------\n");
    printf("Enter the length of string to be read {Less than 80 characters}:\n");
    char* string = (char*)malloc((81) * sizeof(char));
    scanf("%[^\n]s", string);
    int length = printStringUpper(string);
    printf("\nThe length of the string printed: %d \n", length);
    printf("\n\n");

    printf("#2 ---------------------- Interface for readHexInteger() ----------------------\n");
    printf("Enter a hexadecimal (in x form - all a-f should be small) to be read:\n");
    int * n = (int*)malloc(sizeof(int));     
    int ans = readHexInteger(n);
    if(ans == GOOD)
        printf("The hex string has been successfully read: %d\n", *n);
    else
        printf("Error Occured!\n");
    printf("\n\n");

    int integer;
    printf("#3 ---------------------- Interface for printHexInteger() ----------------------\n");
    printf("Enter an integer which is to be converted to hex: \n");
    scanf("%d", &integer);
    length = printHexInteger(integer);    
    printf("\nThe length of the hexadecimal (in X form - all A-F are in upper case) string printed: %d \n", length);
    printf("\n\n");

    printf("#4 ---------------------- Interface for readFloat() ----------------------\n");
    printf("Enter a float to be read:\n");
    float * f = (float*)malloc(sizeof(float));     
    ans = readFloat(f);
    if(ans == GOOD)
        printf("The float string has been successfully read: %.4f \n", *f);
    else
        printf("Error Occured!\n");
    printf("\n\n");

    float Float;
    printf("#5 ---------------------- Interface for printFloat() ----------------------\n");
    printf("Enter a float which is to be printed: \n");
    scanf("%f", &Float);
    length = printFloat (Float);
    printf("\nThe length of the Float string printed: %d \n", length);
    printf("\n\n");

    return 0;
}