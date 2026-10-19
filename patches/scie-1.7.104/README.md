# SCIE — unofficial Skyrim 1.7.104 compatibility patch

**Release:** 2.6.0-r1, packaged on 2026-10-18. Source published for review on 2026-10-20.

- [Nexus patch page](https://www.nexusmods.com/skyrimspecialedition/mods/195830)
- [Original SCIE 2.6.0.0 by ohfor](https://www.nexusmods.com/skyrimspecialedition/mods/170497)
- [Complete build instructions](BUILDING.md)
- [Changes](CHANGELOG.md) · [Source provenance](PROVENANCE.md) · [Licensing](LICENSE-NOTICE.md)

## Purpose

This patch replaces `SKSE/Plugins/CraftingInventoryExtender.dll` from Skyrim Crafting
Inventory Extender (SCIE) 2.6.0.0. It adapts the native plugin to Skyrim Special Edition
Steam runtime **1.7.104.0**, addressing the address-library startup failure reproduced
on that runtime. It is an unofficial compatibility adaptation, not a standalone mod
and not an endorsement by the original author.

## Contents for reviewers

- `source/SCIE/`: complete native SCIE source used for this patch, with modifications applied.
- `source/SCIE-compatibility.patch`: human-readable changes against the original SCIE commit.
- `CommonLib-cmake-integration.patch`: the already-applied CommonLib CMake change.
- `source/CommonLibSSE-NG/`: the matching library source snapshot, including its local CMake adjustment.
- `source/MinHook/` and `source/third_party/`: dependency source trees.
- `source/Licenses/`: original license notices, CommonLib GPL text and exceptions.
- `scripts/BuildDependencies.cmake`: builds the bundled dependencies into a local staging prefix.
- `release-manifest.json`: hashes of the existing r1 release files and source package.
- `source-files.sha256`: hashes of the source snapshot included with this repository.

There are no Git submodules. Generated binaries, build caches, game executables,
Address Library databases, saves, credentials and the original mod's ESP/assets are
not part of this source publication. Existing third-party SDK/source-tree assets
remain under their respective notices.

## Runtime requirements and installation

1. Install the original **SCIE 2.6.0.0** and its requirements.
2. Use Skyrim SE Steam **1.7.104.0**, matching SKSE64 **2.3.1**, and its official Address Library.
3. Install the compatibility DLL as a separate mod after SCIE (and Babel, if used).
4. Keep the original SCIE plugins, scripts, configuration and translations.

Only the DLL is replaced. No ESP is added and no Pandora/Nemesis generation is needed.
Do not rename or copy another runtime's Address Library database to satisfy the plugin.
Disable this separate compatibility mod to restore the original DLL.

## Scope and validation

The changes update runtime/address-library handling through the bundled CommonLib,
adapt cell-reference callbacks, preserve the notification helper API and declare
1.7.104.0 explicitly in SKSE plugin metadata. The crafting feature logic is retained.

The original r1 work included successful compilation and an address-library lookup
check against the installed 1.7.104 database. The user reported successful in-game
testing on one installation. Other runtimes, VR and other SCIE versions are not
declared supported. This is not a broad gameplay or compatibility certification.

The original release was linked using a local build arrangement. This repository adds
a self-contained build arrangement for reviewers; see BUILDING.md for the precise
relationship to that release and the latest clean-build verification.

## Credits

SCIE: ohfor. CommonLibSSE-NG, MinHook, fmt, spdlog, DirectXTK, DirectXMath,
rapidcsv, SimpleIni and SKSE contributors retain their respective credits.
Compatibility adaptation, documentation and packaging were assisted by OpenAI Codex.
