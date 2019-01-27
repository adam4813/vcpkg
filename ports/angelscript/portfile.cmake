# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO adam4813/angelscript
    REF v2.33
    SHA512 1c2c81432656b24a73714db45f124fa3f9fa4be5e5a61f2e72acaa6ff07db7d4c843871326811dd47e641530116cc880ee37dc2087c73fd483205a1fa1a1b359
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/sdk/angelscript/projects/cmake
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/angelscript")

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${CURRENT_PORT_DIR}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/angelscript RENAME copyright)
# Copy the addon files
file(INSTALL ${SOURCE_PATH}/sdk/add_on/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/angelscript FILES_MATCHING PATTERN "*.h" PATTERN "*.cpp")
#file(INSTALL ${CURRENT_PACKAGES_DIR}/include/angelscript.hpp DESTINATION ${CURRENT_PACKAGES_DIR}/include/angelscript)
