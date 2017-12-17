#include <stdio.h>
#include <setjmp.h>

jmp_buf begin;
char curlex;

void getlex(void);
int expr(void);
int add(void);
int power(void);
int mult(void);
void error();

int main()
{
    int result;
    setjmp(begin);
    printf("==>");
    getlex();
    result = expr();
    if (curlex != '\n') error();
    printf("\n%d\n",result);
    return 0;
}

void getlex()
{
    while ((curlex = getchar()) == ' ');
}

void error(void) {
    printf("\nERROR\n");
    while (getchar() != '\n');
    longjmp(begin, 1);
}

int expr() {
    int e = add();
    while (curlex == '+' || curlex == '-') {
        if (curlex == '+') {
            getlex();
            e += add();
        } else {
            getlex();
            e -= add();
        }
    }
    return e;
}

int deg(int a) {
    int n = mult();
    if (curlex == '^') {
        getlex();
        n = deg(n);
    }
    int i;
    int res = a;
    for (i = 1; i < n; i++) {
        res *= a;
    }
    if (n == 0) {
        return 1;
    }
    return res;
}

int add() {
    int a = mult();
    while (curlex == '*' || curlex == '/' || curlex == '^') {
        if (curlex == '*') {
            getlex();
            a *= mult();
        } else if (curlex == '/') {
            getlex();
            a = (int) a / mult();
        } else if (curlex == '^') {
            getlex();
            a = deg(a);
        }
    }
    return a;
}


int mult() {
    int m;
    switch (curlex) {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            m = curlex - '0';
            break;
        case '(':
            getlex();
            m = expr();
            if (curlex == ')') break;
            /* Иначе ошибка - нет закрывающей скобки */
        default :
            error();
    }
    getlex();
    return m;
}