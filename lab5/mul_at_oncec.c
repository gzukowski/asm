#include <stdio.h>
#include <xmmintrin.h>

__m128 mul_at_once(__m128 one, __m128 two);


int main() {
	__m128 jeden;
	jeden.m128_i32[0] = 2;
	jeden.m128_i32[1] = 2;
	jeden.m128_i32[2] = 2;
	jeden.m128_i32[3] = 2;

	__m128 dwa;
	dwa.m128_i32[0] = 2;
	dwa.m128_i32[1] = 2;
	dwa.m128_i32[2] = 2;
	dwa.m128_i32[3] = 2;


	__m128 trzy;
	trzy =	mul_at_once(jeden, dwa);
	for (int K = 0; K < 4; K++) {
		printf("%d ", trzy.m128_i32[K]);
	}

	return 0;
}