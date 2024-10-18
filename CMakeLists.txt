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

if (UNIX OR APPLE)
    set(CFLAGS ${CFLAGS} -m32)
    set(CXXFLAGS ${CFLAGS} -m32)
endif()


project(occt_wasm)

option(OCCT_WASM_BUILD_EXTERNAL_ONLY CACHE ON)

set(CMAKE_CXX_STANDARD 20)

include(3rdparty/find_dependencies.cmake)

if(NOT OCCT_WASM_BUILD_EXTERNAL_ONLY)
    add_library(lib_occt_wasm STATIC
        occt_wasm.h
        occt_wasm.cpp
    )
    add_dependencies(lib_occt_wasm ext_occt)

    add_executable(test test.cpp)
    target_include_directories(test PRIVATE ${OpenCASCADE_INCLUDE_DIR})
    target_link_libraries(test lib_occt_wasm ${OpenCASCADE_LIBRARIES})
endif()
