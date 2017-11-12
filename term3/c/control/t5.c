#include <stdio.h>
#include <memory.h>
#include <stdlib.h>

const int BUFF_SIZE = 1024;


int ends_with(char * str, char * suffix)
{
    // suffix - это только символы, которые надо сравнить, поэтмоу выделим
    // в памяти на один байт больше для \0
    char * str_end = malloc(strlen(suffix) + 1);
    char * pos;
    // fgets отдаёт строки вместе с \n, поэтмоу надо поменять \n на \0
    if ((pos = strchr(str, '\n')) != NULL) {
        *pos = '\0';
    }
    // откусим от строки конец нужной длины
    memcpy(str_end, &str[strlen(str) - strlen(suffix)], strlen(suffix));
    // И дополним его нулевым байтом
    str_end[strlen(suffix)] = 0;
    return strcmp(str_end, suffix) == 0;
}


int main(int argc, char * argv[])
{
    int i;
    int found = 0;
    char * word_to_find;
    char buff[BUFF_SIZE];
    FILE * ptr_file;
    if (argc < 3) {
        // Один аргумент - это название исполняемого файла, два аргумента - название и искомое слово
        // В обоих этих случаях можно сразу выходить
        return 0;
    }
    word_to_find = argv[1];
    for (i = 2; i < argc; i++)
    {
        ptr_file = fopen(argv[i], "r");
        while (fgets(buff, BUFF_SIZE, ptr_file) != NULL) {
            if (ends_with(buff, word_to_find)) {
                ++found;
            }
        }
    }
    fprintf(stdout, "Total: %d\n", found);
    return 0;
}