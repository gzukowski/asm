#include <stdio.h>
int szukaj_max(int a, int b, int c, int d);
int main()
{
	int x, y, z, m, wynik;
	printf("\nProsz� poda� trzy liczby ca�kowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &m, 32);
	wynik = szukaj_max(x, y, z, m);
	printf("\nSpo�r�d podanych liczb %d, %d, %d, %d \
 liczba %d jest najwi�ksza\n", x, y, z, m, wynik);
	return 0;
}