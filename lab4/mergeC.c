//#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>

int* merge(int* tab1, int* tab2, int n);

int main() {
    int n;

    scanf_s("%d", &n);

    int* tab1 = (int)malloc(n*sizeof(int));
    int* tab2 = (int)malloc(n*sizeof(int));
    int* wynik;

    int i = 0;
    for (i = 0; i < n; i++) {
        scanf_s("%d", &tab1[i]);
    }
    for (i = 0; i < n; i++) {
        scanf_s("%d", &tab2[i]);
    }

    wynik = merge(tab1, tab2, n);
    if (*wynik == NULL) {
        free(tab1);
        free(tab2);
        printf("jrogoskiego");
        return 0;
    }


    for (i = 0; i < n*2; i++) {
        printf("%d ", wynik[i]);
    }

    free(tab1);
    free(tab2);
    return 0;
}