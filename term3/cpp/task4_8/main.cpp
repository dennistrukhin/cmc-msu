#include <iostream>

template <typename T, int MAX_STACK_SIZE> class Stack {
private:
    size_t size;
    T data[MAX_STACK_SIZE];
public:
    Stack() {
        size = 0;
    }
    bool is_empty() {
        return size == 0;
    }
    T get_top() {
        if (is_empty()) {
            throw "Stack is empty";
        }
        return data[size - 1];
    }
    void push(T item) {
        if (size == MAX_STACK_SIZE) {
            throw "Stack overflow :)";
        }
        data[size] = item;
        ++size;
    }
    T pop() {
        if (is_empty()) {
            throw "Stack is empty";
        }
        --size;
        return data[size];
    }
};


int main() {
    Stack <int, 3> stack = Stack <int, 3> ();
    stack.push(1);
    stack.push(2);
    stack.push(3);
    try {
        stack.push(4);
    } catch (char const * e) {
        std::cout << e << std::endl;
    }
    std::cout << stack.get_top() << std::endl;
    std::cout << stack.pop() << std::endl;
    std::cout << stack.pop() << std::endl;
    std::cout << stack.pop() << std::endl;
    try {
        std::cout << stack.pop() << std::endl;
    } catch (char const * e) {
        std::cout << e << std::endl;
    }

    // То же самое, но для вещественных чисел
    Stack <double , 3> stack_d = Stack <double, 3> ();
    stack_d.push(1.1);
    stack_d.push(2.2);
    stack_d.push(3.3);
    try {
        stack_d.push(4.4);
    } catch (char const * e) {
        std::cout << e << std::endl;
    }
    std::cout << stack_d.get_top() << std::endl;
    std::cout << stack_d.pop() << std::endl;
    std::cout << stack_d.pop() << std::endl;
    std::cout << stack_d.pop() << std::endl;
    try {
        std::cout << stack_d.pop() << std::endl;
    } catch (char const * e) {
        std::cout << e << std::endl;
    }

    return 0;
}