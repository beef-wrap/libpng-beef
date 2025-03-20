mkdir libs
mkdir libs\debug
mkdir libs\release

mkdir zlib\build
cd zlib\build

cmake .. -DZLIB_BUILD_SHARED=OFF

cmake --build .
copy Debug\zsd.lib ..\..\libs\debug\zlib.lib
copy Debug\zsd.pdb ..\..\libs\debug\zlibd.pdb

cmake --build . --config Release
copy Release\zs.lib ..\..\libs\release\zlib.lib

cd ..\..

mkdir libpng\build
cd libpng\build

cmake .. -DZLIB_LIBRARY=..\..\libs\debug\zlib.lib -DZLIB_INCLUDE_DIR=..\..\zlib

cmake --build .
copy Debug\libpng16_staticd.lib ..\..\libs\debug
copy Debug\libpng16_staticd.pdb ..\..\libs\debug

cmake --build . --config Release
copy Release\libpng16_static.lib ..\..\libs\release