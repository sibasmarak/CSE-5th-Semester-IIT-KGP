//  arrays (multidimensional) ,  loops and nested loops
int x = 0;

int main()
{
	int i, j, n;
	int sum=0;
	char a='a';
	int p[5]; // 1D integer array
	int dp[5][5]; // 2D integer array
	n=5;
	j=100;
	i=0;

	while(i<5) // while loop1
	{
		i++;
		++j;
		p[i]=i*j;
	}

	do // do-while loop
	{
		sum = sum + p[i];
	}while(i<n);

	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)  // nested for loop
			dp[i][j]= sum + i*j; // multi dimensional array
	}
	return 0;
}
