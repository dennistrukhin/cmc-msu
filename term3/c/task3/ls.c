#include <unistd.h>
#include <stdio.h>
#include <dirent.h>
#include <memory.h>
#include <sys/stat.h>
#include <pwd.h>
#include <grp.h>
#include "lib.h"

const int ARG_LIST = 1;
const int ARG_GROUP = 2;
const int ARG_RECURSIVE = 4;


void get_linked_file(char * link_name, char original_file_name[1024])
{
    ssize_t len;
    if ((len = readlink(link_name, original_file_name, 1023)) != -1) {
        original_file_name[len] = '\0';
    }
}

void print_list(char * path, int args, int orig_path_len)
{
    DIR * d;
    struct stat fileStat, fileStat2;
    struct dirent * dir;
    struct group * grp;
    struct passwd * pwd;
    char * full_path, * full_path_2;
    char original_file_name[1024];
    d = opendir(path);
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if (strcmp(dir->d_name, ".") == 0 || strcmp(dir->d_name, "..") == 0)
            {
                continue;
            }
            full_path = concat(concat(path, "/"), dir->d_name);
            lstat(full_path, &fileStat);
            if (args & ARG_LIST) {
                fprintf(stdout, "%c", S_ISDIR(fileStat.st_mode) ? 'd' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IRUSR ? 'r' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IWUSR ? 'w' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IXUSR ? 'x' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IRGRP ? 'r' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IWGRP ? 'w' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IXGRP ? 'x' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IROTH ? 'r' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IWOTH ? 'w' : '-');
                fprintf(stdout, "%c", fileStat.st_mode & S_IXOTH ? 'x' : '-');
                fprintf(stdout, " %10d", (int) fileStat.st_size);
                if ((pwd = getpwuid(fileStat.st_uid)) != NULL) {
                    printf(" %12s", pwd->pw_name);
                }
            }
            if (args & ARG_GROUP && (grp = getgrgid(fileStat.st_gid)) != NULL) {
                printf(" %12s", grp->gr_name);
            }
            if (args & ARG_LIST) {
                fprintf(stdout, "  %s", &(full_path[orig_path_len + 1]));
                if (S_ISLNK(fileStat.st_mode)) {
                    full_path_2 = dir->d_name;
                    while (1) {
                        get_linked_file(full_path_2, original_file_name);
                        lstat(full_path_2, &fileStat2);
                        if (!S_ISLNK(fileStat2.st_mode)) {
                            break;
                        }
                        full_path_2 = concat(concat(path, "/"), original_file_name);
                    }
                    fprintf(stdout, " -> %s", original_file_name);
                }
                fprintf(stdout, "\n");
            } else {
                fprintf(stdout, "%s  ", &(full_path[orig_path_len + 1]));
            }
            if (args & ARG_RECURSIVE && S_ISDIR(fileStat.st_mode))
            {
                print_list(full_path, args, orig_path_len);
            }

        }
        closedir(d);
    }
}


int main(int argc, char * argv[])
{
    int i = 0;
    short int path_provided = 0;
    short int args = 0;
    char * cur_dir;
    for (i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "-l") == 0)
        {
            args += ARG_LIST;
        }
        if (strcmp(argv[i], "-g") == 0)
        {
            args += ARG_GROUP;
        }
        if (strcmp(argv[i], "-R") == 0)
        {
            args += ARG_RECURSIVE;
        }
    }
    for (i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "-l") != 0 && strcmp(argv[i], "-g") != 0 && strcmp(argv[i], "-R") != 0)
        {
            // Это не параметр вывода, значит, рассмотрим это как путь
            path_provided = 1;
            if (access(argv[i], F_OK) != -1)
            {
                if (argv[i][strlen(argv[i]) - 1] == '/')
                {
                    argv[i][strlen(argv[i]) - 1] = '\0';
                }
                argv[i] = abs_path(argv[i]);
                print_list(argv[i], args, (int)strlen(argv[i]));
            }
            else
            {
                fprintf(stderr, "Path does not exist: %s\n", argv[i]);
            }
        }
    }
    if (!path_provided)
    {
        cur_dir = get_current_directory();
        print_list(cur_dir, args, (int)strlen(cur_dir));
    }
}