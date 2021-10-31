mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=D:/qt_prerequirements -P ../install_prerequirements.cmake
cd ..
del /S /Q build
