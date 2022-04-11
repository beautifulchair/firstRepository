#include <stdio.h>
#include <string.h>
#define SIZE 1000

int main(int argc, char* argv[]){
    int count;
    char fname[100];
    char line[SIZE];
    FILE *fp = NULL;

    if(argc == 1){
        printf("failed.\n");
        return 0;
    }

    strcpy(fname, argv[1]);

    fp = fopen(fname, "r");
    if(fp == NULL){
        printf("failed open %s.\n", fname);
        return 0;
    }

    count = 0;
    while(fgets(line, SIZE, fp) != NULL)
        count++;
        
    printf("%s...%d\n", fname, count);
    fclose(fp);
    return 0;
}