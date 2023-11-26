#include <stdio.h>

void int2float(int* calkowite, float* zmienno_przec);




int main() {

	int a[2] = { -17, 24 };
	float r[4];
	// podany rozkaz zapisuje w pamiêci od razu 128 bitów,
	// wiêc musz¹ byæ 4 elementy w tablicy
	int2float(a, r);

	printf("%f", r[1]);

	return 0;
}