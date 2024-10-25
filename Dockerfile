FROM emscripten/emsdk:3.1.69 AS base

RUN apt-get update -y
RUN apt-get install -y \
    git \
    cmake \
    build-essential \
    ninja-build

FROM base AS gather-dependencies

WORKDIR /usr/src
RUN git clone --branch v1.1.0 https://github.com/Tencent/rapidjson.git


WORKDIR /usr/src
RUN apt-get install -y \
    m4 \
    libtool \
    automake
RUN git clone --depth=1 --branch VER-2-10-4 https://git.savannah.gnu.org/git/freetype/freetype2.git

WORKDIR /usr/src
RUN git clone --depth=1 --branch V7_7_2     https://github.com/Open-Cascade-SAS/OCCT.git

WORKDIR /usr/src
RUN apt-get install -y \
    libeigen3-dev
RUN git clone https://gitlab.com/ssv/AnalysisSitus.git

COPY patches/ /usr/src/patches/

FROM gather-dependencies AS build-rapidjson
WORKDIR /usr/src/rapidjson
RUN git apply /usr/src/patches/rapidjson_remove_non_compiling_assignment_operator.patch
RUN cp -r /usr/src/rapidjson/include/rapidjson /emsdk/upstream/emscripten/cache/sysroot/include/

FROM build-rapidjson AS build-freetype
WORKDIR /usr/src/freetype2
RUN pwd
RUN ./autogen.sh
RUN ./configure --prefix=/usr/local
RUN make -j$(nproc)
RUN make install

FROM build-freetype AS build-occt
WORKDIR /usr/src/OCCT
RUN git apply /usr/src/patches/occt_tag_variable_type.patch
RUN mkdir build
WORKDIR /usr/src/OCCT/build
RUN emcmake cmake .. -DBUILD_SHARED_LIBS=OFF -DBUILD_LIBRARY_TYPE=Static -DBUILD_MODULE_Draw=OFF -DBUILD_MODULE_DETools=OFF -DUSE_TK=OFF -DUSE_TCL=OFF -D3RDPARTY_FREETYPE_DIR=/usr/local -D3RDPARTY_RAPIDJSON_DIR=/usr/local
RUN make -j$(nproc)
RUN make install

FROM build-occt AS build-AnalysisSitus
WORKDIR /usr/src/AnalysisSitus
RUN mkdir build
WORKDIR /usr/src/AnalysisSitus/build
RUN emcmake cmake .. -DBUILD_LIBRARIES_TYPE=Static -DBUILD_SHARED_LIB=OFF -DDISTRIBUTION_TYPE=Algo -D3RDPARTY_DIR=/emsdk/upstream/emscripten/cache/sysroot -DEigen3_DIR=/usr/share/eigen3/cmake -D3RDPARTY_OCCT_LIBRARY_DIR=/emsdk/upstream/emscripten/cache/sysroot/lib/ -D3RDPARTY_OCCT_INCLUDE_DIR=/emsdk/upstream/emscripten/cache/sysroot/include/opencascade/
RUN make -j$(nproc)
RUN make install