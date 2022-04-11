#ifndef BOARD_H
#define BOARD_H

#include "record.h"

typedef struct board_{
    int row[8];
    int col[8];
    int rid[11];
    int led[11];
    int nextS;
}board;

typedef int coo;

typedef int status;

coo newcoo(int, int);
char view(status);
status getStatus(board, coo);
void printBoard(board);
void printBoardImage(board);
void printBoardData(board);
board initBoard();
void changeBoard(board*, coo, status);
int available(board, coo, status);
int put(board*, coo, status);
int justput(board*, coo, status);
int allAvailable(board b, status s);
coo numberPutCoo(board b, status, int number);
coo randumPutCoo(board b, status s);
int getWhiteN(board b);
int getBlackN(board b);
int getN(board b);
int applyRecord(board* b, record r);
void randomMatch(board* b, record* r);

#define rowIndex(c) (c/8) 
#define colIndex(c) (c%8)
#define ridIndex(c) (c/8+c%8-2)
#define ledIndex(c) (c%8-c/8+5)

#endif