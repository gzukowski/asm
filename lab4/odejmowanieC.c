#include <stdio.h>

int odejmowanie(int** odjemna, int* odjemnik);
int main() {

	int a, b, * wsk, wynik;

	wsk = &a;
	
	a = 21;
	b = 5;

	wynik = odejmowanie(&wsk, &b);

	printf("%d", wynik);
	return 0;
}