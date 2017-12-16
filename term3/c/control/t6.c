#include <stdio.h>
#include <memory.h>
#include <stdlib.h>

char * s = "qqwweerrttyyuu";

void strip_repetitions(char * str)
{
    int i = 1; // Будет указывать на текущий символ в строке, начнём со второго
    int j; // Будем перебирать остаток строки и перемещать левее при необходимости
    char last_char;
    if (str[0] == 0 || str[1] == 0) {
        // Строка пустая или содержит только один символ
        return;
    }
    last_char = str[0];
    while (str[i] != 0)
    {
        if (str[i] == last_char)
        {
            // Оказалось, что текущий символ такой же, как и предыдущий
            // переместим остаток строки левее и затрём текущий символ
            j = i;
            while (str[j] != 0)
            {
                str[j] = str[j + 1];
                j++;
            }
        } else {
            last_char = str[i];
            i++;
        }
    }
}

int main()
{
    // Так как строка задана константой, то она размещается в части исполнемого кода, и поэтому
    // её нельзя модифицировать. Скопируем строку в выделенную память для данных, чтобы работать с ней.
    char *a = malloc(strlen(s));
    strcpy(a, s);
    // Тут, собственно, вызывается функция модификации строки - уже той, которая в памяти
    strip_repetitions(a);
    fprintf(stderr, "%s", a);
    return 0;
}