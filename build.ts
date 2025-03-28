import { type Build } from 'xbuild';

const build: Build = {
    common: {
        project: 'libpng',
        archs: ['x64'],
        variables: [
            ['ZLIB_LIBRARY', '${CMAKE_SOURCE_DIR}/../../zlib', true],
            ['ZLIB_INCLUDE_DIR', '${CMAKE_SOURCE_DIR}/../../zlib', true]
        ],
        copy: {},
        defines: [],
        options: [
            ['ZLIB_BUILD_SHARED', false],
        ],
        subdirectories: ['libpng', 'zlib'],
        libraries: {
            png_static: {
                name: 'libpng'
            },
            zlibstatic: {
                name: 'zlib'
            }
        },
        buildDir: 'build',
        buildOutDir: '../libs',
        buildFlags: []
    },
    platforms: {
        win32: {
            windows: {},
            android: {
                archs: ['x86', 'x86_64', 'armeabi-v7a', 'arm64-v8a'],
            }
        },
        linux: {
            linux: {}
        },
        darwin: {
            macos: {}
        }
    }
}

export default build;