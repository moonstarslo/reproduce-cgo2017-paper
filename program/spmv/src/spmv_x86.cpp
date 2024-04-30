#include <algorithm>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>

const int max_row = 40000000;
const int max_col = 40000000;
const int max_nnz = 40000000;

#define cache_size 24*1024*1024
#define TEST_NUM 1000

double cache_flush[cache_size];

int row, col, nnz;

int col_idx[max_nnz];
int row_ptr[max_row];

double val[max_nnz];
double vec[max_col];
double ret[max_row];

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
    
    printf("start mmap\n");

    //初始化输入矩阵，所有元素都为0，这里用的是COO格式
    memset(mat,0, sizeof(mat));
    //初始化输入向量，所有元素都为0
    memset(vec,0, sizeof(vec));
    //初始化存结果的向量，各个分量都为0
    memset(ret,0,sizeof(ret));
    //初始化存前i-1行非零元素的向量，各个分量都为0
    memset(row_ptr,0,sizeof(row_ptr));
    //初始化存矩阵元素列索引的向量，各个分量都为0
    memset(col_idx,0,sizeof(col_idx));
    //初始化存矩阵元素值的向量，各个分量都为0
    memset(val,0,sizeof(val));

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

    clock_t time1, time2;

    time1 = clock();
    for(int i=0;i<TEST_NUM;i++){
        mul(ret, vec, val, row_ptr, col_idx);
    }
    time2 = clock();

    FILE *fp1 = fopen(argv[3], "a");
    fprintf(fp1,"matrix name: %s   ", argv[2]);
    fprintf(fp1,"execution time: %f ms\n", float(time2-time1)*1000/(TEST_NUM*CLOCKS_PER_SEC));
    fclose(fp1);

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
