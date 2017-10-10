#include <stdio.h>

unsigned long int fib_recursive(int i)
{
    if (i < 3) {
        return  1;
    }
    return fib_recursive(i - 1) + fib_recursive(i - 2);
}

unsigned long int fib_iterative(int i)
{
    if (i < 3) {
        /**
         * Если запрошено 1 или 2 число, то посчитать их нельзя, так как они заданы по определению и равны 1
         */
        return 1;
    }
    unsigned long int n = 0;
    unsigned long int n_2 = 1;
    unsigned long int n_1 = 1;
    int k;
    for (k = i - 2; k > 0; k--) {
        n = n_1 + n_2;
        n_2 = n_1;
        n_1 = n;
    }
    return n;
}

int main() {
    unsigned int i;
    while (scanf("%d", &i) != EOF) {
        printf("%ld\n", fib_iterative(i));
        printf("%ld\n", fib_recursive(i));
    }
}