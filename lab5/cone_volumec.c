#include <stdio.h>

float cone_volume(unsigned int big_r, unsigned int small_r, float h);



int main() {
	float wynik = cone_volume(6, 2, 5.3);
	printf("%f", wynik);
	return 0;
}