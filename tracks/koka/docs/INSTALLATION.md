# Installation

This repository pins Koka with [mise](https://mise.jdx.dev).
From the repository root:

```sh
mise install
npx quest doctor
```

`mise install` downloads the prebuilt compiler named in `mise.toml` (Linux and macOS on x64 and arm64, Windows x64)
and verifies its checksum from `mise.lock`.

**Koka compiles to C, so it also needs a C compiler on the host**: `clang` or `gcc`.
On macOS run `xcode-select --install`; on Debian or Ubuntu, `sudo apt-get install build-essential`.

The first test run builds Koka's runtime into `.cache/build/koka/` and takes a few seconds; later runs reuse it.
