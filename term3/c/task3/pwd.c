#include <unistd.h>
#include <stdio.h>

int main(int argc, char * argv[])
{
    char * cwd;
    cwd = getcwd(0, 0);
    fprintf(stdout, "%s\n", cwd);
}