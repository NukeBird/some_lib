project(test_lib)
set(CMAKE_DEBUG_POSTFIX d)

add_library(test_lib STATIC some_cool_source.h some_cool_source.cpp)


install(TARGETS test_lib
        LIBRARY DESTINATION lib)

install(FILES some_cool_source.h DESTINATION include)