
# Copyright (C) 2010 RobotCub Consortium
# Author: Matteo Fumagalli, Marco Randazzo
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

project(wholeBodyDynamics)

file(GLOB folder_source main.cpp observerThread.cpp)
file(GLOB folder_header observerThread.h)

# import math symbols from standard cmath
add_definitions(-D_USE_MATH_DEFINES)
add_executable(${PROJECT_NAME} ${folder_source} ${folder_header})
target_link_libraries(${PROJECT_NAME} iDyn
                                      ${YARP_LIBRARIES}
                                      skinDynLib)
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

