cmake_minimum_required(VERSION 3.15)
project(EmbeddedFirmware C CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


add_executable(firmware src/main.c)

# Include Conan
include(${CMAKE_BINARY_DIR}/conan_deps.cmake OPTIONAL)

# Unit tests
add_executable(tests tests/test_main.cpp)
find_package(GTest REQUIRED)
target_link_libraries(tests GTest::gtest GTest::gtest_main)