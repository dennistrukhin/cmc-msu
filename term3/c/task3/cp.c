#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <unistd.h>
#include <sys/stat.h>
#include <dirent.h>
#include <fcntl.h>

char * concat(const char *s1, const char *s2)
{
    char * result = malloc(strlen(s1) + strlen(s2) + 1);
    strcpy(result, s1);
    strcat(result, s2);
    return result;
}


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
    struct stat fileStat;
    DIR * d;
    struct dirent * dir;
    stat(path_from, &fileStat);
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


char * get_current_directory()
{
    char * cwd;
    cwd = getcwd(0, 0);
    return cwd;
}


char * abs_path(char * path)
{
    return concat(concat(get_current_directory(), "/"), path);
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
    if (*path_from != '/')
    {
        path_from = abs_path(path_from);
    }
    if (*path_to != '/')
    {
        path_to = abs_path(path_to);
    }
    if (access(path_from, F_OK) == -1)
    {
        fprintf(stderr, "Source path does not exist");
        return  1;
    }
    if (access(path_to, F_OK) != -1)
    {
        fprintf(stderr, "Destination path already exists");
        return  1;
    }
    copy(path_from, path_to);
}