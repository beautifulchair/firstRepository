#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hs/board.h"
#include "hs/putImfo.h"
#include "hs/otherfunc.h"
#include "hs/available.h"

// ./r 10000 45
int main(int argc, char* argv[]){
    int n, c;
    int ii, tmp, counter, pren;
    int bN, wN, winner;
    char fname[30];
    FILE *fp;
    board b;
    // int* randoms = randInts(100);
    readAvailable();

    if(argc < 3 || (sscanf(argv[1], "%d", &n) == 0) || (sscanf(argv[2], "%d", &c) == 0))
        return 0;

    switch(c){
        case 29:
            strcpy(fname, "datas/results29.csv"); break;
        case 45:
            strcpy(fname, "datas/results45.csv"); break;
        case 43:
            strcpy(fname, "datas/results43.csv"); break;
        default:
            printf("failed.\n"); return 0;
    }

    fp=fopen(fname, "a");
    if(fp==NULL){
        printf("fault in open %s.\n", fname);
        return -1;
    }

    for(ii=0; ii<n; ii++){
        b = initBoard();
        pren = 0;
        addNewLinePutImfo();
        justput(&b, 44, b.nextS);
        addPutImfo(44);
        justput(&b, c, b.nextS);
        addPutImfo(c);
        // for(counter=2; counter<argc; counter++){
        //     if(sscanf(argv[counter], "%d", &tmp)==0 || tmp>63){
        //         printf("failed.\n");
        //         return 0;
        //     }
        //     justput(&b, tmp, b.nextS);
        //     addPutImfo(tmp);
        // }

        // counter = 0;
        while(1){
            // pint(ii)
            // pint(counter)
            tmp = allAvailable(b, b.nextS);
            if(getN(b) == 64){
                // printf("board is full.\n");
                break;
            }
            if(tmp == 0){
                if(pren == 1){
                    // printf("both cannot put.\n");
                    break;
                }
                pren = 1;
                addPutImfo(-1);
                justput(&b, -1, b.nextS);
            }else{
                pren = 0;
                // tmp = numberPutCoo(b, b.nextS, randoms[counter]%tmp+1);
                tmp = numberPutCoo(b, b.nextS, myrandInt()%tmp+1);
                addPutImfo(tmp);
                justput(&b, tmp, b.nextS);
                // counter++;
            }
        }

        // printBoardImage(b);
        // printf("###############################\n");
        bN = getBlackN(b);
        wN = getWhiteN(b);
        winner = (bN<wN) + 1;
        if(bN==wN) winner = 0;
        // printf("black: %d, white: %d\n", getBlackN(b), getWhiteN(b));
        // printf("###############################\n");

        fprintf(fp, "%d,", winner);
        readPutImfo();
        for(counter=0; counter<100; counter++){
            tmp = getPutImfo(counter);
            if(tmp != -2)
                fprintf(fp, "%d,", getPutImfo(counter));
            else
                break;
        }
        fprintf(fp, "\n");
        // printf("witing in result.csv sucsess.\n");
    }
    fclose(fp);
    return 0;
}