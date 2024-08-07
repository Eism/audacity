
set(APP_BIN "" CACHE STRING "Path to app binary")
set(ARCH "" CACHE STRING "System architecture")
set(GENERATE_ARCHS "" CACHE STRING "Generate symbols for architectures")
set(BUILD_DIR "${CMAKE_SOURCE_DIR}/build.release" CACHE STRING "Path to build directory")

set(REMOTE_ROOT_URL https://raw.githubusercontent.com/musescore/framework_tmp/main/buildscripts/ci/crashdumps)
set(LOCAL_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR}/_deps)

file(DOWNLOAD ${REMOTE_ROOT_URL}/ci_files.cmake ${LOCAL_ROOT_PATH}/ci_files.cmake)

include(${LOCAL_ROOT_PATH}/ci_files.cmake)

foreach(FILE_PATH ${CI_FILES})
    file(DOWNLOAD ${REMOTE_ROOT_URL}/${FILE_PATH} ${LOCAL_ROOT_PATH}/${FILE_PATH})
endforeach()

set(CONFIG
    -DAPP_BIN=${APP_BIN}
    -DARCH=${ARCH}
    -DGENERATE_ARCHS=${GENERATE_ARCHS}
    -DBUILD_DIR=${BUILD_DIR}
)

execute_process(
    COMMAND cmake ${CONFIG} -P ${LOCAL_ROOT_PATH}/ci_generate_dumpsyms.cmake
)
