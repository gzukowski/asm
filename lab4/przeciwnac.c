#include <stdio.h>
void przeciwna(int* a);
int main()
{
	int m;
	m = 0;
	przeciwna(&m);
	printf("\n m = %d\n", m);
	return 0;
}