#include <stdio.h>

/*
 * abs работает только с int, поэтому реализуем свою версию для double
 */
double abs_double(double f)
{
    return f * (f > 0 ? 1 : -1);
}

double iterate(double x, double last_x)
{
    return (1.0 / 2.0 * (last_x + x / last_x));
}

double sqrt(double e, double x)
{
    double last_x = 1;
    double current_x = iterate(x, last_x);
    while (abs_double(current_x - last_x) >= e) {
        last_x = current_x;
        current_x = iterate(x, last_x);
    }

    return current_x;
}

int main() {
    double e = 1;
    double x = 0;
    scanf("%lf", &e);
    while (scanf("%lf", &x) != EOF)
    {
        printf("%lf\n", sqrt(e, x));
    }
    return 0;
}