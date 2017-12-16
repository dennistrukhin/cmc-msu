#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <unistd.h>
#include <sys/stat.h>
#include <dirent.h>
#include <fcntl.h>
#include "lib.h"


void copy_file(char * path_from, char * path_to)
{
    int src_fd, dst_fd;
    size_t n;
    ssize_t err;
    unsigned char buffer[4096];
    src_fd = open(path_from, O_RDONLY);
    dst_fd = open(path_to, O_CREAT | O_WRONLY, 0644);

    while (1) {
        err = read(src_fd, buffer, 4096);
        if (err == -1) {
            printf("Error reading file.\n");
            exit(1);
        }
        n = (size_t)err;

        if (err == 0) break;

        err = (int)write(dst_fd, buffer, n);
        if (err == -1) {
            printf("Error writing to file.\n");
            exit(1);
        }
    }

    close(src_fd);
    close(dst_fd);
}


void copy(char * path_from, char * path_to)
{
    char * new_path_from;
    char * new_path_to;
    struct stat fileStat, fileStatTo;
    DIR * d;
    struct dirent * dir;
    stat(path_from, &fileStat);
    // Если второй файл существует и один из файлов является ссылкой на другой,
    // то пропускаем (не копируем)
    if (access(path_to, F_OK) != -1) {
        stat(path_from, &fileStatTo);
        if (fileStat.st_ino == fileStatTo.st_ino) {
            fprintf(stdout, "cp: %s and %s are identical (not copied).\n", path_from, path_to);
            return;
        }
    }
    if (S_ISDIR(fileStat.st_mode))
    {
        // Это директория, надо создать такую же
        fprintf(stderr, "Copying directory %s to %s\n", path_from, path_to);
        mkdir(path_to, 0755);
        // А теперь перебрать её содержимое и для каждого найденного элемента провести копирование
        d = opendir(path_from);
        if (d) {
            while ((dir = readdir(d)) != NULL) {
                if (strcmp(dir->d_name, ".") == 0 || strcmp(dir->d_name, "..") == 0) {
                    continue;
                }
                new_path_from = concat(concat(path_from, "/"), dir->d_name);
                new_path_to = concat(concat(path_to, "/"), dir->d_name);
                copy(
                        new_path_from,
                        new_path_to
                );
            }
        }
    }
    else
    {
        fprintf(
                stderr,
                "Copying file %s to %s\n",
                path_from,
                path_to
        );
        copy_file(path_from, path_to);
    }
}


int main(int argc, char * argv[])
{
    char * path_from;
    char * path_to;
    if (argc < 3)
    {
        fprintf(stderr, "Please provide both source and destination as arguments");
        return  1;
    }
    path_from = argv[1];
    path_to = argv[2];
    // Если пути относительные, получим из них абсолютные
    path_from = abs_path(path_from);
    path_to = abs_path(path_to);
    if (access(path_from, F_OK) == -1)
    {
        fprintf(stderr, "Source path does not exist");
        return  1;
    }
    copy(path_from, path_to);
}