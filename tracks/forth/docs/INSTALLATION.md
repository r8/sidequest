# Installation

mise does not provide gforth, so install it with your system's package manager.
`tracks/forth/quest.json` pins **gforth 0.7.3**, and `npx quest doctor` refuses to run the Forth tests on any
other version.

- macOS: `brew install gforth`
- Debian, Ubuntu, WSL2: `sudo apt-get install gforth`

Then, from the repository root:

```sh
npx quest doctor
```

CI installs it with the `toolchain.ci.install` recipe in `quest.json`.
