#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "hs/otherfunc.h"

int threePow(int n){
    int ans=1;
    for(int i=0; i<n; i++)
        ans*=3;
    return ans;
}

int convert4to3(int n){
    int ans=0;
    for(int i=0; i<8; i++){
        ans += (threePow(i) * ((n >> (2*i)) % 4));
    }
    return ans;
}

void printArrayInt(int a[], int n){
    for(int i=0; i<n; i++)
        printf("%d: %d, ", i, a[i]);
    printf("\n");
}

int randInt(int n){
    int r;
    if(n<=0)
        return -1;
    srand((unsigned int) time(NULL));
    r = rand();
    return (r%n)+1;
}

int* randInts(int num){
    int* ip;
    if(num <= 0)
        return NULL;
    ip = calloc(num, sizeof(int));
    srand((unsigned int) time(NULL));
    for(int i=0; i<num; i++){
        ip[i] = rand();
    }
    return ip;
}

int myrandInt(){
    char buf[20];
    int n, r;
    FILE *fp;
    fp = fopen("datas/oneInt.csv", "r");
    if(fp == NULL){
        printf("fail in myrandInt.\n");
        return 1;
    }
    fgets(buf, 20, fp);
    fclose(fp);
    n = atoi(buf);
    srand((unsigned int)n);
    r = rand();
    fp = fopen("datas/oneInt.csv", "w");
    if(fp == NULL){
        printf("fail in myrandInt.\n");
        return r;
    }
    fprintf(fp, "%d,", r);
    fclose(fp);
    // pint(r);
    return r;
}