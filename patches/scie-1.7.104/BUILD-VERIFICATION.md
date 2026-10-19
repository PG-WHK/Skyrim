# Local clean-build verification

Date: 2026-10-20 (Asia/Seoul).

## Environment

- Windows x64; Visual Studio Build Tools 2022.
- CMake 3.31.6-msvc6, Visual Studio 17 2022 generator, x64 architecture.
- MSVC compiler 19.44.35229.0 (v143 tools 14.44.35207).
- Windows SDK 10.0.26100.0; SDK FXC used for DirectXTK shaders.
- Release libraries and plugin; dynamic MSVC runtime (/MD).
- COMMONLIB_ENABLE_IPO=OFF, CMAKE_CXX_FLAGS=/MP4, build parallelism 4.

## Results

| Check | Result |
| --- | --- |
| Build/install fmt and spdlog from bundled source | PASS |
| Install bundled DirectXMath and build/install DirectXTK with shaders | PASS |
| Stage rapidcsv and SimpleIni headers | PASS |
| Configure standalone SCIE/CommonLib/MinHook project | PASS |
| Compile and link CraftingInventoryExtender target | PASS |
| Inspect SKSE exports with Microsoft dumpbin | PASS |
| Reverse-check SCIE and CommonLib patches on temporary LF copies | PASS |

The commands in BUILDING.md were used in a new build directory. No precompiled
CommonLib or dependency libraries from the original workstation build were used.
The first sandboxed build stalled; running the same build tools with execution
access succeeded. Missing upstream build-script inputs in the old source ZIP were
restored as documented in PROVENANCE.md before the successful build.

Output: `build/plugin/Release/CraftingInventoryExtender.dll`

- Size: **1,040,384 bytes**.
- SHA-256: `729879f69ab38f76e6a5a641f84650812be54be80873c03a260aac70f5ac2e49`
- Exported entry points: `SKSEPlugin_Load`, `SKSEPlugin_Query`, `SKSEPlugin_Version`.
- Imports include Windows and Visual C++ runtime DLLs; no fmt/spdlog/DirectXTK DLL
  imports were present. Those dependencies were built as static libraries.

This is a compilation/link verification. The verification DLL was not installed
or launched in game, and it is not substituted for the existing Nexus r1 binary.
The original r1 release hashes are separately recorded in release-manifest.json.
Different build settings and diagnostic-path sanitization mean those hashes differ.
The original r1 runtime evidence is described in README.md.

Build logs and binaries stay in ignored `build/` directories and are not committed.
