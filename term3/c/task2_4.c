#include <stdio.h>

long int power(int n, int a)
{
    long int r = n;
    if (a == 0) {
        return 1;
    }
    if (a > 1) {
        int i;
        for (i = 2; i <= a; i++) {
            r = r * n;
        }
    }
    return r;
}


double str2double(char str[])
{
    /**
     * mode = 0 - читаем слева до точки
     *      = 1 - читаем справа от точки до Е (если есть)
     *      = 2 - читаем справа от Е
     */
    int i;
    double n = 0;
    short int is_negative = 0;
    long int n_whole = 0;
    long int n_rational = 0;
    short int n_rational_length = 0;
    int exp = 0;
    short int exp_negative = 0;
    int mode = 0;
    for (i = 0; i < 100; i++) {
        if (str[i] != 0) {
            switch (mode) {
                case 1:
                    if (str[i] >= '0' && str[i] <= '9') {
                        n_rational_length++;
                        n_rational = n_rational * 10 + str[i] - '0';
                    }
                    if (str[i] == 'e' || str[i] == 'E') {
                        mode = 2;
                    }
                    break;
                case 2:
                    if (str[i] == '-') {
                        exp_negative = 1;
                    }
                    if (str[i] >= '0' && str[i] <= '9') {
                        exp = exp * 10 + str[i] - '0';
                    }
                    break;
                default:
                    if (str[i] == '-') {
                        is_negative = 1;
                    }
                    if (str[i] >= '0' && str[i] <= '9') {
                        n_whole = n_whole * 10 + str[i] - '0';
                    }
                    if (str[i] == '.') {
                        mode = 1;
                    }
                    if (str[i] == 'e' || str[i] == 'E') {
                        mode = 2;
                    }
            }
        }
    }
    n = n_whole + (double) n_rational / (double) power(10, n_rational_length);
    if (exp_negative) {
        n = n / power(10, exp);
    } else {
        n = n * power(10, exp);
    }
    if (is_negative) {
        n = -1 * n;
    }
    return n;
}


int main() {
    int i;
    double n;
    char str[100];
    for (i = 0; i < 100; i++) {
        str[i] = 0;
    }
    while (scanf("%s", str) != EOF) {
        n = str2double(str);
        printf("%.10g\n", n);
        for (i = 0; i < 100; i++) {
            str[i] = 0;
        }
    }
    return 0;
}