#include <stdio.h>

int funkcja(int e);

int main() {

	int* a = funkcja(5);

	if (a == -1) {
		return 0;
	}
		
	printf("%d ", a[2]);

	return 0;
}