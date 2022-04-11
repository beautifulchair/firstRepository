#include <stdio.h>
#include "hs/otherfunc.h"
#include "hs/record.h"

int addRecord(record* r, int x){
    if(x<-1 || x>63)
        return 0;
    r->l[r->n] = x;
    r->n++;
    return 1;
}

int getRecord(record r, int n){
    if(n<0 || n>=RECORDMAX){
        return -3;
    }
    return r.l[n];
}

void initRecord(record* r){
    int i;
    for(i=0; i<RECORDMAX; i++)
        r->l[i] = -2;
    r->n = 0;
}

void printRecord(record r){
    int i;
    if(r.n == 0){
        printf("empty.");
    }
    for(i=0; i<r.n; i++){
        printf("%d, ", r.l[i]);
    }
    printf("\n");
}