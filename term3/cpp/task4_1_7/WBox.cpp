//
// Created by Dennis Trukhin on 07/12/2017.
//

#include <iostream>
#include "WBox.h"
#include "lib.h"

WBox::WBox(int side, int window_width, int window_height) : Box(side)
{
    if (window_width <= 0) {
        throw "Box window width should be more than zero";
    }
    if (window_width >= side) {
        throw "Box window width should be less then the greatest side";
    }
    if (window_height <= 0) {
        throw "Box window height should be more than zero";
    }
    if (window_height >= side) {
        throw "Box window height should be less then the height";
    }
    this->window_width = window_width;
    this->window_height = window_height;
}

void WBox::set_window_width(int window_width) {
    this->window_width = window_width;
}

void WBox::set_window_height(int window_heigth) {
    this->window_height = window_heigth;
}

int WBox::get_window_width() {
    return window_width;
}

int WBox::get_window_height() {
    return window_height;
}

WBox::WBox(int width, int height, int window_width, int window_height) : Box(width, height) {
    if (window_width <= 0) {
        throw "Box window width should be more than zero";
    }
    if (window_width >= width) {
        throw "Box window width should be less then the greatest side";
    }
    if (window_height <= 0) {
        throw "Box window height should be more than zero";
    }
    if (window_height >= height) {
        throw "Box window height should be less then the height";
    }
    this->window_width = window_width;
    this->window_height = window_height;
}

WBox::WBox(int width, int length, int height, int window_width, int window_height) : Box(width, length, height) {
    if (window_width <= 0) {
        throw "Box window width should be more than zero";
    }
    if (window_width >= max(width, length)) {
        throw "Box window width should be less then the greatest side";
    }
    if (window_height <= 0) {
        throw "Box window height should be more than zero";
    }
    if (window_height >= height) {
        throw "Box window height should be less then the height";
    }
    this->window_width = window_width;
    this->window_height = window_height;
}

int WBox::area() {
    return Box::area() - window_height * window_width;
}

WBox::~WBox() {
    std::cout << "WBox destructor has been called" << std::endl;
}
