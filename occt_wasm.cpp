#include "occt_wasm.h"

namespace ow {

int add(int lhs, int rhs)
{
    return lhs + rhs;
}

int sub(int lhs, int rhs)
{
    return lhs - rhs;
}

int mul(int lhs, int rhs)
{
    return lhs * rhs;
}

int div(int lhs, int rhs)
{
    return lhs / rhs;
}
}
