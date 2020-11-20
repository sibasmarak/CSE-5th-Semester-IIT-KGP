#include "toylib.h"
#define MAX_INT 2147483647

int printStringUpper (char * string)
{
    int len = 0;
    while(string[len] != '\0')
        len++;
    char buffer[len + 1];
    for(int i = 0; i < len; i++)
    {
        if('a' <= string[i] && string[i] <= 'z'){
            buffer[i] = string[i] - 'a' + 'A';
        }
        else{
            buffer[i] = string[i];
        }  
    }
    buffer[len] = '\0';

    __asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(buffer), "d"(len)
    );
    return len;
}

int printHexInteger (int n)
{
    char map[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    int num = n, i = 0, index;
    char buffer[8] = {0};
    if(n == 0)
    {
        char buff[1] = {'0'};
        __asm__ __volatile__ (
            "movl $1, %%eax \n\t"
            "movq $1, %%rdi \n\t"
            "syscall \n\t"
            :
            :"S"(buff), "d"(1)
        );
        return 1;
    }
    if(n < 0)
        num = -n;
    while(num > 0)
    {
        index = num % 16;
        buffer[i++] = map[index];
        num = (num - index) / 16;
    }
    if(n > 0)
    {
        char buff[i];
        for(int j = i - 1; j >= 0; j--)
            buff[j] = buffer[i - j - 1];
        __asm__ __volatile__ (
            "movl $1, %%eax \n\t"
            "movq $1, %%rdi \n\t"
            "syscall \n\t"
            :
            :"S"(buff), "d"(i)
        );
        return i;
    }
    else if(n < 0)
    {
        char buff[i + 1];
        for(int j = i; j > 0; j--)
            buff[j] = buffer[i - j];
        buff[0] = '-';
        __asm__ __volatile__ (
            "movl $1, %%eax \n\t"
            "movq $1, %%rdi \n\t"
            "syscall \n\t"
            :
            :"S"(buff), "d"(i+1)
        );
        return i+1;
    }
        
    return BAD;
}

int printFloat (float f)
{
    char before_decimal[40];
    char after_decimal[5] = {'0', '0', '0', '0', '\0'};
    int integer_part = (int)f;
    int remaining_part = (int)((f - integer_part) * 10000 + 0.5);
    int index = 3;
    while (index >= 0 && remaining_part > 0)
    {
        after_decimal[index--] = '0' + remaining_part % 10;
        remaining_part /= 10;
    }
    after_decimal[4] = '\0';

    int i = 0;
    if(integer_part == 0)
    {
        before_decimal[0] = '0'; 
        i = 1;
    }

    while(integer_part > 0)
    {
        before_decimal[i++] = '0' + integer_part % 10;
        integer_part /= 10;
    }

    char buffer[i+1];
    for(int j = i - 1; j >= 0; j--)
        buffer[j] = before_decimal[i - j - 1];
    buffer[i] = '\0';

    char buff[i+6];            
    for(int j = 0; j < i; j++)
        buff[j] = buffer[j];

    buff[i] = '.';

    for(int j = i+1; j < i + 5; j++)
        buff[j] = after_decimal[j - i - 1];
    
    int size = i + 5;
    for(int j = i + 4; j >= i + 1; j--)
    {
        if(buff[j] == '0')
        {
            size -= 1;
            buff[j] = '\0';
        }
        else
        {
            break;
        }
        
    }
    buff[i + 5] = '\0';

    __asm__ __volatile__ (
            "movl $1, %%eax \n\t" 
            "movq $1, %%rdi \n\t"
            "syscall \n\t"
            :
            :"S"(buff), "d"(size)
        );
    return size;
}

int readFloat (float * f)
{
    int actual_read;
    int max_read = 40;
    char buffer[max_read];

    __asm__ __volatile__ (
            "movl $0, %%eax \n\t" 
            "movq $0, %%rdi \n\t"   // stdin
            "syscall \n\t"
            : "=a"(actual_read)
            :"S"(buffer), "d"(max_read)
        );
    if(actual_read < 0)
        return BAD;
    char buff[actual_read];
    for(int i = 0; i < actual_read; i++)
        buff[i] = buffer[i];
    buff[actual_read - 1] = '\0';

    int dot_seen = 0, index = 0;
    float val = 0;
    float shift = 1, sign = 1;
    char digit;
    if(buff[index] == '-')
    {
        index++;
        sign = -1;
    }

    for(int j = index; j < actual_read - 1; j++)
    {
        digit = buff[j];
        if(digit == '.' && dot_seen == 0)
        {
            dot_seen = 1;
            continue;
        }
        else if(digit == '.' && dot_seen > 0)
        {
            return BAD;
        }

        if((digit - '0') >= 0 && (digit - '0') <= 9)
        {
            digit = digit - '0'; 
            if(dot_seen == 1)
                shift = shift / ((float) 10.0);
            val = val * 10.0 + (float)digit;
        }
        else 
            return BAD;
    }
    val = sign * val * shift;
    *f = val;
    return GOOD;
}

int readHexInteger (int *n)
{
    int actual_read;
    int max_read = 12;
    char buffer[max_read];

    __asm__ __volatile__ (
            "movl $0, %%eax \n\t" 
            "movq $0, %%rdi \n\t"   // stdin
            "syscall \n\t"
            : "=a"(actual_read)
            :"S"(buffer), "d"(max_read)
        );
    if(actual_read < 0)
        return BAD;
    if((buffer[0] == '-' && actual_read > 10) || (buffer[0] != '-' && actual_read > 9 ))
        return BAD;   
    char buff[actual_read];
    for(int i = 0; i < actual_read; i++)
        buff[i] = buffer[i];
    buff[actual_read - 1] = '\0';

    int index = 0, sign = 1;
    long val = 0;
    char digit;
    if(buff[index] == '-')
    {
        index++;
        sign = -1;
    }

    for(int j = index; j < actual_read - 1; j++)
    {
        digit = buff[j];
        if( (digit - '0') >= 0 && (digit - '0') <= 9 )
        {
            digit = digit - '0'; 
            if(val * 16 + digit > MAX_INT)
                return BAD;
            val = val * 16 + digit;
        }
        else if(digit >= 'a' && digit <= 'f')
        {
            if(val * 16 + (digit - 'a' + 10) > MAX_INT)
                return BAD;
            val = val * 16 + (digit - 'a' + 10);
        }

        else 
            return BAD;
    }

    val = sign * val;
    *n = val; 
    return GOOD;
}