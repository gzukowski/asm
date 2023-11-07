#include <stdio.h>
int szukaj_max(int a, int b, int c, int d);
int main()
{
	int x, y, z, m, wynik;
	printf("\nProszê podaæ trzy liczby ca³kowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &m, 32);
	wynik = szukaj_max(x, y, z, m);
	printf("\nSpoœród podanych liczb %d, %d, %d, %d \
 liczba %d jest najwiêksza\n", x, y, z, m, wynik);
	return 0;
}