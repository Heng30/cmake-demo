
# 设置cmake最低版本
cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

# 设置项目名
project(min_lib LANGUAGES CXX)

# 显示动态库
add_library(min SHARED min.cpp)
