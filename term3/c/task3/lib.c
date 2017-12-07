#include <unistd.h>
#include <stdlib.h>
#include <memory.h>

char * concat(const char *s1, const char *s2)
{
    char * result = malloc(strlen(s1) + strlen(s2) + 1);
    strcpy(result, s1);
    strcat(result, s2);
    return result;
}

char * get_current_directory()
{
    char * cwd;
    cwd = getcwd(0, 0);
    return cwd;
}

char * abs_path(char * path)
{
    if (*path != '/') {
        return concat(concat(get_current_directory(), "/"), path);
    }
    return path;
}

long max(long a, long b)
{
    return a > b ? a : b;
}