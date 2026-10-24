# Installation

mise does not provide Inko, so install it with your system's package manager.
`tracks/inko/quest.json` pins **Inko 0.21.1**, and `npx quest doctor` refuses to run the Inko tests on any
other version.

**Inko runs on Linux, macOS 15 or newer, and FreeBSD. It does not support Windows** (WSL2 counts as Linux),
and `npx quest doctor` says so on any other platform.

- macOS: `brew install inko`
- Arch Linux: the `inko` package from the AUR
- Fedora: the `yorickpeterse/inko` Copr repository
- From source: [ivm](https://docs.inko-lang.org/manual/latest/setup/ivm/), which needs Rust and LLVM

Then, from the repository root:

```sh
npx quest doctor
```

CI does not install Inko: it builds and runs the tests inside the official `ghcr.io/inko-lang/inko` image named
by `toolchain.ci.image` in `quest.json`.
