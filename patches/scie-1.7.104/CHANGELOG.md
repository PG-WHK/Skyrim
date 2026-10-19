# Changes

## Source publication — 2026-10-20

- Publish the existing r1 patched SCIE source and matching dependency snapshots.
- Add a dependency-build script, detailed build instructions and release hashes.
- Restore upstream DirectXMath/DirectXTK build-script directories omitted from the
  original source ZIP; no plugin C++ changes. See PROVENANCE.md.
- No new compatibility DLL is substituted for the Nexus r1 binary by this publication.

## 2.6.0-r1 — 2026-10-18

- Rebuild against the updated CommonLibSSE-NG snapshot with runtime 1.7.104 and
  Address Library format-5 handling.
- Adapt cell-reference iteration callbacks to the updated pointer-based API, with null checks.
- Provide the original HUD notification helper API through the corresponding relocation IDs.
- Declare updated structures and runtime 1.7.104.0 in SKSE plugin metadata.
- Retain original SCIE crafting behavior and its MIT attribution.
- Package a replacement DLL and matching source with dependency license notices.

The published DLL had private build-root strings replaced with neutral same-length
strings in diagnostic metadata. The original packaging check verified that executable
sections and exported entry points were unchanged. This processing is disclosed; a
fresh source build is not claimed to be byte-identical to the released binary.
