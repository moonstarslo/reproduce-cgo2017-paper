//#include <iostream>
//#include <algorithm>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "../../../include/gem5/m5ops.h"

const int max_row = 5000000;
const int max_col = 5000000;
const int max_nnz = 10000000;

int row, col, nnz;

//int col_idx[max_nnz];
//int row_ptr[max_row];
//
//double val[max_nnz];
//double vec[max_col];
//double ret[max_row];
//
//int col_idx_fake[max_nnz];
//double val_fake[max_nnz];
//double vec_fake[max_col];

// _Float32 val[max_nnz];
// _Float32 vec[max_col];
// _Float32 ret[max_row];

// user guide
// 可执行文件 true/false 矩阵路径名称
// true/false 表示是否需要预热cache，分支预测器

typedef struct {
        int r;
        int c;
        double val;
}COO;

COO mat[max_nnz];

void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx, int *col_idx_fake, double *vec_fake) 
{
        int last_row, this_row;
        //按行分别计算结果向量中的不同分量
        for (int i = 0; i < row; i++) {
            last_row = row_ptr[i]; 
            this_row = row_ptr[i+1];
            for (int j = last_row; j < this_row; j++) {
                ret[i] += val[j] * vec[col_idx[j]] + vec_fake[col_idx_fake[j]];
                // printf("ret[i](%f\n)=ret[i]+(%f)*(%f)\n",ret[i],val[j],vec[col_idx[j]]);
            }
        }
}

int main(int argc,char *argv[]) 
{    

    int * const col_idx = (int *)0x80000000;
    int * const row_ptr = (int *)0x90000000;

    double * const val = (double *)0xa0000000;
    double * const ret = (double *)0xb0000000;
    double * const vec = (double *)0xc0000000;

    //int col_idx_fake[max_nnz];
    int * const col_idx_fake = (int *)0x84000000;
    //double vec_fake[max_col];
    double * const vec_fake = (double *)0xc4000000;

    // 命令行传入参数，表示矩阵位置
    FILE *fp = fopen(argv[2], "r");    

    if(fp == NULL){
        printf("null file pointer!\n");
        exit(0);
    }else{
        printf("文件路径为");
        printf("%s\n",argv[2]);
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
        //这里减1是为了后面向量矩阵是从0开始检索
        // mat[i].r--;
        // mat[i].c--;
    }
    fclose(fp);

    // // ***** 输入向量，通过文件的方式
    // fp = fopen("../../../se_files/spmv/data/simple/vec.mtx", "r");
    // if(fp == NULL){
    //     printf("null file pointer!\n");
    //     exit(0);
    // }

    // fscanf(fp,"%d", &col);
    // for (int i = 1; i < col+1; i++){
    //     fscanf(fp,"%lf", &vec[i]);
    // }

    // fclose(fp);

    // ***** 输入向量，通过赋值的方式
    for(int i=1;i<col+1;i++)
    {
        vec[i] = 1;
        vec_fake[i] = 1;
    }

    for(int i = 0;i < nnz;i++ ){
        int row_num;
        val[i] = mat[i].val;
        col_idx[i] = mat[i].c;
        col_idx_fake[i] = i % 2 ? (mat[i].c / 2) : (mat[i].c / 2 + col / 2);
        row_num = mat[i].r;
        row_ptr[row_num] +=1;
    }

    //for (int i = 0; i < nnz; i++) {
    //    col_idx_fake[i] = rand() % max_col;
    //}

    for(int i = 1;i < row +1;i++ ){
        row_ptr[i] +=row_ptr[i-1]; 
    }

    m5_checkpoint(0,0);
    //如果为true，则进行预热cache及bp等
    if (strcmp(argv[1],"true")==0){
        printf("the processor is warmed\n");
        for (int i=0;i<2;i++){
            mul(ret, vec, val, row_ptr, col_idx, col_idx_fake, vec_fake);
        }
    }

    m5_reset_stats(0,0);
    mul(ret, vec, val, row_ptr, col_idx, col_idx_fake, vec_fake);
    m5_dump_stats(0,0);

    // // 命令行传入参数，表示输出矩阵位置
    // if ( argc == 4){
    // FILE *fp_out = fopen(argv[3], "w");

    //     if (fp_out == NULL){
    //         printf("null file pointer for output file!\n");
    //         exit(0);
    //     }else{
    //         printf("输出文件路径为");
    //         printf("%s\n",argv[3]);
    //         for (int  i = 0; i < row; ++i){
    //             // printf("%lf\n", ret[i]);
    //             fprintf(fp_out," %lf\n",ret[i]);
    //         }
    //     }
    //     fclose(fp_out);
    // }
    // m5_exit(0);
    // printf("计算结果:\n");
    // for (int  i = 0; i < row; ++i)
    //     printf("%lf\n", ret[i]);

    // m5_exit(0);

    return 0;
}
