# Installation

There is no Homebrew or apt package for CBQN; build it from source. `tracks/bqn/quest.json` pins the CBQN
**commit**, and `npx quest doctor` refuses to run the BQN tests on any other build.

```sh
git clone https://github.com/dzaima/CBQN ~/src/CBQN
git -C ~/src/CBQN checkout b62079a405b1c05948ce8dc7be7a7bf4577679cd
make -C ~/src/CBQN
sudo cp ~/src/CBQN/BQN /usr/local/bin/bqn
npx quest doctor
```

Nix (`nix profile install nixpkgs#cbqn`) and the AUR (`cbqn-git`) also package it, at whatever commit they carry.
CI runs the same clone-and-make, cached, through the `toolchain.ci.install` recipe in `quest.json`.
