cmake_minimum_required(VERSION 3.14)

message(STATUS "Operating System: ${CMAKE_SYSTEM_NAME}")
message(STATUS "Processor: ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "Host System Name: ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "Host System Version: ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "CMake Version: ${CMAKE_VERSION}")
message(STATUS "CMake Generator: ${CMAKE_GENERATOR}")

message(STATUS "C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "C++ Compiler Version: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "C Compiler Version: ${CMAKE_C_COMPILER_VERSION}")

# if (UNIX OR APPLE)
#     set(CFLAGS ${CFLAGS} -m32)
#     set(CXXFLAGS ${CFLAGS} -m32)
# endif()

project(occt_wasm)

set(CMAKE_CXX_STANDARD 20)

if (CMAKE_SYSTEM_NAME STREQUAL Emscripten)
    set(CMAKE_EXECUTABLE_SUFFIX .js)
endif()

find_package(OpenCASCADE REQUIRED)

set(AnalysisSitus_LIBRARIES
    /emsdk/upstream/emscripten/cache/sysroot/lib/libasiActiveData
    /emsdk/upstream/emscripten/cache/sysroot/lib/libasiAlgo
    /emsdk/upstream/emscripten/cache/sysroot/lib/libasiAsm
    /emsdk/upstream/emscripten/cache/sysroot/lib/libasiData
    /emsdk/upstream/emscripten/cache/sysroot/lib/libasiEngine
)
set(AnalysisSitus_INCLUDE_DIR /emsdk/upstream/emscripten/system/include)

# set(EM_LINK_FLAGS 
#     "-sASSERTIONS=0"
#     "-sINVOKE_RUN=0"
#     "-sALLOW_MEMORY_GROWTH=1"
#     # "-sWASM=1"
#     "-sENVIRONMENT=webview"
#     "-sFILESYSTEM=0"
#     # "-sMINIMAL_RUNTIME=1"
#     "-sMODULARIZE=1" 
#     "-sEXPORT_ES6=1"
#     # "-sIGNORE_CLOSURE_COMPILER_ERRORS=0"
#     # "-sWASM_BIGINT=1"
#     # "-sSTANDALONE_WASM=0"
#     # "-sBINARYEN_ASYNC_COMPILATION=1"
#     # "-sDYNAMIC_EXECUTION=0"
#     "-sPOLYFILL=0"
#     # "-sSTRICT=0"
#     "-sIGNORE_MISSING_MAIN=0"
#     "-sAUTO_JS_LIBRARIES=0"
#     "-sAUTO_NATIVE_LIBRARIES=0"
#     "-sAUTO_ARCHIVE_INDEXES=0"
#     "-sDEFAULT_TO_CXX=0"
#     "-sUSE_GLFW=0"
#     "-sALLOW_UNIMPLEMENTED_SYSCALLS=1"
#     "-sINCOMING_MODULE_JS_API=\"['wasmBinary']\""
#     "--no-entry"
# )

# include_directories(SYSTEM "${EMSCRIPTEN_ROOT_PATH}/system/include")
# include_directories(SYSTEM "${EMSCRIPTEN_ROOT_PATH}/system/include/emscripten")

if (EMSCRIPTEN)
    set(EM_LINK_FLAGS --no-entry)
    add_executable(lib_occt_wasm
        occt_wasm.cpp
        occt_wasm.bindings.cpp
    )
    target_include_directories(lib_occt_wasm
        PRIVATE
        ${OpenCASCADE_INCLUDE_DIR}
        # ${AnalysisSitus_INCLUDE_DIR}
    )
    target_link_libraries(lib_occt_wasm
        embind
        ${OpenCASCADE_LIBRARIES}
        # ${AnalysisSitus_LIBRARIES}
    )
endif()