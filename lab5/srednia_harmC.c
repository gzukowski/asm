#include <stdio.h>

float srednia_harm(float* tablica, unsigned int counter);


int main() {

	float tab[] = {5.5, 3.2, 5.1};
	unsigned int n = 3;

	float a = srednia_harm(tab, n);
	printf("%f", a);
	return 0;
}
