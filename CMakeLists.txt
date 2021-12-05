# 设置cmake最低版本
cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

# 设置项目名
project(helloworld LANGUAGES CXX)

# 设置变量
set(DUMMY ON)
set(ADD_LIB_BUILD_PATH add_lib_path)

# 定义宏
ADD_DEFINITIONS( -Wall )

# 可执行文件名
add_executable(main main.cpp)

# 添加头文件搜索目录
include_directories(./max_lib ./add_lib)

# 显示动态库
add_library(max SHARED max_lib/max.cpp)

# 显示静态库
# add_library(add STATIC add_lib/add.cpp)

# 添加子项目, 生成的库会在BUILD_RPATH里
add_subdirectory(./add_lib ${ADD_LIB_BUILD_PATH})

# 链接库
target_link_libraries(main add max)

