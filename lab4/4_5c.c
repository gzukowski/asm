#include <stdio.h>
__int64 suma7(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);

int main() {
	__int64 wynik;

	wynik = suma7(-5, -10, -10, -10, -10, -10, -10);

	printf("wynik: %d", wynik);
	return 0;
}
