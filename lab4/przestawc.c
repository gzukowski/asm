#include <stdio.h>

void przestaw(int tab[], int n);
main() {

	int tab[] = { 3, 2, 5, 1, 7 };
	int m = 5;


	
	for (int i = 0; i < m; i++) {
		przestaw(tab, m);
		
	}

	for (int i = 0; i < m; i++) {
		printf("%d ", tab[i]);

	}
	
	return 0;
}