#include <stdio.h>
#include <memory.h>

const char * WITH_SPACE = "%s ";
const char * WITHOUT_SPACE = "%s";

int main(int argc, char * argv[])
{
    int i = 0;
    int print_last_new_line;
    print_last_new_line = (argc > 1 && strcmp(argv[1], "-n") == 0) ? 0 : 1;
    for (i = 2 - print_last_new_line; i < argc; i++)
    {
        fprintf(stdout, i == argc - 1 ? WITHOUT_SPACE : WITH_SPACE, argv[i]);
    }
    if (print_last_new_line) {
        fprintf(stdout, "\n");
    }
}
