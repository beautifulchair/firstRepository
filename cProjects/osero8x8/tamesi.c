#include <stdlib.h>
#include <stdio.h>
#include "hs/available.h"
#include "hs/board.h"
#include "hs/otherfunc.h"
#include "hs/putImfo.h"

int main(int argc, char* argv[]){
    int bN=0,wN=0,dN=0;
    int winner;
    char buf[1000];
    FILE *fp = fopen("datas/results.csv", "r");
    if(fp==NULL) return 0;
    for(int i=0; i<20000; i++){
        fgets(buf, 1000, fp);
        sscanf(buf, "%d", &winner);
        if(winner==1) bN++;
        if(winner==2) wN++;
        if(winner==0) dN++;
    }
    fclose(fp);
    printf("black: %d, white: %d, draw: %d", bN,wN,dN);
    return 0;
}