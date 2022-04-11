#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hs/board.h"
#include "hs/available.h"
#include "hs/otherfunc.h"
#include "hs/putImfo.h"

int main(int argc, char* argv[]){
    char inChar;
    int inNum;
    int counter;
    int tmp;
    board b = initBoard();
    if(argc>=2 && sscanf(argv[1], "%c", &inChar) != 0){
        if(inChar == 'h'){
            printf("c)clear, n)new, q)quit, d)printList, l)display, a)add, s)printN\n" 
                    "p)put, r)randamPut, j)now, b)deleteOne, y)copy, m)comment, h)help\n");
            return 0;
        }
        if(inChar == 'd'){
            readPutImfo();
            for(counter=0; counter<100; counter++){
                tmp = getPutImfo(counter);
                if(tmp != -2)
                    printf("%d ", getPutImfo(counter));
                else
                    break;
            }
            printf("\n");
            return 0;
        }
        if(inChar == 'c'){
            printf("clear putImfo.csv? y/n\n");
            scanf("%c", &inChar);
            if(inChar == 'y'){
                clearPutImfo();
                return 0;
            }else{
                printf("canceled\n");
                return 0;
            }
        }
        if(inChar == 'n'){
            printf("new line putImfo.csv? y/n\n");
            scanf("%c", &inChar);
            if(inChar == 'y'){
                addNewLinePutImfo();
                addPutImfo(44);
                return 0;
            }else{
                printf("canceled\n");
                return 0;
            }
        }
        if(inChar == 'q'){
            return 0;
        }
        if(inChar == 'l'){
            readAvailable();
            readPutImfo();
            b=initBoard();
            for(counter=0; counter<100; counter++){
                tmp=getPutImfo(counter);
                if(tmp==-2) break;
                put(&b, tmp, b.nextS);
                printBoardImage(b);
            }
            return 0;
        }
        if(inChar == 'a'){
            if(argc < 3)
                return 0;
            for(counter=2; counter<argc; counter++){
                sscanf(argv[counter], "%d", &inNum);
                if(-2<inNum && inNum<64) addPutImfo(inNum);
            }
            return 0;
        }
        // if(inChar == 'p'){
        //     sscanf(argv[2], "%d", &inNum);
        //     addPutImfo(inNum);
        //     readAvailable();
        //     readPutImfo();
        //     b=initBoard();
        //     for(counter=0; counter<36; counter++){
        //         tmp=getPutImfo(counter);
        //         if(tmp==-2) break;
        //         put(&b, tmp, b.nextS);
        //     }
        //     printBoardImage(b);
        //     return 0;
        // }
        if(inChar == 'p'){
            if(argc < 3)
                return 0;
            sscanf(argv[2], "%d", &inNum);
            readAvailable();
            readPutImfo();
            b=initBoard();
            for(counter=0; counter<100; counter++){
                tmp=getPutImfo(counter);
                if(tmp==-2) break;
                justput(&b, tmp, b.nextS);
            }
            addPutImfo(inNum);
            put(&b, inNum, b.nextS);
            printBoardImage(b);
            return 0;
        }
        if(inChar == 'b'){
            readAvailable();
            readPutImfo();
            addNewLinePutImfo();
            b=initBoard();
            for(counter=0; counter<100; counter++){
                tmp=getPutImfo(counter);
                if(getPutImfo(counter+1) != -2){
                    addPutImfo(getPutImfo(counter));
                    justput(&b, tmp, b.nextS);
                }
                else
                    break;
            }
            printBoardImage(b);
            return 0;
        }
        if(inChar == 'y'){
            readPutImfo();
            addNewLinePutImfo();
            for(counter=0; counter<100; counter++){
                if(getPutImfo(counter) != -2)
                    addPutImfo(getPutImfo(counter));
                else
                    break;
            }
            return 0;
        }
        if(inChar == 'm'){
            if(argc < 3)
                return 0;
            printf("new comment putImfo.csv? y/n\n");
            scanf("%c", &inChar);
            if(inChar == 'y'){
                addStringPutImfo(argv[2]);
                return 0;
            }else{
                printf("canceled\n");
                return 0;
            }
        }
        if(inChar == 'j'){
            readAvailable();
            readPutImfo();
            b=initBoard();
            for(counter=0; counter<100; counter++){
                tmp=getPutImfo(counter);
                if(tmp==-2) break;
                justput(&b, tmp, b.nextS);
            }
            printBoardImage(b);
            return 0;
        }
        if(inChar == 'r'){
            readAvailable();
            readPutImfo();
            b=initBoard();
            for(counter=0; counter<100; counter++){
                tmp=getPutImfo(counter);
                if(tmp==-2) break;
                justput(&b, tmp, b.nextS);
            }
            tmp = randumPutCoo(b, b.nextS);
            addPutImfo(tmp);
            put(&b, tmp, b.nextS);
            printBoardImage(b);
            return 0;
        }
        if(inChar == 's'){
            readAvailable();
            readPutImfo();
            b=initBoard();
            for(counter=0; counter<100; counter++){
                tmp=getPutImfo(counter);
                if(tmp==-2) break;
                justput(&b, tmp, b.nextS);
            }
            printf("black: %d, white: %d\n", getBlackN(b), getWhiteN(b));
        }
        if(inChar == 'v'){
            if(argc < 3)
                return 0;
            sscanf(argv[2], "%d", &inNum);
            FILE *fp;
            fp=fopen("datas/results.csv", "a");
            if(fp==NULL){
                printf("fault in open result.csv.\n");
                return -1;
            }
            fprintf(fp, "%d,", inNum);
            readPutImfo();
            for(counter=0; counter<100; counter++){
                tmp = getPutImfo(counter);
                if(tmp != -2)
                    fprintf(fp, "%d,", getPutImfo(counter));
                else
                    break;
            }
            fprintf(fp, "\n");
            fclose(fp);
            return 0;
        }
    }

    return 0;
}