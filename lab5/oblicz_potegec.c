#include <stdio.h>
float oblicz_potege(unsigned char a, int m);

int main()
{
	float wynik;

	for (int i = -7; i < 7; i++) {
		wynik = oblicz_potege(24, i);
		printf("%10.2f \n", wynik);
	}
	
	return 0;
}