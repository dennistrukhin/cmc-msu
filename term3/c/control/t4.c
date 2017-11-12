#include <stdio.h>

#define N 3

typedef double Matrix[N][N];

Matrix m = {1.,2.,3.,4.,5.,6.,7.,8.,9.};

void print()
{
    int i, j;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
        {
            fprintf(stderr, "%lf ", m[i][j]);
        }
        fprintf(stderr, "\n");
    }
}

void swap_diagonals(Matrix * matrix)
{
    int i;
    double buff;
    for (i = 0; i < N; i++)
    {
        buff = (*matrix)[i][i]; // Элемент основной диагонали в текущей строке
        (*matrix)[i][i] = (*matrix)[i][N - i - 1];
        (*matrix)[i][N - i - 1] = buff;
    }
}

int main()
{
    swap_diagonals(&m);
    print();
}