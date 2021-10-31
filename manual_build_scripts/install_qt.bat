set SAVED_CD=%CD%
cd /d %1
mkdir build
cd build
cmd /c ..\configure --prefix=D:/Qt -static -static-runtime -release -qt-doubleconversion -DQT_FEATURE_qt3d_qt_assimp=ON -DQT_FEATURE_qtquick3d_qt_assimp=ON -qt-tiff -qt-webp -qt-sqlite -qt-libpng -qt-libjpeg -qt-freetype -qt-harfbuzz -qt-pcre -qt-zlib -openssl -openssl-linked -ltcg -no-pch -no-dbus -ID:/qt_prerequirements/openssl/include -LD:/qt_prerequirements/openssl/lib -ID:/qt_prerequirements/zlib/include -LD:/qt_prerequirements/zlib/lib -- -DOPENSSL_USE_STATIC_LIBS=ON -DCMAKE_PREFIX_PATH="D:/qt_prerequirements/zlib;D:/qt_prerequirements/OpenSSL"
cmake --build . --parallel
cmake --install .
cd /d %SAVED_CD%
