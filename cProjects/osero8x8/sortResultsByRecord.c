#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#define N 5000 //change
#define M 300

// if l1>l2
int compareByRecord(int* l1, int* l2){
    int i;
    for(i=1; i<M; i++){
        if(l1[i] > l2[i])
            return 1;
        if(l1[i] < l2[i])
            return -1;
    }
    return 0;
}

void swich(int *l, int x, int y){
    int tmp;
    tmp = l[x];
    l[x] = l[y];
    l[y] = tmp;
}

// ex ./
int main(int argc, char *argv[]){
    int v, n;
    int *order = NULL;
    int i, j, tmp;
    char *p = NULL;
    char line[M];
    int** buf = NULL;
    FILE *fp = NULL;
    char ifname[60], ofname[60];

    if(argc < 3 || sscanf(argv[1], "%d", &v) == 0 || sscanf(argv[2], "%d", &n) == 0){
        printf("failed.\n");
        return 0;
    }

    switch(v){
        case 29:
            strcpy(ifname, "datas/results29.csv");
            strcpy(ofname, "datas/results29.csv");
            break;
        case 43:
            strcpy(ifname, "datas/results43.csv");
            strcpy(ofname, "datas/results43.csv");
            break;
        case 45:
            strcpy(ifname, "datas/results45.csv");
            strcpy(ofname, "datas/results45.csv");
            break;
        default:
            printf("arg is wrong.\n");
            return 0;
            break;
    }

    order = calloc(n, sizeof(int));

    fp = fopen(ifname, "r");

    if(fp==NULL){
        printf("fail in opeing %s.\n", ifname);
        return 0;
    }


    for(i=0; i<n; i++)
        order[i]=i;

    buf = (int **)calloc(n, sizeof(int *));
    for(i=0; i<n; i++){
        buf[i] = (int *)calloc(M, sizeof(int));
    }

    for(i=0; i<n; i++){
        if(fgets(line, M, fp) == NULL)
            break;
        if((p = strtok(line, ",")) != NULL)
            buf[i][0] = atoi(p);
        else
            break;
        for(j=1; j<M; j++){
            if((p=strtok(NULL, ","))==NULL || strcmp(p, "\n") == 0)
                break;
            buf[i][j]=atoi(p);
        }
        buf[i][j]=-2;
    }

    fclose(fp);

// sort
    for(i=0; i<n-1; i++){
        tmp = i;
        for(j=i+1; j<n; j++){
            if(compareByRecord(buf[order[j]], buf[order[tmp]]) == -1)
                tmp = j;
        }
        swich(order, i, tmp);
    }

    fp = fopen(ofname, "w");
    if(fp==NULL){
        printf("fail in opeing %s.\n", ofname);
        return 0;
    }

    for(i=0; i<n; i++){
        for(j=0; j<M; j++){
            tmp = buf[order[i]][j];
            if(tmp != -2)
                fprintf(fp, "%d,", tmp);
            else{
                fprintf(fp, "\n");
                break;
            }
        }
    }

    fclose(fp);
    
    for(i=0; i<n; i++){
        free(buf[i]);
    }
    free(buf);
    free(order);

    printf("success.\n");

    return 0;
}