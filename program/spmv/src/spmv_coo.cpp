#include <iostream>
#include <algorithm>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "../../../include/gem5/m5ops.h"

const int max_row = 150;
const int max_col = 150;
const int max_nnz = 1500;

int row, col, nnz;
int row_index[max_nnz];
int col_index[max_nnz];

double value[max_nnz];
double mv[max_row];
double ret[max_row];

typedef struct {
        int r;
        int c;
        double val;
}COO;

COO mat[max_nnz];

int main()
{
    //初始化输入矩阵，所有元素都为0，这里用的是COO格式
    memset(mat,0, sizeof(mat));
    //初始化输入向量，所有元素都为0
    memset(mv,0, sizeof(mv));
    //初始化存结果的向量，各个分量都为0
    memset(ret,0,sizeof(ret));

    // 输入矩阵
    FILE *fp = fopen("../../../se_files/spmv/data/test/arc130/arc130.mtx", "r");    
    // FILE *fp = fopen("../../../se_files/spmv/data/test/b1_ss/b1_ss.mtx", "r");    
    // FILE *fp = fopen("../../../se_files/spmv/data/mat_coo.mtx", "r");    
    if(fp == NULL){
        printf("null file pointer!\n");
        exit(0);
    }

    fscanf(fp,"%d%d%d", &row,&col,&nnz);
    printf("稀疏矩阵中，行数为%d，列数为%d，非零元素共有%d\n",row,col,nnz);
    if((nnz > max_nnz)||(row > max_row)||(col > max_col))
    {
        printf("nnz/col/row中有一个设置大于预设值！\n");
        exit(0);
    }
    for (int i = 0; i < nnz; i++){
        fscanf(fp,"%d%d%lf", &mat[i].r,&mat[i].c, &mat[i].val);
        mat[i].r--;
        mat[i].c--;
    }
    printf("输入矩阵:\n");
    for (int i = 0; i < nnz; i++){
        printf("%d %d %lf\n", mat[i].r,mat[i].c, mat[i].val);
    }

    fclose(fp);

    // // 输入向量
    // fp = fopen("../../../se_files/spmv/data/vec.mtx", "r");
    // if(fp == NULL){
    //     printf("null file pointer!\n");
    //     exit(0);
    // }

    // fscanf(fp,"%d", &col);
    // for (int i = 0; i < col; i++){
    //     fscanf(fp,"%lf", &mv[i]);
    // }
    // printf("输入向量:\n");
    // for (int i = 0; i < col; i++){
    //         printf("%lf\n", mv[i]);
    // }
    // fclose(fp);
        // ***** 输入向量，通过赋值的方式
    for(int i=0;i<col;i++)
    {
        mv[i] = 1;
    }

    printf("输入向量:\n");
    for (int i = 0; i < col; i++){
            printf("%lf\n", mv[i]);
    }

    for(int i=0;i<nnz;i++)
    {
        row_index[i] = mat[i].r;
        col_index[i] = mat[i].c;
        value[i] =  mat[i].val;
    }

    m5_reset_stats(0,0);
    for(int i=0;i<nnz;i++){
        ret[row_index[i]] = ret[row_index[i]] + value[i] * mv[col_index[i]];
    }
    printf("输出结果:\n");
    for (int  i = 0; i < row; ++i)
    printf("%lf\n", ret[i]);
    m5_exit(0);    

    return 0;
}
