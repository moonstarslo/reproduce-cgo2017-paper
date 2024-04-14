#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include "../../../../gem5_bfs/include/gem5/m5ops.h"

//  User guide
//  $ bfs.elf true/false 矩阵路径/名称
//  true/false 表示是否需要会进行多次迭代，迭代次数为 kernel_iter_times
//  Example : ./bfs.elf true matrices/simple_test_csr.mtx

//  该程序将会记录每一个节点的深度，开始时会随机挑选一个出度非零
//  的节点作为起点，最终输出为每一个节点的深度。

#define cache_size 1048576
#define max_num 10000000
#define kernel_iter_times 1

int row, col, nnz, depth = 0;
int temp_row, temp_column;
double temp_value;
int start_point;

// int *const out_degree = (int *)0x80000000;
// int *const result = (int *)0x90000000;
// int *const row_ptr = (int *)0xa0000000;
// int *const col_idx = (int *)0xb0000000;
// bool *const vis = (bool *)0xc0000000;
// int *const bfs_queue = (int *)0xd0000000;
// double *const value = (double *)0xe0000000;

int out_degree[max_num];
int result[max_num];
int col_idx[max_num];
int row_ptr[max_num];
bool vis[max_num];
int bfs_queue[max_num];
double value[max_num];

int queue_start_ptr = 0, queue_end_ptr = 1;
// queue<int> * const bfs_queue = (queue<int> *)0xd0000000;

// vector<int> row_vec[5000000];

double cache_flush[cache_size];

void handle_error()
{
    printf("Error in loading data.\n");
    exit(0);
}

void generate_start_point()
{
    // generate start point randomly
    int cnt = 0;
    do
    {
        start_point = rand() % row;
        cnt++;
    } while (out_degree[start_point] <= 5 && cnt <= 1e5);
    bfs_queue[0] = start_point;
    result[start_point] = 0;
    vis[start_point] = true;
    queue_start_ptr = 0;
    queue_end_ptr = 1;
}

void BFS_kernel(int depth)
{
    while(queue_start_ptr<queue_end_ptr){
        // int pos = bfs_queue[queue_start_ptr];
        for (int i = row_ptr[bfs_queue[queue_start_ptr]]; i < row_ptr[bfs_queue[queue_start_ptr] + 1]; i++)
        {
            if (!vis[col_idx[i]])
            {
                bfs_queue[queue_end_ptr++] = col_idx[i];
                // result[col_idx[i]] = depth;
                vis[col_idx[i]] = true;
            }
        }
        queue_start_ptr++;
    }
}

void print_BFS()
{
    printf("start point is NO.%d\n", start_point + 1);
    for (int i = 0; i < row; i++)
    {
        printf("depth for NO.%d = %d\n", i + 1, result[i]);
    }
}

int main(int argc, char *argv[])
{
    printf("BFS begining!\n");

    FILE *fp = fopen(argv[2], "r");

    if (fp == NULL)
    {
        printf("null file pointer!\n");
        exit(0);
    }
    else
    {
        printf("文件路径为");
        printf("%s\n", argv[2]);
    }

    fscanf(fp, "%d%d%d", &row, &col, &nnz);
    printf("稀疏矩阵中，行数为%d，列数为%d，非零元素共有%d\n", row, col, nnz);
    for (int i = 0; i < nnz; i++)
    {
        int row_num;
        fscanf(fp, "%d%d%lf", &row_num, &col_idx[i], &value[i]);
        col_idx[i]--;
        row_ptr[row_num--]++;
        out_degree[row_num]++;
    }
    for (int i = 0; i < row; i++)
    {
        row_ptr[i + 1] += row_ptr[i];
        result[i] = -1;
        vis[i] = false;
    }
    fclose(fp);

    // // flush stream data and random data in 8MB l2 cache
    // for (int i = 0; i < cache_size; i++)
    //     cache_flush[i] = 1;

    m5_checkpoint(0, 0);

    generate_start_point();

    if (strcmp(argv[1], "true") == 0)
        for (int i = 0; i < kernel_iter_times; i++)
        {
            BFS_kernel(1);
            for (int i = 0; i < row; i++)
            {
                vis[i] = false;
            }
            vis[start_point] = true;
            queue_start_ptr = 0;
            queue_end_ptr = 1;
        }

    m5_reset_stats(0, 0);
    BFS_kernel(1);
    m5_exit(0);

    // print_BFS();

    // free_mem_space();

    printf("BFS finished!\n");

    return 0;
}