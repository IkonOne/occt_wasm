#include <occt_wasm.h>

#include <gp_Pnt.hxx>

#include <iostream>

int main()
{
    gp_Pnt p(1, 2, 3);

    std::cout << "Point: (" << p.X() << ", " << p.Y() << ", " << p.Z() << ")" << std::endl;

    int lhs = 10;
    int rhs = 5;

    std::cout << "lhs = " << lhs << ", rhs = " << rhs << std::endl;
    std::cout << "add(lhs, rhs) = " << add(lhs, rhs) << std::endl;
    std::cout << "sub(lhs, rhs) = " << sub(lhs, rhs) << std::endl;
    std::cout << "mul(lhs, rhs) = " << mul(lhs, rhs) << std::endl;
    std::cout << "div(lhs, rhs) = " << div(lhs, rhs) << std::endl;
    return 0;
}