//
// Created by Dennis Trukhin on 07/12/2017.
//

#include <iostream>
#include "Box.h"

void Box::set_width(int width) {
    if (width <= 0) {
        throw "Box width should be more than zero";
    }
    this->width = width;
}

void Box::set_height(int height) {
    if (height <= 0) {
        throw "Box height should be more than zero";
    }
    this->height = height;
}

void Box::set_length(int length) {
    if (length <= 0) {
        throw "Box length should be more than zero";
    }
    this->length = length;
}

int Box::get_height() const {
    return this->height;
}

int Box::get_length() const {
    return this->length;
}

int Box::get_width() const {
    return this->width;
}

Box::Box(int side) {
    if (side <= 0) {
        throw "Box side should be more than zero";
    }
    this->width = side;
    this->length = side;
    this->height = side;
}

Box::Box(int width, int height) {
    if (width <= 0) {
        throw "Box width should be more than zero";
    }
    this->width = width;
    this->length = width;
    if (height <= 0) {
        throw "Box height should be more than zero";
    }
    this->height = height;
}

Box::Box(int width, int length, int height) {
    if (width <= 0) {
        throw "Box width should be more than zero";
    }
    this->width = width;
    if (length <= 0) {
        throw "Box length should be more than zero";
    }
    this->length = length;
    if (height <= 0) {
        throw "Box height should be more than zero";
    }
    this->height = height;
}

Box::Box(const Box &obj) {
    width = obj.width;
    height = obj.height;
    length = obj.length;
}

int Box::area() const {
    return width * length + 2 * width * height + 2 * length * height;
}

void Box::dump() const {
    std::cout << "Width: " << width << ", Length: " << length << ", Height: " << height << std::endl;
}

Box & Box :: operator ++ ()
{
    width = this->width + 1;
    height = this->height + 1;
    length = this->length + 1;
    return * this;
}
Box Box :: operator ++ (int)
{
    Box result = * this;
    width = this->width + 1;
    height = this->height + 1;
    length = this->length + 1;
    return result;
}
Box & Box :: operator -- ()
{
    width = this->width - 1;
    height = this->height - 1;
    length = this->length - 1;
    return * this;
}
Box Box :: operator -- (int)
{
    Box result = * this;
    width = this->width - 1;
    height = this->height - 1;
    length = this->length - 1;
    return result;
}
Box & Box :: operator = (const Box & obj) {
    if (this == & obj) {
        return * this;
    }
    width = obj.width ;
    height = obj.height;
    length = obj.length;
    return * this;
}