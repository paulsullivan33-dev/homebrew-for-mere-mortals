# Glossary

The terms, collected in one place. Each
is defined the way this guide uses it;
the project's own Formula Cookbook
keeps the authoritative list.

**Analytics** — the anonymous install
statistics Homebrew collects by
default. Described fully in the
project's analytics document; switched
off with `HOMEBREW_NO_ANALYTICS=1`.

**Bottle** — a prebuilt archive of a
formula's finished installation, made
by the project's build robots for a
specific platform, checksummed in the
formula's bottle block. Installing from
a bottle is called *pouring* it.

**Brewfile** — a plain-text list of
taps, formulae and casks describing one
machine's whole installation, written
and replayed by Brew Bundle
(`brew bundle`).

**Cask** — a package definition for
software that arrives finished rather
than built: classically a macOS
application, font or plugin, and in the
current format sometimes a Linux
AppImage or binary. Installed with
`brew install --cask`.

**Caskroom** — the folder in the prefix
where casks are staged, the casks'
counterpart to the Cellar.

**Cellar** — the folder in the prefix
(`<prefix>/Cellar`) where every
installed formula's versions live, each
in its own keg.

**Core** — `homebrew/core`, the official
tap: the catalogue of formulae your
installation starts with.

**Doctor** — `brew doctor`, the health
check that inspects an installation and
its surroundings and reports warnings
in plain language.

**Formula** — a Ruby file that
describes one piece of software: its
source and checksum, its dependencies,
how to install it, and a test. The
recipe from which installations are
made.

**Keg** — one formula at one version,
installed: `Cellar/<name>/<version>/`.
Only one keg of a formula is *linked*
at a time.

**Linking** — placing symbolic links
from the prefix's `bin`, `lib` and
friends into the current keg, so the
rest of the system can find the
software. Upgrades and version switches
are relinking.

**Pin** — `brew pin <formula>` marks a
formula exempt from upgrades until
`brew unpin` releases it.

**Prefix** — the root folder of an
installation, the one place everything
brew owns lives: `/opt/homebrew` on
Apple Silicon, `/usr/local` on Intel
Macs, `/home/linuxbrew/.linuxbrew` on
Linux.

**Services** — `brew services`, the
command that starts and stops the
background programs formulae provide,
through launchd on macOS and systemd
user units on Linux.

**shellenv** — `brew shellenv`, the
command that prints the environment
exports (PATH and friends) making an
installation usable in a shell.

**Tap** — a git repository of formulae,
casks or commands that brew has been
told about, named `homebrew-<name>` and
addressed as `<owner>/<name>`.

**Trust** — your explicit decision,
required since Homebrew 6 for
unofficial taps, that brew may load a
tap's code — or just one formula's —
with your privileges. Granted by
installing a fully-qualified name or
with `brew trust`, withdrawn with
`brew untrust`.
