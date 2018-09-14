cmake_minimum_required(VERSION 3.7)

project("compiler_settings" CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(compiler_settings)

# set standard, without extensions
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)


add_executable(simple_main test/success/simple_main.cpp)
add_executable(local_adress test/fail/local_adress.cpp)
add_executable(sign_conversion test/warn/sign_conversion.cpp)
add_executable(return_type test/fail/return_type.cpp)
add_executable(format test/fail/format.cpp)
add_executable(throw_spec test/warn/throw_spec.cpp)
add_executable(nullptr test/warn/nullptr.cpp)
add_executable(debug_iterator test/success/debug_iterator)
target_compile_definitions(debug_iterator PUBLIC ${ADMONITIONS_DEF_DEBUG_ITERATORS})
