#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "hs/available.h"
#include "hs/board.h"
#include "hs/otherfunc.h"
#include "hs/record.h"

// ex. ./rMatch 1000 29
int main(int argc, char *argv[]){
    int n, c;
    int i, j;
    int tmp, winner, bN, wN;
    int bwin=0, wwin=0, draw=0;
    board b;
    record *rC = calloc(1, sizeof(record));
    record *r = calloc(1, sizeof(record));
    char fname[30];
    FILE *fp = NULL;

    if(argc == 1){
        readAvailable();
        initRecord(r);
        addRecord(r, 44);
        b = initBoard();
        randomMatch(&b, r);
        printRecord(*r);
        return 0;
    }

    if(argc < 3)
        return 0;

    if(sscanf(argv[1], "%d", &n)==0 || sscanf(argv[2], "%d", &c)==0)
        return 0;

    switch(c){
        case 29:
            strcpy(fname, "datas/results29.csv"); break;
        case 43:
            strcpy(fname, "datas/results43.csv"); break;
        case 45:
            strcpy(fname, "datas/results45.csv"); break;
        default:
            return 0;
    }

    initRecord(rC);
    addRecord(rC, 44);
    for(i=2; i<argc; i++){
        if(sscanf(argv[1], "%d", &tmp)==0)
            break;
        addRecord(rC, tmp);
    }

    readAvailable();
    fp = fopen(fname, "w");
    if(fp == NULL){
        printf("failed in open %s", fname);
        return 0;
    }

    for(i=0; i<n; i++){
        if(i%1000==0)
            printf("completed %d/%d.\n", i, n);
        b = initBoard();
        *r = *rC;
        applyRecord(&b, *r);

        randomMatch(&b, r);

        bN = getBlackN(b);
        wN = getWhiteN(b);
        if(bN>wN)
            {winner = 1; bwin++;}
        if(bN<wN)
            {winner = 2; wwin++;}
        if(bN==wN)
            {winner = 0; draw++;}

        fprintf(fp, "%d,", winner);
        for(j=0; j<100; j++){
            tmp = getRecord(*r, j);
            if(tmp == -2)
                break;
            fprintf(fp, "%d,", tmp);
        }
        fprintf(fp, "\n");

    }

    fclose(fp);

    printf("b: %f\n", (float)bwin/(float)n);
    printf("w: %f\n", (float)wwin/(float)n);
    printf("d: %f\n", (float)draw/(float)n);

    free(r);
    free(rC);

    return 0;
}