#ifndef TMPRECORD_H
#define TMPRECORD_H
#define FTMPRECORD "datas/tmpRecord.csv"
#define TMPRECORDMAX 100
#define TMPRECORDLINEMAX 300


int readTmprecord();
int getTmprecord(int n);
int addTmpRecord(int x);
int clearTmpRecord();

#endif