# The Moving Parts

**Outcome:** you can name each part of
a Homebrew installation, say what it
holds, and point at where it lives on
disk.

**Check:** given a path inside a brew
prefix — a formula file, a Cellar
directory, a name in `bin` — you can
say which part it belongs to and what
put it there.

## The program itself: a git checkout

Homebrew is written mostly in Ruby, and
an installation is, at its heart, a
**git checkout** of the project's own
repository. This is not an
implementation detail; it explains half
of brew's behaviour. Updating brew is a
`git pull`. The version it reports
comes from the checkout's history. And
the documentation — including the
cookbooks this guide quotes — ships
inside the repository, in its `docs`
folder, which is where this guide's lab
read it.

The checkout lives inside the
installation's root folder, the
**prefix**:

| System | Default prefix |
| --- | --- |
| macOS, Apple Silicon | `/opt/homebrew` |
| macOS, Intel | `/usr/local` |
| Linux and WSL 2 | `/home/linuxbrew/.linuxbrew` |

Inside the prefix, the checkout sits in
a folder of its own (`Homebrew` on a
normal install), and everything else in
the prefix is arranged around it.

## Formulae: recipes, not packages

A **formula** is a small Ruby file that
describes one piece of software: where
its source lives, the checksum that
proves the download is the right one,
what it depends on, how to build and
install it, and a little test brew can
run afterwards. This guide's lab read a
real one end to end — jq's — and its
opening lines are the shape of every
formula:

```ruby
class Jq < Formula
  desc "Lightweight and flexible command-line JSON processor"
  homepage "https://jqlang.github.io/jq/"
  url "https://github.com/jqlang/jq/releases/download/jq-1.8.2/jq-1.8.2.tar.gz"
  sha256 "71b8d6e8f5fe81f6c6d0d110e3892251f6ce76ed095abd315e26e6e1193af3af"
  license "MIT"
```

You do not normally download formulae
one at a time. They arrive in **taps**
(below), and the default tap, called
**homebrew/core**, holds the official
catalogue. On a modern install brew
usually reads core's catalogue through
an API rather than keeping the whole
repository cloned, but the formula file
remains the source of truth — the same
file the lab read.

## Bottles: somebody else's build

Building every program from source
would be slow and fragile, so most
formulae also publish a **bottle**: a
prebuilt archive of the finished
installation, made by the project's
build robots for each supported system.
jq's formula carries a bottle block
listing one checksum per platform —
including, the lab noted, one labelled
`x86_64_linux`, which is why jq is this
guide's worked example: on a Linux
machine like the lab's, `brew install
jq` would have poured that bottle
rather than compiling anything.

When a bottle exists for your machine,
installing is mostly unpacking. When
none does, brew falls back to the
formula's build instructions, which is
slower and needs a working compiler.
Chapter 12 is honest about which of
those you can count on.

## The Cellar: where versions live

Installed software is not scattered
over the system. Each formula is
installed into its own versioned folder
in the **Cellar**:

```text
<prefix>/Cellar/jq/1.8.2/
```

That folder — one formula, one version
— is called a **keg**. Install a newer
version and it gets a keg of its own;
the old one stays until you clean up.
What your shell actually runs are
**links**: the prefix's `bin`, `lib`,
`include` and `share` folders hold
symbolic links into the currently
chosen keg. Switching versions is
relinking, which is why it is fast and
why the way back exists.

Nothing outside the prefix belongs to
brew. Take the prefix away and brew's
whole world is gone, which is the
uninstall story for brew itself.

## Taps: catalogues in git repositories

A **tap** is a git repository of
formulae (and sometimes casks and extra
commands) that brew has been told
about. The name is the shape of the
idea: you tap another source and its
packages flow alongside the official
ones. A tap's repository is named
`homebrew-<something>` and addressed as
`<owner>/<something>` — `homebrew/core`
is simply the official tap your install
starts with. Chapter 6 builds one: the
lab's own tap is a small git repository
containing exactly one formula, and
everything about how taps are found,
trusted and removed is visible in it.

Since Homebrew 6, a tap you add
yourself is not automatically
**trusted**: loading a formula means
running its Ruby code as you, so brew
asks you to trust a tap — or just the
one formula from it — before it will
use it. Chapter 6 walks through that
exchange.

## Casks: the other catalogue

A **cask** is a package definition for
software that ships as a finished
application rather than something to
build: on macOS, the `.app` bundles and
installer packages of the GUI world,
managed with the same install, list and
uninstall rhythm as formulae. Casks
live in their own corner of the prefix,
the **Caskroom**. Their story is
entangled with which operating system
you are on, so they get their own
chapter — chapter 8 — which is also
where this guide is precise about what
"casks are for macOS" does and does not
mean in the current version.

## The cache, briefly

Downloads land in a **cache** (outside
the prefix, under your user's cache
directory) before they are poured or
built. It is the one part you will
never need to think about until
`brew cleanup` reclaims it in
chapter 7.
