#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "hs/board.h"
#include "hs/available.h"  
#include "hs/otherfunc.h"
#include "hs/putImfo.h"
#define max(x, y) ((x>=y) ? x : y)
#define min(x, y) ((x<=y) ? x : y)

static int availables[64];

coo newcoo(int x, int y){
    return x+y*8;
}

status getStatus(board b, coo c){
    return (b.row[rowIndex(c)] >> colIndex(c)*2) & 3;
}

char view(status x){
    switch (x){
    case 0:
        return '_'; break;
    case 1:
        return 'x'; break;
    case 2:
        return 'o'; break;
    case 3:
        return '*'; break;
    default:
        break;
    }
    return '?';
}

void printBoardImage(board b){
    printf("  _ _ _ _ _ _ _ _\n");
    for(int r=0; r<8; r++){
        printf("%d|", r);
        for(int c=0; c<8; c++){
            printf("%c|", view(getStatus(b, newcoo(c,r))));
        }
        printf("\n");
    }
    printf("  0 1 2 3 4 5 6 7\n");
}

void printBoardData(board b){
    printf("row: "); for(int i=0; i<8; i++) printf("%d, ", b.row[i]); printf("\n");
    printf("col: "); for(int i=0; i<8; i++) printf("%d, ", b.col[i]); printf("\n");
    printf("rid: "); for(int i=0; i<11; i++) printf("%d, ", b.rid[i]); printf("\n");
    printf("led: "); for(int i=0; i<11; i++) printf("%d, ", b.led[i]); printf("\n");
    printf("next: %d", b.nextS);
    printf("\n");
}

void printBoard(board b){
    printBoardImage(b);
    printBoardData(b);
}

board initBoard(){
    board new;
    for(int i=0; i<8; i++){
        new.row[i]=0; new.col[i]=0; new.rid[i]=0; new.led[i]=0;
    }
    new.rid[8]=0; new.led[8]=0;
    new.rid[9]=0; new.led[9]=0;
    new.rid[10]=0; new.led[10]=0;
    changeBoard(&new, newcoo(3, 3), 2);
    changeBoard(&new, newcoo(4, 3), 1);
    changeBoard(&new, newcoo(3, 4), 1);
    changeBoard(&new, newcoo(4, 4), 2);
    new.nextS = 1;
    return new;
}

void changeBoard(board* b, coo c, status s){
    int tmp, x=colIndex(c), y=rowIndex(c), a=(x+y<=7)? y: (7-x), d=(x-y<=0)? x: y;
    status saveS = s;
    tmp = b->row[y];
    b->row[y] = (tmp&~(3<<x*2))|(s<<x*2);
    tmp = b->col[x];
    b->col[x] = (tmp&~(3<<y*2))|(s<<y*2);
    tmp = b->rid[x+y-2];
    b->rid[x+y-2] = (tmp&~(3<<a*2))|(s<<a*2);
    tmp = b->led[5+x-y];
    b->led[5+x-y] = (tmp&~(3<<d*2))|(s<<d*2);
    b->nextS = saveS; // nazo koreganaito okasikunaru
}

int put(board* b, coo c, status s){
    if(c==-1){
        printf("CHANGE\n");
        b->nextS = 3 - b->nextS;
        return 2;
    }
    int x=colIndex(c), y=rowIndex(c), z=ridIndex(c), w=ledIndex(c);
    int i;
    int a=(x+y<=7)? y: (7-x), d=(x-y<=0)? x: y;
    int row=b->row[y];
    int col=b->col[x];
    int rid=b->rid[z];
    int led=b->led[w];
    int rowchange=getAvailable(convertIndexAvailable(8, row, s, x));
    int colchange=getAvailable(convertIndexAvailable(8, col, s, y));
    int ridchange=getAvailable(convertIndexAvailable(8-abs(7-x-y), rid, s, a));
    int ledchange=getAvailable(convertIndexAvailable(8-abs(x-y), led, s, d));
    if(rowchange==0&&colchange==0&&ridchange==0&&ledchange==0){
        printf("PUT coo: (%d, %d), status: %d -> cannot put.\n", x, y, s);
        return 0;
    }
    if(rowchange!=0)for(i=rowchange%8; i<=rowchange/8; i++) changeBoard(b, newcoo(i, y), s);
    if(colchange!=0)for(i=colchange%8; i<=colchange/8; i++) changeBoard(b, newcoo(x, i), s);
    if(ridchange!=0)for(i=ridchange%8; i<=ridchange/8; i++) changeBoard(b, newcoo(x+a-i, y-a+i), s);
    if(ledchange!=0)for(i=ledchange%8; i<=ledchange/8; i++) changeBoard(b, newcoo(x-d+i, y-d+i), s);
    printf("PUT coo: (%d, %d), status: %d -> row: %d, col: %d, rid: %d, led: %d\n",x,y,s,rowchange,colchange, ridchange, ledchange);
    b->nextS = 3 - b->nextS;
    return 1;
}

// not print
int justput(board* b, coo c, status s){
    if(c==-1){
        b->nextS = 3 - b->nextS;
        return 2;
    }
    int x=colIndex(c), y=rowIndex(c), z=ridIndex(c), w=ledIndex(c);
    int i;
    int a=(x+y<=7)? y: (7-x), d=(x-y<=0)? x: y;
    int row=b->row[y];
    int col=b->col[x];
    int rid=b->rid[z];
    int led=b->led[w];
    int rowchange=getAvailable(convertIndexAvailable(8, row, s, x));
    int colchange=getAvailable(convertIndexAvailable(8, col, s, y));
    int ridchange=getAvailable(convertIndexAvailable(8-abs(7-x-y), rid, s, a));
    int ledchange=getAvailable(convertIndexAvailable(8-abs(x-y), led, s, d));
    if(rowchange==0&&colchange==0&&ridchange==0&&ledchange==0){
        return 0;
    }
    if(rowchange!=0)for(i=rowchange%8; i<=rowchange/8; i++) changeBoard(b, newcoo(i, y), s);
    if(colchange!=0)for(i=colchange%8; i<=colchange/8; i++) changeBoard(b, newcoo(x, i), s);
    if(ridchange!=0)for(i=ridchange%8; i<=ridchange/8; i++) changeBoard(b, newcoo(x+a-i, y-a+i), s);
    if(ledchange!=0)for(i=ledchange%8; i<=ledchange/8; i++) changeBoard(b, newcoo(x-d+i, y-d+i), s);
    b->nextS = 3 - b->nextS;
    return 1;
}

int available(board b, coo c, status s){
    int x=colIndex(c), y=rowIndex(c), a=(x+y<=7)? y: (7-x), d=(x-y<=0)? x: y;
    int row=b.row[y];
    int col=b.col[x];
    int rid=b.rid[x+y-2];
    int led=b.led[5+x-y];
    if(getStatus(b, c)) 
        return 0;
    if(getAvailable(convertIndexAvailable(8, row, s, x))!=0)
        return 1;
    if(getAvailable(convertIndexAvailable(8, col, s, y))!=0)
        return 1;
    if(abs(7-x-y)<6 && getAvailable(convertIndexAvailable(8-abs(7-x-y), rid, s, a))!=0)
        return 1;
    if(abs(x-y)<6 && getAvailable(convertIndexAvailable(8-abs(x-y), led, s, d))!=0)
        return 1;
    return 0;
}

int allAvailable(board b, status s){
    int counter = 0;
    for(int i=0; i<64; i++){
        if(available(b, i, s)){
            counter++;
            availables[i] = 1;
        }
        else
            availables[i] = 0;
    }
    return counter;
}

coo numberPutCoo(board b, status s, int number){
    int n = allAvailable(b, b.nextS);
    if(number>n)
        printf("!!erro in numberPutCoo!!\n");
    int i = -1;
    while(number>0){
        i++;
        if(availables[i])
            number--;
    }
    return i;
}

coo randumPutCoo(board b, status s){
    int n = allAvailable(b, b.nextS);
    int r = randInt(n);
    int i = -1;
    while(r>0){
        i++;
        if(availables[i])
            r--;
    }
    return i;
}

int getWhiteN(board b){
    int counter = 0;
    for(int i=0; i<64; i++){
        if(getStatus(b, i) == 2)
            counter++;
    }
    return counter;
}

int getBlackN(board b){
    int counter = 0;
    for(int i=0; i<64; i++){
        if(getStatus(b, i) == 1)
            counter++;
    }
    return counter;
}

int getN(board b){
    int counter = 0;
    for(int i=0; i<64; i++){
        if(getStatus(b, i) != 0)
            counter++;
    }
    return counter;
}

int applyRecord(board *b, record r){
    int i;
    int c;
    for(i=0; i<RECORDMAX; i++){
        c = getRecord(r, i);
        if(c == -2)
            break;
        justput(b, c, b->nextS);
    }
    return i;
}

void randomMatch(board* b, record* r){
    int tmp, flag;

    applyRecord(b, *r);
    flag = 0;
    while(1){
        tmp = allAvailable(*b, b->nextS);
        if(tmp == 0){
            justput(b, -1, b->nextS);
            addRecord(r, -1);
            if(flag == 1)
                break;
            flag = 1;
        }else{
            flag = 0;
            tmp = numberPutCoo(*b, b->nextS, myrandInt()%tmp+1);
            justput(b, tmp, b->nextS);
            addRecord(r, tmp);
            if(getN(*b) == 64)
                break;
        }
    }
}