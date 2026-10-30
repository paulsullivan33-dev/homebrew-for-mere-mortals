# The Neighbours

**Outcome:** you can place Homebrew
among the other tools that put software
on a machine, and say — for each — what
it does that brew doesn't, and what
stays brew's job.

**Check:** for each neighbour you can
name the boundary: the point where its
responsibility ends and another tool's
begins.

## The system's own package manager

apt, dnf, pacman, and their graphical
relatives are the ground floor. They
install and maintain the operating
system itself — kernel, C library,
system services — as one interlocking
set, with the distribution's
conservatism about versions. Homebrew
does not compete with them and must
never be asked to: it needs them first
(the build tools in chapter 3 are
installed by apt on the lab's kind of
machine), and it keeps its own world in
its own prefix precisely so the two
never fight over a file. The rule of
thumb is one sentence: *if the system
offers it and the system's version
serves, prefer the system; brew is for
the gap* — the missing, the newer, the
same-on-both-machines.

## Mise: versions as a way of life

Where brew installs *the* current
version of a tool and links it, Mise
keeps *many* versions of languages and
tools and chooses among them per
project, from a file in the project
itself. A pinned brew formula (chapter
7) is a preference; Mise is a wardrobe.
They coexist happily: brew provides the
machine's standing tools, Mise dresses
each project. The series' [Mise
guide](https://paulsullivan33-dev.github.io/mise-for-mere-mortals/)
teaches that half properly.

## pipx: one language's apps, isolated

pipx installs applications written in
Python, each in its own little
environment, so Python tools never
tangle with each other or with yours.
Brew installs some of the same programs
as formulae — which is, under the
surface, often the same isolation trick
played by the Cellar. If a tool is
Python through and through and its
author releases it as a Python package,
pipx is the more direct tap; if it is
simply a program you want, brew's one
catalogue is fewer things to remember.
The [pipx
guide](https://paulsullivan33-dev.github.io/pipx-for-mere-mortals/)
in this series covers the isolated
half.

## Nix: the determined cousin

Nix takes the ideas brew embodies —
declarative recipes, checksummed
downloads, versioned installations that
never overwrite — and follows them to
their logical end: *every* version of
*every* dependency coexisting, whole
system configurations described in one
language, rollbacks of everything.
Homebrew is mentioned in this series'
other guides wherever reproducibility
comes up, usually standing next to Nix
as the friendlier relative, and that is
the honest placement. Nix asks more of
you and gives back certainty; brew asks
little and gives back a tidy prefix.
Machines exist that need the certainty.
Most laptops need the prefix.

## Flatpak: the app store shape

On Linux, Flatpak distributes finished
applications — mostly graphical ones —
in sandboxes, from repositories like
Flathub, with runtimes shared between
apps. It answers the question casks
answer on the Mac (chapter 8), with a
Linux accent and a permission model
brew does not attempt. Command-line
development tools are brew's ground;
end-user GUI applications on a Linux
desktop are increasingly Flatpak's.
There is no shame in a machine with
both, which is fortunate, because there
are a great many of them.

## The language ecosystems' own managers

npm for JavaScript, pip for Python,
cargo for Rust, gem for Ruby: each
language grows a manager tuned to its
own libraries, and for *libraries* —
the dependencies of code you are
writing — they are the right tools and
brew stays out of their way. The seam
appears at whole programs: a finished
tool written in Rust is both a cargo
package and, often, a brew formula. The
formula is the better citizen on your
machine — checksummed, listed, removable
by the tool that looks after the rest —
and the ecosystem's manager is the
better citizen inside a project's
build. Knowing which side of that seam
you are on is most of what this chapter
exists to teach.

And beneath all of them, quietly doing
the carrying: git, which brew's
checkout, taps and updates are made of,
and which the series' [Git
guide](https://paulsullivan33-dev.github.io/git-for-mere-mortals/)
teaches on its own terms.
