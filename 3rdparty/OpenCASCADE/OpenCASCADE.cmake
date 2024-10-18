include(ExternalProject)

ExternalProject_Add(
    ext_occt
    PREFIX occt
    GIT_REPOSITORY https://github.com/Open-Cascade-SAS/OCCT.git
    GIT_TAG V7_8_1
    UPDATE_COMMAND ""

    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DBUILD_SHARED_LIBS=OFF
        -DBUILD_LIBRARY_TYPE=STATIC

        -DHAVE_RAPIDJSON=ON

        -DBUILD_MODULE_FoundationClasses=ON
        -DBUILD_MODULE_ModelingData=ON
        -DBUILD_MODULE_ModelingAlgorithms=ON
        -DBUILD_MODULE_ApplicationFramework=ON
        -DBUILD_MODULE_DataExchange=ON
        -DBUILD_MODULE_DETools=OFF
        -DBUILD_MODULE_Draw=OFF
)

if (NOT OCCT_WASM_BUILD_EXTERNAL_ONLY)
    # ExternalProject_Get_Property(ext_occt INSTALL_DIR)
    # message(STATUS "OpenCASCADE install dir: ${INSTALL_DIR}")
    # set(OpenCASCADE_DIR ${PROJECT_SOURCE_DIR}/build/external/occt/lib/cmake/)
    set(OpenCASCADE_DIR build/external/occt/lib/cmake/opencascade)
    message(STATUS "OpenCASCADE_DIR: ${OpenCASCADE_DIR}")

    set(CMAKE_FIND_DEBUG_MODE TRUE)
    find_package(OpenCASCADE 7.8.1 REQUIRED)
    if (OpenCASCADE_FOUND)
        message(STATUS "OpenCASCADE found")
        message(STATUS "OpenCASCADE_INCLUDE_DIR: ${OpenCASCADE_INCLUDE_DIR}")
        message(STATUS "OpenCASCADE_LIBRARY_DIR: ${OpenCASCADE_LIBRARY_DIR}")
        message(STATUS "OpenCASCADE_LIBRARIES: ${OpenCASCADE_LIBRARIES}")
        message(STATUS "OpenCASCADE_INSTALL_PREFIX: ${OpenCASCADE_INSTALL_PREFIX}")
    else()
        message(WARNING "OpenCASCADE not found")
    endif()
endif()
