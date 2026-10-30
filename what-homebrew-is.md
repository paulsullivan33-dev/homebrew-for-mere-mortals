# What Homebrew Is

**Outcome:** you can say what Homebrew
is for, what it refuses to be, and why
its one hard rule — never root — is a
feature you will feel in the first five
minutes.

**Check:** by the end of the chapter
you can name the gap Homebrew fills on
a machine that already has a perfectly
good system package manager.

## The gap

Your operating system arrived with a
package manager of its own: `apt` on
Debian and Ubuntu, `dnf` on Fedora,
`pacman` on Arch, and on macOS — very
little of the kind at all. Those tools
are the system's own. They install the
system, they are conservative by
design, and their catalogues move at
the speed of a whole operating system's
release cycle.

That leaves a gap, and working machines
fall into it constantly. The tool your
project needs was never packaged for
your distribution. It was packaged, but
three versions ago. You have two
machines — a Mac for the desk, a Linux
box for the real work — and nothing
about installing software works the
same way on both. Homebrew lives in
that gap. It is a second package
manager, running alongside the system's
own, with a catalogue of tens of
thousands of programs, current versions,
and one behaviour across macOS, Linux
and WSL 2.

## What it owes you

A package manager makes four promises,
and Homebrew is organised around
keeping them visibly:

- **Finding is one command.** You name
  the program; the recipe, the download
  and the checksums are somebody else's
  problem, already solved.
- **Installing is reversible.**
  Everything brew puts down lives in
  one place it owns, and `brew uninstall`
  takes it away again. Your system's
  own files are not the battleground.
- **Versions are kept, not replaced.**
  A new version is installed beside the
  old one and the links are switched,
  so an upgrade that misbehaves has a
  way back.
- **The machine can describe itself.**
  What is installed, what it depends
  on, what is out of date, what is
  broken — all answerable, all from the
  same tool.

Chapter 2 takes those promises apart
into the pieces that keep them.

## The root rule, stated early

Homebrew runs as **you**. Not as root,
not through `sudo`, not with a password
prompt halfway through an install. The
installation itself is laid out so that
one ordinary account owns it, and after
that no step needs more power than you
have.

This is deliberate, and it is enforced,
not advised. Installing a package means
fetching code other people wrote —
build scripts, install scripts, whole
binaries — and running it. Run as root,
that code can do anything to your
machine, silently. Run as you, it can
do only what you could do. Homebrew's
authors decided the second bargain is
the only acceptable one, and they built
the refusal into the tool: this guide's
lab, whose shell was a root account,
asked brew to check its own health and
was told, verbatim —

```text
Error: Running Homebrew as root is extremely dangerous and no longer supported.
As Homebrew does not drop privileges on installation you would be giving all
build scripts full access to your system.
```

Hold on to two consequences. First, if
your working shell is root — some
server images and most containers start
that way — Homebrew is not for that
shell; it is for a normal account on
that machine, and chapter 3 shows both
refusals (the installer's and brew's)
so you can recognise them. Second, the
rule is why brew can be casual about
everything else. A tool that can only
ever act as you does not need to ask
permission for each small act.

## What it is not

Homebrew is not a system updater: your
kernel, your C library and your
distribution's own packages stay the
system package manager's business. It
is not a sandbox: programs it installs
run with your full user privileges,
like programs you installed any other
way. And it is not an app store with a
till: there are no accounts and no
payments; the catalogue is a public git
repository of recipes, and chapter 6
shows you writing one.
