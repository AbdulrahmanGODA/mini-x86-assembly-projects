#include "stdint.h"
#include "stdio.h"

int _cdecl CSTART_(){
    puts("5 seconds remaining ... ");
    delay();
    clear();
    puts("4 seconds remaining ... ");
    delay();
    clear();
    puts("3 seconds remaining ... ");
    delay();
    clear();
    puts("2 seconds remaining ... ");
    delay();
    clear();
    puts("1 second remaining ... ");
    delay();
    clear();
    puts("*HERE WE GOOO*");
    return 0;
}
