# Build SCIE compatibility patch from source

These instructions build `CraftingInventoryExtender.dll` for Windows x64 and Skyrim
SE Steam **1.7.104.0**. They use only the source snapshots committed to this repository
plus the Microsoft compiler and Windows SDK. No game installation is needed to compile.

## 1. Install tools

- Windows 10/11 x64.
- Visual Studio 2022 or Build Tools 2022, **Desktop development with C++** workload.
- MSVC v143 x64/x86 tools (the original r1 build used compiler **19.44**).
- Windows 10/11 SDK, including the legacy **FXC** shader compiler required by DirectXTK.
- CMake **3.21 or newer**; the local verification uses the CMake shipped with Build Tools.
- Git to clone the repository. Git submodules and vcpkg are not required.

Open **Developer PowerShell for VS 2022**. Check:

```powershell
cmake --version
cl
```

`cl` without arguments prints compiler information and may return a nonzero status;
it is only a tool-availability check. If `cmake` is not found, enable Visual Studio's
C++ CMake tools or add the CMake executable to PATH.

## 2. Get the source

```powershell
git clone https://github.com/PG-WHK/Skyrim.git
cd Skyrim/patches/scie-1.7.104
```

All dependencies are regular directories in `source/`. Do not run submodule commands,
apply `SCIE-compatibility.patch` again or replace the bundled CommonLib with a prebuilt binary.

## 3. Build the bundled dependencies

```powershell
cmake -P scripts/BuildDependencies.cmake
```

The script builds/installs the Release static libraries for fmt, spdlog and DirectXTK,
installs DirectXMath, and stages the rapidcsv and SimpleIni headers. The MSVC runtime
is dynamic **/MD** (`MultiThreadedDLL`), matching `x64-windows-static-md` semantics.

- Dependency build trees: `build/dependencies/`
- Staging prefix: `build/prefix/`
- Default generator: `Visual Studio 17 2022`, architecture `x64`
- Default parallel jobs: `4`

There are no dependency network downloads in this script. Windows SDK/compiler
installation is a prerequisite. The first DirectXTK build also compiles its shaders.

## 4. Configure and compile the plugin

Run these from the same `patches/scie-1.7.104` directory:

```powershell
$dependencyPrefix = Join-Path $PWD 'build/prefix'
cmake -S source -B build/plugin -G "Visual Studio 17 2022" -A x64 "-DCMAKE_PREFIX_PATH=$dependencyPrefix" -DCOMMONLIB_ENABLE_IPO=OFF -DCMAKE_CXX_FLAGS=/MP4
cmake --build build/plugin --config Release --target CraftingInventoryExtender --parallel 4
```

Every command must succeed before continuing. `COMMONLIB_ENABLE_IPO=OFF` speeds up
the review build; `/MP4` limits MSVC source compilation parallelism. These are build
settings and do not expand the declared game-runtime support.

The top-level `source/CMakeLists.txt` forces AE-only CommonLib layout, disables SE/VR
and tests, enables branch-site patch safety and points the hde64 FetchContent input
at the bundled MinHook source. It links MinHook and the required Windows system libraries.

Expected output:

```text
build/plugin/Release/CraftingInventoryExtender.dll
```

Hash the result if desired:

```powershell
Get-FileHash build/plugin/Release/CraftingInventoryExtender.dll -Algorithm SHA256
```

## 5. Use and verify in game

Install original SCIE 2.6.0.0 and its requirements, then place the built DLL at
`Data/SKSE/Plugins/CraftingInventoryExtender.dll` through a separate mod after SCIE.
Use matching SKSE64 2.3.1 and the official Address Library for 1.7.104.

Launch through SKSE, check that its log reports no load rejection, inspect the SCIE
plugin log, and test crafting with linked container inventories. Compilation proves
the source builds; it does not replace runtime testing. No game is launched or mod
installed by these build commands.

## Troubleshooting

- **No VS 2022 generator / compiler:** install the v143 C++ workload and x64 tools.
- **FXC / generated shader include errors:** install the SDK shader tools and use a
  Developer PowerShell with the SDK tools available.
- **Cannot find spdlog/directxtk:** finish step 3 and point `CMAKE_PREFIX_PATH` to
  this checkout's `build/prefix`, not a prefix from another machine.
- **Missing SimpleIni.h / rapidcsv.h:** step 3 stages both into `build/prefix/include`.
- **CRT mismatch:** keep dependencies and plugin in Release with /MD. Do not mix
  libraries from an unrelated /MT or Debug build.
- **Long CommonLib compile:** it contains many source files. Allow the full build
  to complete; no precompiled CommonLib library is required.

## Relationship to the uploaded r1 DLL

The original r1 DLL was built with the SCIE source in this snapshot and a matching
local static CommonLib/dependency build. The source package's original `source/BUILD.md`
records that arrangement. This repository adds an explicit from-source dependency
preparation procedure so a reviewer does not need that original workstation layout.

The r1 binary also had private build-root strings sanitized in diagnostic metadata,
as described in CHANGELOG.md. Different paths, toolchains, timestamps, optimization
settings and that sanitization mean **byte-identical DLL hashes are not promised**.
`release-manifest.json` identifies the existing release; this publication does not
silently replace its DLL with the new verification build.

## Clean-build verification for this publication

The result of the local clean build is recorded in `BUILD-VERIFICATION.md` after
running the commands above. Review that file for the actual toolchain and outcome.
