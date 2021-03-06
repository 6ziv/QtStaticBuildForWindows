find_program(NMAKE_COMMAND NAMES nmake REQUIRED)
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
message(FATAL_ERROR "installation path not defined")
endif()
file(DOWNLOAD "https://github.com/madler/zlib/archive/refs/tags/v1.2.11.tar.gz" zlib-v1.2.11.tar.gz)
execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf zlib-v1.2.11.tar.gz)
if(NOT DEFINED DEBUG_BUILD)
execute_process(COMMAND ${NMAKE_COMMAND} -f win32/Makefile.msc "CFLAGS=/MT /W3 /O2" "LDFLAGS=/NOLOGO" "ARFLAGS=/NOLOGO /LTCG" WORKING_DIRECTORY zlib-1.2.11)
else()
execute_process(COMMAND ${NMAKE_COMMAND} -f win32/Makefile.msc "CFLAGS=/MTd /W3 /O2" "LDFLAGS=/NOLOGO" "ARFLAGS=/NOLOGO /LTCG" WORKING_DIRECTORY zlib-1.2.11)
endif()
file(MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/zlib")
file(MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/zlib/include")
file(MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/zlib/lib")
file(COPY zlib-1.2.11/zlib.lib DESTINATION "${CMAKE_INSTALL_PREFIX}/zlib/lib")
file(COPY zlib-1.2.11/zlib.h zlib-1.2.11/zconf.h DESTINATION "${CMAKE_INSTALL_PREFIX}/zlib/include")
file(COPY ${CMAKE_SCRIPT_MODE_FILE}/../etc/zlib.pc DESTINATION "${CMAKE_INSTALL_PREFIX}/zlib")