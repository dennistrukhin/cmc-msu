#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "lib.h"

const short int MODE_FROM_LINE = 0;
const short int MODE_LAST_N = 1;

int main(int argc, char *argv[]) {
    unsigned int i;
    long n = 10; // По умолчанию показываем 10 последних строк
    long start_line = 1;
    short int mode = MODE_LAST_N; // По умолчанию - режим последних N строк
    char * path = NULL;
    FILE * f;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;
    long line_count = 0;
    for (i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-n") == 0) {
            if (argc < i + 1) {
                // Аргумент, в котором должно быть количетсво строк, отсутствует
                return 1;
            }
            n = strtol(argv[i + 1], NULL, 10);
        } else if (strcmp(argv[i], "+n") == 0) {
            if (argc < i + 1) {
                // Аргумент, в котором должно быть количетсво строк, отсутствует
                return 1;
            }
            mode = MODE_FROM_LINE;
            n = strtol(argv[i + 1], NULL, 10);
        } else {
            path = argv[i];
        }
    }
    if (path == NULL) {
        fprintf(stderr, "Path to file should be provided");
    }
    path = abs_path(path);
    if (access(path, F_OK) == -1) {
        fprintf(stderr, "File does not exist: %s\n", path);
        return 1;
    }
    // Подсчитаем количество строк
    f = fopen(path, "r");
    if (f) {
        while (getline(&line, &len, f) > -1) {
            ++line_count;
        }
    } else {
        fprintf(stderr, "Error encountered while reading file.");
    }
    if (mode == MODE_FROM_LINE) {
        if (line_count < n) {
            // Запросили номер строки, которого нет в файле
            fprintf(stderr, "File is only %ld lines long, cannot start from %ld line", line_count, n);
            return 1;
        }
        start_line = n;
    } else {
        start_line = max(line_count - n + 1, 0);
    }
    fclose(f);

    f = fopen(path, "r");
    line_count = 0;
    while (getline(&line, &len, f) > -1) {
        ++line_count;
        if (line_count >= start_line) {
            // \n в конце формата не нужен, так как в самой строке в файле уже есть \n
            fprintf(stdout, "%s", line);
        }
    }
}