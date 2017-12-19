//
// Created by Dennis Trukhin on 07/12/2017.
//

#ifndef BOX_HBOX_H
#define BOX_HBOX_H


#include "Box.h"

class HBox : public virtual Box {
private:
    int lid_height;
public:
    HBox(int, int);
    HBox(int, int, int);
    HBox(int, int, int, int);
    ~HBox();
    int area() const;
    int lid_area() const;
};


#endif //BOX_HBOX_H
