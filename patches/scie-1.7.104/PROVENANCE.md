# Source provenance

The `source/` tree was copied from the source package prepared for Nexus patch r1.
It contains applied SCIE changes; **do not apply SCIE-compatibility.patch a second time**.

| Component | Origin / revision or version |
| --- | --- |
| SCIE | https://github.com/ohfor/scie — `558ddd0c8026cb16bac0fb157cde23d9c0a3edb2` plus `source/SCIE-compatibility.patch` |
| CommonLibSSE-NG | https://github.com/alandtse/CommonLibSSE-NG — `94faaed0c60eddd8347767f2d4d29a97c93bde8c`, with the local CMake integration adjustment preserved in the snapshot |
| MinHook | https://github.com/TsudaKageyu/minhook — `c3fcafdc10146beb5919319d0683e44e3c30d537` |
| fmt | https://github.com/fmtlib/fmt — 12.2.0 |
| spdlog | https://github.com/gabime/spdlog — 1.17.0 |
| DirectXTK | https://github.com/microsoft/DirectXTK — May 2026 snapshot |
| DirectXMath | https://github.com/microsoft/DirectXMath — June 2026 snapshot |
| rapidcsv | https://github.com/d99kris/rapidcsv — 9.07 |
| SimpleIni | https://github.com/brofield/simpleini — 4.27 |

The complete bundled trees and their file hashes are authoritative for this source
publication. Version labels alone should not be used to substitute a newer dependency.
The vendored CommonLib tree includes upstream documentation and agent guidance as
source material; those files are not build commands for this consumer project.

No proprietary Windows compiler or SDK sources are redistributed. Install Visual
Studio Build Tools and the Windows SDK as described in BUILDING.md.

## Build-only files restored during publication

The original source ZIP omitted directories named `build`, including upstream
CMake inputs (not generated outputs) in DirectXMath and DirectXTK. This checkout
restores their `build/` directories from the same local upstream source snapshots:
`directxmath` June 2026 and `directxtk` May 2026. All files already present in
those two original source trees were compared byte for byte with the donor trees
and matched. No SCIE or CommonLib C++ source was changed during publication.
The repository source tree is therefore a build-complete supplement to the r1
source ZIP, rather than a byte-identical copy of that archive.

`CommonLib-cmake-integration.patch` records the already-applied local CMake
adjustment against the CommonLib revision above. It is for review; do not reapply it.
`source-files.sha256` includes the restored build inputs as well as the original
source files. The release ZIP hashes in `release-manifest.json` still identify
the original Nexus r1 packages.

For archival fidelity, each vendored `.gitattributes` has a final `* -text`
rule appended. This prevents nested upstream line-ending rules from changing
the original source bytes when Git stages or checks out the snapshot. Only
these Git metadata files and the restored build inputs differ from the source
ZIP; existing C/C++ and build-source files remain unchanged.
