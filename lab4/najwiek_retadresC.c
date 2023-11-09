#include <stdio.h>


int* znajdz_maks(int* tab, int n);

int main() {
	int tab[] = { 4, 3, 2, 1, 5 };
	int* m = 5;

	int wynik = znajdz_maks(tab, m);
	printf("%d", wynik);
	return 0;
}