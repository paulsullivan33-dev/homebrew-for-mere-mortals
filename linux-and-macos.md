# Homebrew on Linux and macOS

**Outcome:** you can predict, for any
brew behaviour, whether it is the same
on both systems or different — and you
know which parts of this guide rest on
the Linux side only because that is
where its lab lived.

**Check:** you can name the prefix on
all three kinds of machine without
looking, and say what `brew services`
is talking to on each system.

## What is the same

Almost everything you have read so
far. The tool is one codebase; the
formulae are one catalogue; a formula
that supports both systems is the same
file with, where needed, per-system
blocks inside it. Bottles are poured by
the same robots into the same Cellar
design. `install`, `uninstall`,
`upgrade`, `doctor`, taps, trust,
Brewfiles — the rhythm of chapters 4
to 7 and 10 does not change. jq's
formula, which the lab read, is the
cleanest illustration: one file, one
bottle block, and inside that block a
row of checksums — `arm64_tahoe`,
`arm64_sequoia`, `sonoma`, `arm64_linux`,
`x86_64_linux` — the same program,
prebuilt once per platform, chosen
automatically by the machine doing the
asking.

This sameness is the reason Homebrew
exists in its current form. It began as
the Mac's missing package manager; the
Linux version (for years a separate
project called Linuxbrew) was merged
into the one tool, and the project's
own Linux page lists the point among
its features: *use the same package
manager to manage your macOS, Linux and
Windows systems* — Windows here meaning
WSL 2, where brew runs as the Linux
program it is.

## What differs

**The prefix.** `/opt/homebrew` on
Apple Silicon Macs, `/usr/local` on
Intel Macs, `/home/linuxbrew/.linuxbrew`
on Linux. The Linux one is the telling
one: it lives under a dedicated
account's-looking path so that a single
ordinary user can own the whole
installation on a machine where `/usr`
and `/opt` belong to the system.

**The catalogue's centre of gravity.**
Core formulae aim to work everywhere
brew does, but the long tail leans Mac:
macOS-only dependencies exist, and
chapter 8 has already covered the
extreme case — casks, whose catalogue
is mostly macOS software even though
the format is not.

**The plumbing underneath.** Homebrew
deliberately uses almost nothing from
the host system: on Linux, its own
documentation notes, it relies only on
*glibc* and *gcc* being new enough, and
can install its own current copies of
both for older distributions — meaning
a brew on an elderly distro quietly
carries its own foundation under the
Cellar. On macOS the equivalent
foundation is Apple's Command Line
Tools, which is why the installer
offers to fetch them.

**Services.** `brew services` starts
and stops the daemons your formulae
provide — databases, queues, servers —
and it speaks to each system's own
supervisor. The lab read this in the
checkout's source rather than running
it: on macOS the service files are
LaunchAgents (yours) and LaunchDaemons
(the system's, with `sudo`); on Linux
they are systemd units, in
`~/.config/systemd/user` for your user
or `/usr/lib/systemd/system` with
`sudo`. The commands — `brew services
start <formula>`, `stop`, `restart`,
`list` — are the same; only the
audience changes. (This guide does not
run a service anywhere: services are
documented-only in its ledger.)

**The root rule, in different clothes.**
It is the same rule on both systems,
but you meet it in different places. On
a Mac, where the person at the keyboard
is usually an administrator account
that is still not root, the rule mostly
shows as brew declining `sudo brew`. On
Linux servers and in containers, where
root shells are everyday things, it
shows as this guide's lab found it: the
door simply closed, in two wordings,
until a normal user arrives.

## What this guide could not see

This guide's lab lived on the Linux
side, in a root shell, in a sandbox.
The macOS specifics in this chapter —
the `/opt/homebrew` layout on a real
Apple Silicon machine, the `.pkg`
installer the documentation describes
for it, the look of a cask installing a
GUI application, `brew services`
talking to launchd — are documented
from the project's own material, not
observed. Where a behaviour exists on
both systems and the lab met it, the
chapter says which side the meeting
happened on. That is the same bargain
as the rest of the guide, kept in the
open: a tool that works the same in
both places deserves a guide that is
careful about the places it has
actually been.
