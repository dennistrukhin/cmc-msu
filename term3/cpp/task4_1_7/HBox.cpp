#include <iostream>
#include "HBox.h"

HBox::HBox(int side, int lid_height) : Box(side)  {
    if (lid_height <= 0) {
        throw "Box lid height should be more than zero";
    }
    this->lid_height = lid_height;
}

HBox::HBox(int width, int height, int lid_height) : Box(width, height) {
    if (lid_height <= 0) {
        throw "Box lid height should be more than zero";
    }
    this->lid_height = lid_height;
}

HBox::HBox(int width, int length, int height, int lid_height) : Box(width, length, height) {
    if (lid_height <= 0) {
        throw "Box lid height should be more than zero";
    }
    this->lid_height = lid_height;
}
HBox::~HBox() {
    std::cout << "HBox destructor has been called" << std::endl;
}

int HBox::area() const {
    Box lid = Box(get_width(), get_length(), get_height());
    return Box::area() + lid_area();
}

int HBox::lid_area() const {
    Box lid = Box(get_width(), get_length(), get_height());
    return lid.area();
}
