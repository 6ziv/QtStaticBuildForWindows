find_program(NMAKE_COMMAND NAMES nmake REQUIRED)
find_program(CC NAMES cl REQUIRED)
find_program(LIB NAMES lib REQUIRED)
find_program(PERL_COMMAND NAMES perl REQUIRED)
find_program(NASM_COMMAND NAMES nasm REQUIRED)
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
message(FATAL_ERROR "installation path not defined")
endif()
execute_process(COMMAND ${CC} ${CMAKE_SCRIPT_MODE_FILE}/../etc/pointer_width.c /Fepointer_width.exe)
execute_process(COMMAND pointer_width.exe RESULT_VARIABLE POINTER_WIDTH)
if(${POINTER_WIDTH} EQUAL 8)
set(OPENSSL_TARGET VC-WIN64A)
elseif(${POINTER_WIDTH} EQUAL 4)
set(OPENSSL_TARGET VC-WIN32)
else()
message(FATAL_ERROR "Unknown pointer width")
endif()
file(DOWNLOAD https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1l.tar.gz OpenSSL_1_1_1l.tar.gz)
execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf OpenSSL_1_1_1l.tar.gz)
file(MAKE_DIRECTORY openssl-OpenSSL_1_1_1l/build)
if(NOT DEFINED DEBUG_BUILD)
execute_process(
	COMMAND ${PERL_COMMAND} ../Configure --prefix=${CMAKE_INSTALL_PREFIX}/openssl --openssldir=${CMAKE_INSTALL_PREFIX}/openssl --release --with-zlib-include="${CMAKE_INSTALL_PREFIX}/zlib/include" --with-zlib-lib="${CMAKE_INSTALL_PREFIX}/zlib/lib/zlib.lib" no-shared zlib "ARFLAGS=/NOLOGO /LTCG" "CFLAGS=/MT /W3 /O2" "CXXFLAGS=/MT /W3 /O2" ${OPENSSL_TARGET}
	WORKING_DIRECTORY openssl-OpenSSL_1_1_1l/build
)
else()
execute_process(
	COMMAND ${PERL_COMMAND} ../Configure --prefix=${CMAKE_INSTALL_PREFIX}/openssl --openssldir=${CMAKE_INSTALL_PREFIX}/openssl --debug --with-zlib-include="${CMAKE_INSTALL_PREFIX}/zlib/include" --with-zlib-lib="${CMAKE_INSTALL_PREFIX}/zlib/lib/zlib.lib" no-shared zlib "ARFLAGS=/NOLOGO /LTCG" "CFLAGS=/MTd /W3 /O2" "CXXFLAGS=/MTd /W3 /O2" ${OPENSSL_TARGET}
	WORKING_DIRECTORY openssl-OpenSSL_1_1_1l/build
)
endif()
execute_process(
	COMMAND ${NMAKE_COMMAND}
	WORKING_DIRECTORY openssl-OpenSSL_1_1_1l/build
)
execute_process(
	COMMAND ${NMAKE_COMMAND} install
	WORKING_DIRECTORY openssl-OpenSSL_1_1_1l/build
)
execute_process(
	COMMAND ${LIB} /OUT:${CMAKE_INSTALL_PREFIX}/openssl/lib/libssl.lib ${CMAKE_INSTALL_PREFIX}/openssl/lib/libssl.lib ${CMAKE_INSTALL_PREFIX}/zlib/lib/zlib.lib
)