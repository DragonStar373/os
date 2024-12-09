cmake_minimum_required(VERSION 3.28)
project(os)

set(CMAKE_CXX_STANDARD 14)

add_executable(os
        learn/trial2/boot.asm
        learn/trial2/kernel.cpp
        learn/trial2/kernel_entry.asm
        learn/trial2/zeroes.asm
        learn/trial2/CAString.cpp
        learn/trial2/CAString.h
        learn/trial2/kernal-backup-1.cpp
        learn/trial2/save_for_later....cpp)
