# 在指定目录下寻找头文件和动态库文件的位置，可以指定多个目标路径
find_path(MIN_INCLUDE_DIR min.h /usr/include/ /usr/local/include ${CMAKE_SOURCE_DIR}/min_lib)
find_library(MIN_LIBRARY NAMES min PATHS /usr/lib/min /usr/local/lib/min ${CMAKE_SOURCE_DIR}/min_lib)

if (MIN_INCLUDE_DIR AND MIN_LIBRARY)
    set(MIN_FOUND TRUE)
endif (MIN_INCLUDE_DIR AND MIN_LIBRARY)
