#include <iostream>
#include "Body.h"
#include "Box.h"
#include "WBox.h"
#include "HBox.h"
#include "WHBox.h"


int main() {
    const Box box1 = Box(1, 2, 3);
    Box box2 = box1;
    box2++;
    box1.dump();
    box2.dump();
    Box box3 = box1 + box2;
    box3.dump();
    std::cout << box1.area() << std::endl;
    Box box4 = Box(3);
    WBox w_box = WBox(3, 2, 1);
//     Разница между следующими двумя значениями должна быть = 2
    std::cout << box4.area() << std::endl;
    std::cout << w_box.area() << std::endl;
    HBox h_box = HBox(1, 1);
    std::cout << h_box.area() << std::endl;
    try {
        WHBox wh_box = WHBox(2, 1, 1, 1, 1);
        wh_box.dump();
    } catch (char const * e) {
        std::cout << e << std::endl;
    }
    try {
        int s = (1 * 3 * 3) + (2 * 3 * 2) + (2 * 3 * 2) +
                (1 * 3 * 3) + (2 * 1 * 3) + (2 * 1 * 3) -
                1 * 1;
        std::cout << "Ожидаем: " << s << std::endl;
        WHBox b = WHBox(3, 3, 2, 1, 1, 1);
        std::cout << "Получаем: " << b.area() << std::endl;
    } catch (char const * e) {
        std::cout << e << std::endl;
    }
    return 0;
}