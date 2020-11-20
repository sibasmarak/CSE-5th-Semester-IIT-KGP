// typecasting and pointers
void swapTwoNumbers(int* a, int* b) //pointers
{
	int temp = *a;
	*a = *b;
	*b = temp;
	return;
}

int division(float a, float b)
{
	int quotient;
	quotient = a/b; // type casting float -> int
	return quotient;
}

int main()
{
	int q=0,r=0;
	float x=2.5;
	q = division(x,1.2);
	r=10;
	swapTwoNumbers(&q,&r);
	return;
}
