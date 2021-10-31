Qt 6.2.0 static build for windows.



This is maintained for my own convenience. So only a few versions are supported, and the robustness of the scripts is not guaranteed.

Currently, release build of Qt 6.2.0 64 bit is provided.

You can refer to the build scripts for details.

Note that build script does not work well on Qt 6.1.3 and earlier. When building, interrupt the build procedure when CMake starts, and call CMake manually, with CMAKE_PREFIX_PATH properly set. (seems that configure.bat splits CMAKE_PREFIX_PATH into multiple arguments).





I need this to help my project build on AppVeyor. On other circumstances, it is advised to use [vcpkg](https://vcpkg.io).

