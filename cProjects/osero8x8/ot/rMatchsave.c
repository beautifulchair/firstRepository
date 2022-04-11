#include <stdio.h>
#include <string.h>
#include "hs/available.h"
#include "hs/board.h"
#include "hs/putImfo.h"
#include "hs/otherfunc.h"

// ex. ./r 1000 29
int main(int argc, char *argv[]){
    int n, c;
    int i, j;
    int pren, tmp, winner, bN, wN;
    board b;
    char fname[30];
    FILE *fp = NULL;

    if(argc != 3)
        return 0;

    if(sscanf(argv[1], "%d", &n)==0 || sscanf(argv[2], "%d", &c)==0)
        return 0;

    switch(c){
        case 29:
            strcpy(fname, "datas/results29.csv"); break;
        case 43:
            strcpy(fname, "datas/results29.csv"); break;
        case 45:
            strcpy(fname, "datas/results29.csv"); break;
        default:
            return 0;
    }

    readAvailable();
    fp = fopen(fname, "w");
    if(fp == NULL){
        printf("failed in open %s", fname);
        return 0;
    }

    for(i=0; i<n; i++){
        b = initBoard();
        justput(&b, 44, b.nextS);
        addPutImfo(44);
        justput(&b, c, b.nextS);
        addPutImfo(c);

        pren = 0;
        while(1){
            tmp = allAvailable(b, b.nextS);
            if(tmp == 0){
                justput(&b, -1, b.nextS);
                addPutImfo(-1);
                if(pren == 1)
                    break;
                pren = 1;
            }else{
                pren = 0;
                tmp = numberPutCoo(b, b.nextS, myrandInt()%tmp+1);
                justput(&b, tmp, b.nextS);
                addPutImfo(tmp);
                if(getN(b) == 64)
                    break;
            }
        }

        addNewLinePutImfo();

        bN = getBlackN(b);
        wN = getWhiteN(b);
        if(bN>wN)
            winner = 1;
        if(bN<wN)
            winner = 2;
        if(bN==wN)
            winner = 0;

        fprintf(fp, "%d,", winner);
        readPutImfo();
        for(j=0; j<100; j++){
            tmp = getPutImfo(j);
            if(tmp == -2)
                break;
            fprintf(fp, "%d,", tmp);
        }
        fprintf(fp, "\n");

    }

    fclose(fp);
    return 0;
}