#include <stdio.h>
#include <xmmintrin.h>

void wyznacz_max(float* one, int prog);


int main() {
	
	float tablica[4] = { 2.0 , 3.0, 5.0, 1.0 };
	int prog = 2;
	wyznacz_max(tablica, prog);

	printf("%f, %f, %f, %f", tablica[0], tablica[1], tablica[2], tablica[3]);
	return 0;
}