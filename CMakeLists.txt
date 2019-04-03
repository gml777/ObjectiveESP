cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_STANDARD 17)

project(KYEPathDataDemo)

add_executable(${PROJECT_NAME} "demo.cc" "KYEPathData.cc")
