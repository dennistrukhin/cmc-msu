//
// Created by Dennis Trukhin on 07/12/2017.
//

#ifndef BOX_WBOX_H
#define BOX_WBOX_H


#include "Box.h"

class WBox : Box {
private:
    int window_width;
    int window_height;
public:
    WBox(int side, int window_width, int window_height);
    WBox(int width, int height, int window_width, int window_height);
    WBox(int width, int length, int height, int window_width, int window_height);
    ~WBox();
    void set_window_width(int window_width);
    void set_window_height(int window_heigth);
    int get_window_width();
    int get_window_height();
    int area();
};


#endif //BOX_WBOX_H
