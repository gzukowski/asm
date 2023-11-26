#include <stdio.h>
void dodaj_SSE(char* tab1, char* tab2, char* wynik);

int main() {


	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122,
	-121, 120, 121, 122, 123, 124, 125, 126, 127 };
	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3,
	3, 3, 3, 3, 3, 3, 3, 3 };
	char sumy[16];

	dodaj_SSE(liczby_A, liczby_B, sumy);

	for(int i = 0; i <16; i++)
		printf("%d ", liczby_A[i]);

	printf("\n");
	for (int i = 0; i < 16; i++)
		printf("%d ", liczby_B[i]);
	printf("\n");
	for (int i = 0; i < 16; i++)
		printf("%d ", sumy[i]);


	return 0;
}