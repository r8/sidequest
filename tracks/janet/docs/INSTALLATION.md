# Installation

This repository pins Janet with [mise](https://mise.jdx.dev).
From the repository root:

```sh
mise install
npx quest doctor
```

`mise install` downloads the release binary named in `mise.toml` and verifies its checksum from `mise.lock`.
Linux x64, Apple Silicon and WSL2 use the upstream release assets directly.

To install Janet by other means, see the [official instructions](https://janet-lang.org/docs/index.html).
