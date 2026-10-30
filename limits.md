# Limits

**Outcome:** a plain account of what
Homebrew will not do, so nothing in the
earlier chapters is misremembered as a
promise it never made.

**Check:** each limit below is stated
with the reason behind it — if one
surprises you, the chapter it qualifies
is named.

## It will not run as root. Ever.

There is no flag, no environment
variable and no supported configuration
that changes this; the installer says
`Don't run this as root!` and the tool
says running as root is *extremely
dangerous and no longer supported*, and
both mean it (transcripts t02 and t04).
On machines where root is the only
account going — fresh containers,
minimal images — Homebrew is simply
not available until an ordinary user
exists. This guide's whole lab is the
demonstration (chapter 3).

## It does not drop privileges

The mirror image of the same design:
brew never starts powerful and steps
down. Anything a formula's build or
install script does, it does as you.
That is the safety of chapter 1 — and
its boundary. Software that genuinely
needs system privileges to install is
somebody else's job: the system's
package manager's, usually.

## It is not your system's keeper

Brew will not update your kernel, your
C library, your distribution, or your
Mac's operating system, and it does not
want to. Its one venture toward the
foundation — carrying its own gcc and
glibc for Linux distributions too old
to build modern software (chapter 9) —
is scaffolding for its own installs,
not a takeover. Two package managers,
two territories (chapter 11).

## A bottle is a promise with edges

Prebuilt packages exist for the
platforms and versions the project's
robots build for. Step outside them —
an unusual architecture, a formula
whose bottle has lapsed, a build option
the bottles do not use — and the
fallback is compiling from source,
which needs a working toolchain, takes
the time it takes, and can fail in ways
a pour cannot. `brew install` does not
always mean the fast path.

## One linked version at a time

The Cellar keeps old versions; your
PATH sees one. Pinning stops a version
moving (chapter 7) but does not make
two versions neighbours you can choose
between per project. That is a version
manager's trade (chapter 11), and
conflating the two is a reliable source
of confusion.

## Removal is tidy, not total

`brew uninstall` removes the keg and
the links, completely. What it does not
remove is the life the program led
while installed: configuration it wrote
in your home directory, data it kept in
the usual places. (Casks have a `zap`
stanza — extra removal instructions for
exactly those traces — but even zap is
the cask author's list, not a guarantee
of a clean slate.) Brew uninstalls
software. It does not un-happen it.

## A tap is code, and trust is yours

Chapter 6's trust prompt is not a
formality being imposed on you; it is
the limit stated as a feature. Homebrew
cannot make a stranger's formula safe —
it can only make the moment of trust
explicit, granular and revocable
(`brew untrust`). The core catalogue is
reviewed and built by the project; a
tap is reviewed by you.

## The catalogue is not the world

Tens of thousands of formulae is a lot,
and it is not everything: brand-new
projects, niche tools, software whose
authors dislike packaging, and most
commercial applications are simply not
there, or are there as casks on macOS
only. And brew itself keeps opinions —
the project declines some categories of
software outright in its acceptable-
formulae and acceptable-casks policies,
which ship in the checkout's docs for
anyone who wants the list from the
source.
