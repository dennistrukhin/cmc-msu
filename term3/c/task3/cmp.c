#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include "lib.h"

void compare(char * path1, char * path2)
{
    FILE * f1, * f2;
    ssize_t read1, read2;
    char * line1, * line2;
    size_t len1, len2;
    int row = 0, col = 0;
    fprintf(stdout, "Comparing %s with %s\n", path1, path2);
    f1 = fopen(path1, "r");
    if (f1 == NULL) {
        fprintf(stderr, "Error opening %s", path1);
    }
    f2 = fopen(path2, "r");
    if (f2 == NULL) {
        fprintf(stderr, "Error opening %s", path2);
    }
    while (1)
    {
        read1 = getline(&line1, &len1, f1);
        read2 = getline(&line2, &len2, f2);
        if (read1 == -1 || read2 == -1)
        {
            break;
        }
        ++row; // Считаем строки с 1, а не с 0, так как в редакторах/IDE они пронумерованы с 1, так удобнее
        while (col < len1 && col < len2 && (line1[col] != '\n' || line2[col] != '\n'))
        {
            if (line1[col] != line2[col])
            {
                fprintf(stdout, "First diff is in row %d col %d\n", row, col);
                exit(0);
            }
            ++col;
        }
    }
    fprintf(stdout, "Files are identical\n");
}

int main(int argc, char * argv[])
{
    char * path1;
    char * path2;
    if (argc < 3)
    {
        fprintf(stderr, "Paths to two files should be provided");
        return  1;
    }
    path1 = abs_path(argv[1]);
    path2 = abs_path(argv[2]);
    if (access(path1, F_OK) == -1)
    {
        fprintf(stderr, "First file does not exist");
        return 1;
    }
    if (access(path2, F_OK) == -1)
    {
        fprintf(stderr, "Second file does not exist");
        return 1;
    }
    compare(path1, path2);
}