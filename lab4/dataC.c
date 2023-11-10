#include <windows.h>
#include <stdio.h>

extern int wyswietl_date();

void main()
{   
    // GetSYstemTime(&wynik)
    int minuty = wyswietl_date();

    printf("minuty: %02d\n", minuty);
}