#include "occt_wasm.h"

#include <emscripten/bind.h>

using namespace emscripten;

EMSCRIPTEN_BINDINGS(occt_wasm)
{
    function("testing", &testing);
}