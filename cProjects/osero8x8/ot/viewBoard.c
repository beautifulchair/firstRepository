#include <stdio.h>

int main(){
    printf("  __ __ __ __ __ __ __ __\n");
    for(int r=0; r<8; r++){
        printf("%d|", r);
        for(int c=0; c<8; c++){
            printf("%02d|", r*8+c);
        }
        printf("\n");
    }
    printf("   0  1  2  3  4  5  6  7\n");
    return 0;
}