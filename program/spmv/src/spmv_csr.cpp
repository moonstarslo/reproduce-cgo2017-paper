// #include <algorithm>
// #include <time.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
// #include <sys/mman.h>
#include "../../../../gem5_bfs/include/gem5/m5ops.h"

const int max_row = 5000000;
const int max_col = 5000000;
const int max_nnz = 10000000;

#define cache_size 65536

double cache_flush[cache_size];

// const int max_row = 200000;
// const int max_col = 200000;
// const int max_nnz = 1000000;

int row, col, nnz;

// volatile int * const col_idx = (int *)0x110000;
// volatile int * const row_ptr = (int *)0x220000;

// volatile double * const val = (double *)0x330000;
// volatile double * const vec = (double *)0x440000;
// volatile double * const ret = (double *)0x550000;

// int col_idx[max_nnz];
// int row_ptr[max_row];

// double val[max_nnz];
// double vec[max_col];
// double ret[max_row];

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

void  mul(double *ret, double *vec, double *val,int *row_ptr, int *col_idx) 
{
        int last_row, this_row;
        //按行分别计算结果向量中的不同分量
        for (int i = 0; i < row; i++) {
            last_row = row_ptr[i]; 
            this_row = row_ptr[i+1];
            for (int j = last_row; j < this_row; j++) {
                ret[i] += val[j] * vec[col_idx[j]];
                // printf("ret[i](%f\n)=ret[i]+(%f)*(%f)\n",ret[i],val[j],vec[col_idx[j]]);
            }
        }
}

int main(int argc,char *argv[]) 
{   

    int *col_addr,*row_addr;
    double *val_addr,*vec_addr,*ret_addr;
    
    printf("start mmap\n");

    // col_addr = (int *) mmap ( (int *) 0x80000000, max_nnz*sizeof(int),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0 );
    
    // printf("col_addr is %x\n",col_addr);

    // row_addr = (int *) mmap ( (int *) 0x82000000, max_row*sizeof(int),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0 );

    // printf("row_addr is %x\n",row_addr);

    // val_addr = (double *) mmap ( (double *) 0x84000000, max_nnz*sizeof(double),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0 );

    // printf("val_addr is %x\n",val_addr);

    // vec_addr = (double *) mmap ( (double *) 0x86000000, max_col*sizeof(double),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0 );

    // printf("vec_addr is %x\n",vec_addr);

    // ret_addr = (double *) mmap ( (double *) 0x88000000, max_row*sizeof(double),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0 );

    // printf("ret_addr is %x\n",ret_addr);

    // col_addr = (int *) mmap ( (int *) 0x80000000, max_nnz*sizeof(int),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS|MAP_FIXED, 0, 0 );
    
    // printf("col_addr is %x\n",col_addr);

    // row_addr = (int *) mmap ( (int *) 0x82000000, max_row*sizeof(int),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS|MAP_FIXED, 0, 0 );

    // printf("row_addr is %x\n",row_addr);

    // val_addr = (double *) mmap ( (double *) 0x84000000, max_nnz*sizeof(double),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS|MAP_FIXED, 0, 0 );

    // printf("val_addr is %x\n",val_addr);

    // vec_addr = (double *) mmap ( (double *) 0x86000000, max_col*sizeof(double),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS|MAP_FIXED, 0, 0 );

    // printf("vec_addr is %x\n",vec_addr);

    // ret_addr = (double *) mmap ( (double *) 0x88000000, max_row*sizeof(double),
    // PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS|MAP_FIXED, 0, 0 );

    // printf("ret_addr is %x\n",ret_addr);

    int * const col_idx = (int *)0x80000000;
    int * const row_ptr = (int *)0x90000000;

    double * const val = (double *)0xa0000000;
    double * const ret = (double *)0xb0000000;
    double * const vec = (double *)0xc0000000;

    //初始化输入矩阵，所有元素都为0，这里用的是COO格式
    // memset(mat,0, sizeof(mat));
    // //初始化输入向量，所有元素都为0
    // memset(vec,0, sizeof(vec));
    // //初始化存结果的向量，各个分量都为0
    // memset(ret,0,sizeof(ret));
    // //初始化存前i-1行非零元素的向量，各个分量都为0
    // memset(row_ptr,0,sizeof(row_ptr));
    // //初始化存矩阵元素列索引的向量，各个分量都为0
    // memset(col_idx,0,sizeof(col_idx));
    // //初始化存矩阵元素值的向量，各个分量都为0
    // memset(val,0,sizeof(val));

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
    }

    for(int i = 0;i < nnz;i++ ){
        int row_num;
        val[i] = mat[i].val;
        col_idx[i] = mat[i].c;
        row_num = mat[i].r;
        row_ptr[row_num] +=1;
    }

    for(int i = 1;i < row +1;i++ ){
        row_ptr[i] +=row_ptr[i-1]; 
    }

    // printf("输入矩阵:\n");
    // for (int i = 0; i < nnz; i++){
    //     printf("%d %d %lf\n", mat[i].r,mat[i].c, mat[i].val);
    // }
    // printf("输入向量:\n");
    // for (int i = 1; i < col+1; i++){
    //         printf("%lf\n", vec[i]);
    // }
    // printf("ptr矩阵为：\n");
    // for (int i = 0; i < row + 1; i++) {
    //         printf("%d\n",row_ptr[i]);
    // }

    // printf("value矩阵为：\n");
    // for(int i=0;i<nnz;i++){
    //     printf("%lf\n",val[i]);
    // }

    // printf("col_idx矩阵为：\n");
    // for(int i=0;i<nnz;i++){
    //     printf("%d\n",col_idx[i]);
    // }

    m5_checkpoint(0,0);

    // flush stream data and random data in  256kB l2 cache
    for(int i=0;i<cache_size;i++){
        cache_flush[i] = 1;
    }

    //如果为true，则进行预热cache及bp等
    if (strcmp(argv[1],"true")==0){
        printf("the processor is warmed\n");
        for (int i=0;i<2;i++){
            mul(ret, vec, val, row_ptr, col_idx);
        }
    }

    m5_reset_stats(0,0);
    mul(ret, vec, val, row_ptr, col_idx);
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
