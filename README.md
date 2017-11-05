## Requirements

This project depends on `git` and [`rcm`](http://thoughtbot.github.io/rcm/).

## Installation

1. Clone this repo to *~/.dotfiles*.

On the first run:

```sh
env RCRC=$HOME/.dotfiles/rcrc rcup
```

On subsequent runs: `rcup`

## OS X

The following packages are required for OS X (I install them with homebrew):

```sh
brew install reattach-to-user-namespace
```

## Random

To swap alt/win for an Apple keyboard:

```
xkb_symbols   { include "pc+us+gr(polytonic):2+inet(evdev)+group(shifts_toggle)+ctrl(nocaps)+altwin(swap_alt_win)+typo(base):1+typo(base):2+my-symbols(hypers)" };
```
