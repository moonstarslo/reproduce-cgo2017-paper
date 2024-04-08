cmake_minimum_required(VERSION 3.16)
project(SwPrefetchPass)

find_package(/usr/lib/llvm-10/lib/cmake/llvm/LLVM)

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)

add_llvm_library(SwPrefetchPass MODULE SwPrefetchPass.cc PLUGIN_TOOL clang)
