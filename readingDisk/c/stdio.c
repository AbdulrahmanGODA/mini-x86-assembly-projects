#include "stdio.h"
#include "print.h"

void putc(char c){
    x86_CHARTTY(c,0);
}
void puts(const char* s){
    while(*s){
    putc(*s);
    s++;
    }
}
void delay(){
    DELAY();
}
void clear(){
    CLEAR();
}

