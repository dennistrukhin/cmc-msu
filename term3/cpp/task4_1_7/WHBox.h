//
// Created by Dennis Trukhin on 08/12/2017.
//

#ifndef BOX_WHBOX_H
#define BOX_WHBOX_H


#include "HBox.h"
#include "WBox.h"

class WHBox : HBox, WBox {
private:
public:
    WHBox(int side, int window_width, int window_height, int lid_height);
    WHBox(int width, int height, int window_width, int window_height, int lid_height);
    WHBox(int width, int length, int height, int window_width, int window_height, int lid_height);
    ~WHBox();
    int area();
};


#endif //BOX_WHBOX_H
