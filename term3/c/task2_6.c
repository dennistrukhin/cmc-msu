#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    long int value;
    struct node *left;
    struct node *right;
} Node;

char input[16];

Node* root = NULL;

long int minimum(Node** node)
{
    if ((*node)->left == NULL)
    {
        return (*node)->value;
    }
    return minimum(&(*node)->left);
}

void insert(Node** node, Node* elem)
{
    if (*node == NULL) {
        *node = elem;
    }
    else if (elem->value < (*node)->value)
    {
        insert(&(*node)->left, elem);
    }
    else if (elem->value > (*node)->value)
    {
        insert(&(*node)->right, elem);
    }
    else
    {
        return;
    }
}


short int search(Node** node, long int value)
{
    if (*node == NULL) {
        return  0;
    }
    else if (value < (*node)->value)
    {
        return  search(&(*node)->left, value);
    }
    else if (value > (*node)->value)
    {
        return search(&(*node)->right, value);
    }
    else
    {
        return 1;
    }
}


Node* delete(Node** node, long int value)
{
    if (*node == NULL)
    {
        return *node;
    }
    else if (value > (*node)->value)
    {
        return delete(&(*node)->right, value);
    }
    else if (value < (*node)->value)
    {
        return delete(&(*node)->left, value);
    }
    if ((*node)->value == value)
    {
        // Надо удалить текущий элемент
        // В первом случае случае у нас есть оба потомка
        if ((*node)->left != NULL && (*node)->right != NULL)
        {
            (*node)->value = minimum(&(*node)->right);
            delete(&(*node)->right, (*node)->value);
        }
        // Во втором и третьем случаях у нас не хватает одного потомка
        else if ((*node)->left == NULL)
        {
            (*node) = (*node)->right;
        }
        else if ((*node)->right == NULL)
        {
            (*node) = (*node)->left;
        }
    }
    return *node;
}


int main() {
    long int v;
    char* ptr;
    Node* elem;
    while (scanf("%s", input) != EOF) {
        v = strtol(input+1, &ptr, 10);
        switch (*input) {
            case '+':
                fprintf(stderr, "Inserting\n");
                elem = (Node *) malloc(sizeof(Node));
                elem->left = NULL;
                elem->right = NULL;
                elem->value = v;
                insert(&root, elem);
                break;
            case '-':
                fprintf(stderr, "Deleting\n");
                delete(&root, v);
                break;
            case '?':
                fprintf(stdout, "%ld ", v);
                if (search(&root, v))
                {
                    fprintf(stdout, "yes\n");
                }
                else
                {
                    fprintf(stdout, "no\n");
                }
                break;
            default:
                fprintf(stderr, "Первым символом должен быть + - ?\n");
        }

    }
    return 0;
}