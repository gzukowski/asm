#include <stdio.h>
#include <xmmintrin.h>

void dziel(__m128* tablica1, unsigned int n, float dzielnik);


int main(){

	int jeden = 5;
	__m128 tab = { jeden, jeden, jeden, jeden };
	__m128 tablica[3] = { (__m128) { 1.0f, 2.0f, 3.0f, 4.0f },
						 (__m128) { 5.0f, 6.0f, 7.0f, 8.0f},
						(__m128) {9.0f, 10.0f, 11.0f, 12.0f} };

	dziel(tablica, 3, 2.0);

	for (int i = 0; i < 3; i++) {
		for (int K = 0; K < 4; K++) {
			printf("%f ", tablica[i].m128_f32[K]);
		}
		printf("\n");
		
	}
	
	
	return 0;
}