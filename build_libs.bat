clang -c -g -gcodeview -o libpng-windows.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall libpng\libpng.c

mkdir libs
move libpng-windows.lib libs
