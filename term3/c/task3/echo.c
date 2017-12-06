#include <stdio.h>

const char * WITH_SPACE = "%s ";
const char * WITH_NEW_LINE = "%s\n";

int main(int argc, char * argv[])
{
    int i = 0;
    for (i = 1; i < argc; i++)
    {
        fprintf(stdout, i == argc ? WITH_NEW_LINE : WITH_SPACE, argv[i]);
    }
}
