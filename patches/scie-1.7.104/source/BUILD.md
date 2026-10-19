# Building the compatibility DLL

Visual Studio 2022 x64 (tested compiler 19.44), CMake 3.21+, Windows SDK.
Use the x64-windows-static-md triplet. Provide the CMake packages for spdlog,
fmt and directxtk and headers for rapidcsv and SimpleIni using CMAKE_PREFIX_PATH
or the vcpkg toolchain. The matching dependency source trees are included in
third_party; they can be built/installed independently into a staging prefix.
The original CommonLib vcpkg manifest is included for dependency information;
the supplied standalone build does not require its optional test dependencies.

Example with dependencies already installed:

    cmake -S . -B build -G "Visual Studio 17 2022" -A x64 -DCMAKE_PREFIX_PATH=<dependency-prefix>
    cmake --build build --config Release --target CraftingInventoryExtender

SCIE files are from commit 558ddd0c8026cb16bac0fb157cde23d9c0a3edb2 plus
SCIE-compatibility.patch. CommonLibSSE-NG source is from local checkout of
alandtse/CommonLibSSE-NG commit 94faaed0c60eddd8347767f2d4d29a97c93bde8c,
including the local CMake integration adjustment. MinHook is commit
c3fcafdc10146beb5919319d0683e44e3c30d537. Dependency source versions:
fmt 12.2.0, spdlog 1.17.0, DirectXTK May 2026, DirectXMath June 2026,
rapidcsv 9.07, SimpleIni 4.27. Headers used by CommonLib are included in its
source and extern directories. Windows SDK/compiler runtime components are
provided by the build tools, not redistributed here.

The tested installed DLL was built using the same SCIE sources and a local
static AE-only CommonLib build, not the portable project layout. The portable
layout is provided to reproduce the functionality from source; identical binary
hashes are not expected because paths, timestamps and compiler settings vary.

The public DLL differs from the locally tested DLL only in private build-root
strings in logging/debug metadata. The release notes document that processing
and executable sections/exports were checked with Python pefile.
Do not redistribute original SCIE assets or Address Library databases as part
of this patch. Keep the original MIT notice and all third-party license notices.
