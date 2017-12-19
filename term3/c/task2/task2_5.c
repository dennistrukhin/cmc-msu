#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char *str;
    struct Node *next;
} Node;

void append(Node ** head, char * str) {
    // Тут мы создали новый элемент в списке. Пока что он просто "болтается" в памяти
    Node * tmp = (Node *) malloc(sizeof(Node));
    char * new_str = (char *) malloc(128);
    strncpy(new_str, str, 128);
    tmp->str = new_str;
    tmp->next = NULL;
    // Теперь надо понять, кто будет на него указывать
    Node ** ptr = head;
    while (* ptr != NULL) {
        ptr = &((*ptr)->next);
    }
    *ptr = tmp;
}


int main() {
    char * str;
    Node * head = NULL;
    Node * tmp;
    Node ** ptr;
    int first_output = 1;
    fprintf(stdout, "==>\n");
    while (scanf("%s", str) != EOF) {
        append(&head, str);
    }
    // В str у нас остался указатель на последнюю строку, так что теперь можно перебрать список
    // и удалить те эелементы, у которых строка такая же и при этом указатель на следующий элемент не NULL
    // Пройдёмся по списку
    ptr = &head;
    while (*ptr != NULL) {
        if (strcmp(str, (*ptr)->str) == 0 && (*ptr)->next != NULL) {
            tmp = *ptr;
            *ptr = (*ptr)->next;
            free(tmp);
        } else {
            ptr = &(*ptr)->next;
        }
    }

    ptr = &head;
    while (*ptr != NULL) {
        if (!first_output) {
            printf(" ");
        }
        first_output = 0;
        printf("%s", (*ptr)->str);
        ptr = &((*ptr)->next);
    }
    printf("\n");
    return 0;
}