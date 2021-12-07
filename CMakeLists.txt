# 设置cmake最低版本
cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

# 设置项目名
project(helloworld LANGUAGES CXX)

# 设置C++的版本
set(CMAKE_CXX_STANDARD 17)
set(ADD_LIB_BUILD_PATH add_lib_path)

# 定义宏
ADD_DEFINITIONS( -Wall )

# 可执行文件名
add_executable(main main.cpp)

# 添加头文件搜索目录
# include_directories(./max_lib ./add_lib)
target_include_directories(main PRIVATE ${CMAKE_SOURCE_DIR}/max_lib ${CMAKE_SOURCE_DIR}/add_lib)

# 添加动态库
add_library(max SHARED ${CMAKE_SOURCE_DIR}/max_lib/max.cpp)

# 添加静态库
# add_library(add STATIC add_lib/add.cpp)

# 添加子项目, 生成的库会在BUILD_RPATH里
add_subdirectory(${CMAKE_SOURCE_DIR}/add_lib ${ADD_LIB_BUILD_PATH} EXCLUDE_FROM_ALL)

# 链接库
target_link_libraries(main add max)

#############################################
# find_package 示例
find_package(CURL)
add_executable(curltest curltest.cpp)

if(CURL_FOUND)
    target_include_directories(curltest PRIVATE ${CURL_INCLUDE_DIR})
    target_link_libraries(curltest ${CURL_LIBRARY})
else(CURL_FOUND)
    message(FATAL_ERROR ”CURL library not found”)
endif(CURL_FOUND)

#############################################
# 自定义find_package 示例
# 将项目目录下的cmake文件夹加入到CMAKE_MODULE_PATH中，让find_pakcage能够找到我们自定义的函数库
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
add_executable(mintest mintest.cpp)
find_package(MIN)

if(MIN_FOUND)
    target_include_directories(mintest PRIVATE ${MIN_INCLUDE_DIR})
    target_link_libraries(mintest ${MIN_LIBRARY})
else(MIN_FOUND)
    message(FATAL_ERROR "MIN library not found")
endif(MIN_FOUND)

#############################################

# 需要先下载spdlog库，手动编译后，配合cmake/spdlog.cmake 文件才能完成编译
# add_definitions(-std=c++11)  # 指定采用c++11进行编译（spdlog需要c++11）
# add_executable(test_spdlog spdlogtest.cpp)

# set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
# include(spdlog)

# target_link_libraries(test_spdlog ${SPDLOG_LIB})
# target_include_directories(test_spdlog PRIVATE ${SPDLOG_INCLUDE_DIR})

#############################################

# 通过cmake/spdlog2.cmake的配置，直接从github上下载spdlog库，然后进行编译

# add_definitions(-std=c++11)  # 指定采用c++11进行编译（spdlog需要c++11）
add_executable(test_spdlog spdlogtest.cpp)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
include(spdlog2)

target_link_libraries(test_spdlog PRIVATE spdlog)

#############################################

# 设置变量
set(TEST "Local Var" ON)
#set(TEST "Parent scope Var" ON PARENT_SCOPE)

# 若是第一次运行，将给TEST赋值为ON; 若不是，则不会修改。注意，这里即使手动改成ON->OFF，也不会修改Cache里面的值，除非手动删除CMakeCache.txt
set(TEST "Cache Var" CACHE BOOL ON)

# 通过添加FORCE，可以强制刷新Cache的值，避免上述”奇怪“的现象
set(TEST "Local Var" CACHE BOOL FORCE ON)

# 使用 $ENV {NAME} 可以调用系统的环境变量
set(MY_HOME $ENV{HOME})

# 打印信息
message("MY_HOME: ${MY_HOME}")

set(USE_LIB "Whether use lib to link matrix_test" ON)

if(USE_LIB)
    message("use libarary")
else()
    message("not use libarary")
endif(USE_LIB)

# 可以通过cmake .. -D USE_OPT_LIB=OFF改变变量的值
option(USE_OPT_LIB "Whether use lib to link matrix_test" ON)

if(USE_OPT_LIB)
    message("use opt libarary")
else()
    message("not use opt libarary")
endif(USE_OPT_LIB)

# Debug 对应的是 -g，Release 对应的则是 -03 -DNDEBUG
set(CMAKE_BUILD_TYPE CACHE STRING "Build Type" FORCE Release)

#############################################
