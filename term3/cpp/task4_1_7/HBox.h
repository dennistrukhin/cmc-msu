#ifndef BOX_HBOX_H
#define BOX_HBOX_H


#include "Box.h"

class HBox : Box {
private:
    int lid_height;
public:
    HBox(int, int);
    HBox(int, int, int);
    HBox(int, int, int, int);
    ~HBox();
    int area();
    int lid_area();
};


#endif //BOX_HBOX_H