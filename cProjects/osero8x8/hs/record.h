#ifndef RECORD_H
#define RECORD_H
#define RECORDMAX 100

typedef struct _record{
    int n;
    int l[RECORDMAX];
}record;

int addRecord(record* r, int x);
int getRecord(record r, int n);
void initRecord(record* r);
void printRecord(record r);

#endif