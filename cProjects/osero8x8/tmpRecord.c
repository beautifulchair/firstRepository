#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hs/tmpRecord.h"

static int tmprecord[TMPRECORDMAX];

int readTmprecord(){
    FILE *fp = NULL;
    char *p = NULL;
    int i;

    for(i=0; i<TMPRECORDMAX; i++)
        tmprecord[i] = -2;

    fp = fopen(FTMPRECORD, "r");
    if(fp == NULL){
        printf("failed in open %s.\n", FTMPRECORD);
        return 0;
    }

    fgets(p, TMPRECORDLINEMAX, fp);
    tmprecord[0] = atoi(p);
    i = 1;
    while(1){
        p = strtok(p, ",");
        if(p == NULL)
            break;
        tmprecord[i] = atoi(p);
        i++;
    }

    fclose(fp);
    return 1;
}

int getTmprecord(int n){
    if(n<0 || n>=TMPRECORDMAX)
        return -3;
    return tmprecord[n];
}

int addTmpRecord(int x){
    FILE *fp = NULL;

    fp = fopen(FTMPRECORD, "a");
    if(fp == NULL){
        printf("failed in open %s.\n", FTMPRECORD);
        return 0;
    }
    fprintf(fp, "%d,", x);
    fclose(fp);
    return 1;
}

int clearTmprecord(){
    FILE *fp = NULL;

    fp = fopen(FTMPRECORD, "w");
    if(fp == NULL){
        printf("failed in open %s.\n", FTMPRECORD);
        return 0;
    }
    fclose(fp);
    return 1;
}