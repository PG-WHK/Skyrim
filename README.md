# Skyrim
Source code and build instructions for my Skyrim SE compatibility patches.

## Patches

| Patch | Supported runtime | Source and build instructions |
| --- | --- | --- |
| SCIE unofficial compatibility patch 2.6.0-r1 | Skyrim SE Steam 1.7.104.0 | [Project](patches/scie-1.7.104/README.md) · [Build](patches/scie-1.7.104/BUILDING.md) |

The SCIE directory includes the patched native-plugin source and vendored dependency
sources. A reviewer can build it without cloning submodules or downloading a prebuilt
CommonLib binary. The original SCIE mod is still required to use the resulting DLL.

Each project and vendored component retains its own license. See the project's
license notice rather than assuming one license covers every file in this repository.
