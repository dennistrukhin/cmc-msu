#ifndef BOX_BOX_H
#define BOX_BOX_H


#include "Body.h"

class Box : Body {
private:
    int width;
    int length;
    int height;
public:
    explicit Box(int side);
    Box(int width, int height);
    Box(int width, int length, int height);
    Box (const Box & obj);
    Box & operator ++ ();
    Box operator ++ (int);
    Box & operator -- ();
    Box operator -- (int);
    Box & operator = (const Box & obj);
    friend Box operator+ (const Box & box1, const Box & box2) {
        Box temp_box = Box(
                box1.get_width() + box2.get_width(),
                box1.get_length() + box2.get_length(),
                box1.get_height() + box2.get_height()
        );
        return temp_box;
    };
    void set_width(int width);
    void set_length(int length);
    void set_height(int height);
    int get_width() const;
    int get_length() const;
    int get_height() const;
    int area() const;
    void dump() const;
};


#endif
