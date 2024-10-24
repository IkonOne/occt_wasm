#include "occt_wasm.h"

#include <gp_Pnt.hxx>

#include <iostream>

int main()
{
    gp_Pnt pnt(1, 2, 3);
    std::cout << "pnt.X() = " << pnt.X() << std::endl;
    std::cout << "pnt.Y() = " << pnt.Y() << std::endl;
    std::cout << "pnt.Z() = " << pnt.Z() << std::endl;

    int lhs = 10;
    int rhs = 5;

    std::cout << "lhs = " << lhs << ", rhs = " << rhs << std::endl;
    std::cout << "ow::add(lhs, rhs) = " << ow::add(lhs, rhs) << std::endl;
    std::cout << "ow::sub(lhs, rhs) = " << ow::sub(lhs, rhs) << std::endl;
    std::cout << "ow::mul(lhs, rhs) = " << ow::mul(lhs, rhs) << std::endl;
    std::cout << "ow::div(lhs, rhs) = " << ow::div(lhs, rhs) << std::endl;

    return 0;
}
