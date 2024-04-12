#include <algorithm>
#include <cstring>
#include <fstream>
#include <iostream>
#include <vector>
#include <queue>

using namespace std;

//  User guide
//  $ bfs.elf true/false 矩阵路径/名称
//  true/false 表示是否需要会进行多次迭代，迭代次数为 kernel_iter_times
//  Example : ./bfs.elf true matrices/simple_test_csr.mtx

//  该程序将会记录每一个节点的深度，开始时会随机挑选一个出度非零
//  的节点作为起点，最终输出为每一个节点的深度。

#define cache_size 1048576
#define kernel_iter_times 1000

int row, col, nnz, depth = 0;
int temp_row, temp_column;
double temp_value;
int *out_degree, *result, *col_idx, *row_ptr;
bool *vis;
int start_point;

vector<int> *row_vec;
queue<int> bfs_queue;

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

    out_degree = new int[row]();
    result = new int[row]();
    col_idx = new int[nnz]();
    row_ptr = new int[row + 1]();
    vis = new bool[row]();
    row_vec = new vector<int>[row]();

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

void BFS_kernel(int depth)
{
    if (depth < 0)
        cout << "Invalid depth ( depth < 0 )" << endl;
    if (!depth)
    {
        do
            start_point = rand() % row;
        while (!out_degree[start_point]);
        bfs_queue.push(start_point);
        result[start_point] = 0;
        vis[start_point] = true;
        BFS_kernel(1);
    }
    if (bfs_queue.empty())
        return;
    int pos = bfs_queue.front();
    bfs_queue.pop();
    for (int i = row_ptr[pos]; i < row_ptr[pos + 1]; i++)
    {

        if (!vis[col_idx[i]])
        {
            bfs_queue.push(col_idx[i]);
            result[col_idx[i]] = depth;
            vis[col_idx[i]] = true;
        }
    }
    BFS_kernel(depth + 1);
}

void print_BFS()
{
    printf("start point is NO.%d\n", start_point + 1);
    for (int i = 0; i < row; i++)
    {
        printf("depth for NO.%d = %d\n", i + 1, result[i]);
    }
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
            BFS_kernel(0);
            for (int i = 0; i < row; i++)
            {
                result[i] = -1;
                vis[i] = false;
            }
        }

    BFS_kernel(0);

    // print_BFS();

    free_mem_space();

    cout << "BFS finished!" << endl;

    return 0;
}