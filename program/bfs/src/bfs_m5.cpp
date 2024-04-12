#include <algorithm>
#include <cstring>
#include <fstream>
#include <iostream>
#include <vector>
#include <queue>
#include "../../../include/gem5/m5ops.h"

using namespace std;

//  User guide
//  $ bfs.elf true/false 矩阵路径/名称
//  true/false 表示是否需要会进行多次迭代，迭代次数为 kernel_iter_times
//  Example : ./bfs.elf true matrices/simple_test_csr.mtx

//  该程序将会记录每一个节点的深度，开始时会随机挑选一个出度非零
//  的节点作为起点，最终输出为每一个节点的深度。

#define cache_size 1048576
#define kernel_iter_times 1

int row, col, nnz, depth = 0;
int temp_row, temp_column;
double temp_value;
int start_point;

int *const out_degree = (int *)0x80000000;
int *const result = (int *)0x90000000;
int *const col_idx = (int *)0xa0000000;
int *const row_ptr = (int *)0xb0000000;
bool *const vis = (bool *)0xc0000000;
int *const bfs_queue = (int *)0xd0000000;
int queue_start_ptr = 0, queue_end_ptr = 1;
// queue<int> * const bfs_queue = (queue<int> *)0xd0000000;

vector<int> row_vec[5000000];

double cache_flush[cache_size];

void handle_error()
{
    cout << "Error in loading data." << endl;
    exit(0);
}

void read_data(string route)
{
    string file_route, file_line;
    bool data_clean = false; // 是否已经去除注释

    file_route = route;
    ifstream ifs(file_route);
    if (!ifs)
        cout << "Error in reading data!" << endl;

    while (!data_clean)
    {
        streampos pos = ifs.tellg();
        getline(ifs, file_line);
        if (file_line[0] == '%')
            continue;
        else
        {
            ifs.seekg(pos, ios::beg);
            data_clean = true;
        }
    }

    if (ifs)
        ifs >> row >> col >> nnz;
    else
        handle_error();

    // out_degree = new int[row]();
    // result = new int[row]();
    // col_idx = new int[nnz]();
    // row_ptr = new int[row + 1]();
    // vis = new bool[row]();
    // row_vec = new vector<int>[row]();

    for (int i = 0; i < nnz; i++)
    {
        ifs >> temp_row >> temp_column >> temp_value;
        if (temp_row == temp_column)
            continue;
        row_vec[temp_row - 1].push_back(temp_column - 1);
        out_degree[temp_row - 1]++;
    }

    int temp = 0;
    for (int i = 0; i < row; i++)
    {
        sort(row_vec[i].begin(), row_vec[i].end());
        for (int j = 0; j < row_vec[i].size(); j++)
        {
            col_idx[temp++] = row_vec[i][j];
        }
        row_ptr[i + 1] += row_vec[i].size();
        row_ptr[i + 1] += row_ptr[i];
    }
    for (int i = 0; i < row; i++)
    {
        result[i] = -1;
        vis[i] = false;
    }
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
    if (depth <= 0)
        cout << "Invalid depth ( depth <= 0 )" << endl;
    if (queue_start_ptr >= queue_end_ptr)
        return;
    int pos = bfs_queue[queue_start_ptr++];
    for (int i = row_ptr[pos]; i < row_ptr[pos + 1]; i++)
    {
        if (!vis[col_idx[i]])
        {
            bfs_queue[queue_end_ptr++] = col_idx[i];
            result[col_idx[i]] = depth;
            vis[col_idx[i]] = true;
        }
    }
    BFS_kernel(depth + 1);
}

void print_BFS()
{
    printf("start point is NO.%d\n", start_point + 1);
    // for (int i = 0; i < row; i++)
    // {
    //     printf("depth for NO.%d = %d\n", i + 1, result[i]);
    // }
}

void free_mem_space()
{
    delete[] out_degree, result, col_idx, row_ptr, vis, row_vec;
}

int main(int argc, char *argv[])
{
    cout << "BFS begining!" << endl;

    read_data(string(argv[2]));

    // flush stream data and random data in 8MB l2 cache
    for (int i = 0; i < cache_size; i++)
        cache_flush[i] = 1;

    if (strcmp(argv[1], "true") == 0)
        for (int i = 0; i < kernel_iter_times; i++)
        {
            generate_start_point();
            BFS_kernel(1);
            for (int i = 0; i < row; i++)
            {
                result[i] = -1;
                vis[i] = false;
            }
        }

    generate_start_point();
    m5_checkpoint(0, 0);
    m5_reset_stats(0, 0);
    BFS_kernel(1);
    m5_exit(0);

    print_BFS();

    // free_mem_space();

    cout << "BFS finished!" << endl;

    return 0;
}