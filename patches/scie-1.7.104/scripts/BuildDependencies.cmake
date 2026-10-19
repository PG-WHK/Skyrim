cmake_minimum_required(VERSION 3.21)

get_filename_component(PATCH_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)
set(SOURCE_ROOT "${PATCH_ROOT}/source")
if(NOT DEFINED DEPENDENCY_BUILD_ROOT)
    set(DEPENDENCY_BUILD_ROOT "${PATCH_ROOT}/build/dependencies")
endif()
if(NOT DEFINED DEPENDENCY_PREFIX)
    set(DEPENDENCY_PREFIX "${PATCH_ROOT}/build/prefix")
endif()
if(NOT DEFINED BUILD_GENERATOR)
    set(BUILD_GENERATOR "Visual Studio 17 2022")
endif()
if(NOT DEFINED BUILD_JOBS)
    set(BUILD_JOBS 4)
endif()

function(run_checked)
    execute_process(COMMAND ${ARGV} RESULT_VARIABLE result)
    if(NOT result EQUAL 0)
        message(FATAL_ERROR "Dependency command failed (${result}): ${ARGV}")
    endif()
endfunction()

function(build_dependency name)
    set(source "${SOURCE_ROOT}/third_party/${name}")
    set(binary "${DEPENDENCY_BUILD_ROOT}/${name}")
    run_checked("${CMAKE_COMMAND}" -S "${source}" -B "${binary}"
        -G "${BUILD_GENERATOR}" -A x64
        "-DCMAKE_INSTALL_PREFIX=${DEPENDENCY_PREFIX}"
        "-DCMAKE_PREFIX_PATH=${DEPENDENCY_PREFIX}"
        -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreadedDLL
        -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTING=OFF ${ARGN})
    run_checked("${CMAKE_COMMAND}" --build "${binary}" --config Release
        --parallel "${BUILD_JOBS}")
    run_checked("${CMAKE_COMMAND}" --install "${binary}" --config Release)
endfunction()

build_dependency(fmt -DFMT_TEST=OFF -DFMT_DOC=OFF -DFMT_INSTALL=ON)
build_dependency(spdlog -DSPDLOG_FMT_EXTERNAL=ON -DSPDLOG_BUILD_TESTS=OFF
    -DSPDLOG_BUILD_EXAMPLE=OFF -DSPDLOG_INSTALL=ON)
build_dependency(directxmath -DBUILD_XDSP=OFF -DBUILD_SHMATH=OFF)
build_dependency(directxtk -DBUILD_TOOLS=OFF -DBUILD_XAUDIO_WIN8=OFF
    -DBUILD_XAUDIO_WIN10=OFF -DBUILD_XAUDIO_REDIST=OFF)

file(MAKE_DIRECTORY "${DEPENDENCY_PREFIX}/include")
file(COPY "${SOURCE_ROOT}/third_party/rapidcsv/src/rapidcsv.h"
    "${SOURCE_ROOT}/third_party/simpleini/SimpleIni.h"
    DESTINATION "${DEPENDENCY_PREFIX}/include")
message(STATUS "Dependencies installed to ${DEPENDENCY_PREFIX}")
