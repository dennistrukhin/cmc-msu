//
// Created by Dennis Trukhin on 08/12/2017.
//

#include <iostream>
#include "WHBox.h"

WHBox::WHBox(int side, int window_width, int window_height, int lid_height) :
        WBox(side, window_width, window_height),
        HBox(side, lid_height),
        Box(side) {}

WHBox::WHBox(int width, int height, int window_width, int window_height, int lid_height) :
        WBox(width, height, window_width, window_height),
        HBox(width, height, lid_height),
        Box(width, height) {}

WHBox::WHBox(int width, int length, int height, int window_width, int window_height, int lid_height) :
        WBox(width, length, height, window_width, window_height),
        HBox(width, length, height, lid_height),
        Box(width, length, height) {}

int WHBox::area() const {
    return WBox::area() + HBox::lid_area();
}

WHBox::~WHBox() {
    std::cout << "WHBox constructor has been called" << std::endl;
}
