#include <stdio.h>

void pm_jeden(float* tabl);


int main() {

	float tablica[4] = { 13.2, 1.2, -1.0, 5.3};

	printf("\n%f %f %f %f\n", tablica[0],
		tablica[1], tablica[2], tablica[3]);
	pm_jeden(tablica);
	printf("\n%f %f %f %f\n", tablica[0],
		tablica[1], tablica[2], tablica[3]);
	return 0;

	return 0;
}