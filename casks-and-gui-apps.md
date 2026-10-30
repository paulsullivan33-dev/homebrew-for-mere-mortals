# Casks and GUI Apps

**Outcome:** you know what a cask is,
how it differs from a formula, and —
precisely, because this is where the
internet's folklore is out of date —
what happens to casks on Linux.

**Check:** you can name the artifact
kinds that are macOS-only, the kinds
that are not, and why "casks don't work
on Linux" is a sentence that needs a
date on it.

*This whole chapter is documented-only:
the lab had no Mac and its brew could
not run anywhere. Its source is the
project's own Cask Cookbook, which
ships inside the checkout the lab
cloned (transcript t08).*

## What a cask is

A formula describes software that must
be built or assembled: fetch the
source, run the install block, link the
keg. A **cask** describes software that
arrives already finished — classically,
a macOS application in a `.app` bundle,
or a `.pkg` installer, or a font, or a
plugin — and merely needs to be
fetched, verified by checksum, and put
in the place such things live. There is
no build. The cask file names the
download, the checksum, and the
**artifacts**: what gets moved where.

Casks are managed with the same rhythm
as formulae, with a flag so brew knows
which catalogue you mean:

```sh
brew install --cask <name>
brew list --cask
brew uninstall --cask <name>
```

They live apart from formulae on disk
too: casks are staged in the
**Caskroom** folder of the prefix, and
macOS applications are linked into your
Applications folder rather than into
`bin`.

## The honest position on Linux

Older writing — and a good deal of
current folklore — will tell you
flatly that casks are a macOS feature
and Linux does not have them. That was
true for most of Homebrew's life, and
the classic catalogue still is what it
is: the overwhelming majority of casks
package macOS GUI software, and no
package manager can make a Mac
application run on Linux.

But the current Cask Cookbook — the
project's own, read by this guide's lab
in the checkout — describes a wider
format, and a current guide should say
so:

- The artifact stanzas are
  OS-specific or portable, and the
  cookbook says which: **`app` and
  `pkg` are macOS-only**; **`app_image`
  is Linux-only** (an AppImage,
  delivered as-is); **`binary` works on
  either system**.
- A cask can declare `depends_on :macos`
  (macOS-only, optionally with a minimum
  or maximum release) or
  `depends_on :linux` (Linux-only), and
  cross-platform casks scope their
  artifacts inside `on_macos` and
  `on_linux` blocks.
- Download addresses and checksums can
  vary by operating system and
  architecture — the cookbook's own
  substitution keys include
  `arm64_linux` and `x86_64_linux`.

So the precise statement is: **the
cask *format* is cross-platform now;
the cask *catalogue* remains mostly
macOS software.** On a Mac, `brew
install --cask` is how a large share of
your GUI life arrives. On Linux, a
cask works exactly when its author
declared a Linux artifact for it — an
AppImage or a plain binary — and the
famous GUI names are not among those.
If a claim about casks does not
distinguish the format from the
catalogue, it is a claim about the
Homebrew of some years ago.

## Choosing between the catalogues

When the same program exists as both —
some tools are packaged as a formula
for their command-line form and as a
cask for their application form — the
choice is usually made for you by what
you want on the machine: the keg and a
command, or the application and its
icon. `brew info` on the name shows
both when both exist, and says which is
which. There is no penalty for having
some of each; the two catalogues share
a tool, not a disk layout, and chapter
7's rhythm looks after both.
