# Troubleshooting

**Outcome:** the failures this guide's
lab actually met, plus the ones its
reading says you are most likely to —
each with the observation that
identifies it and the move that fixes
it.

**Check:** every entry starts from
something you can see — a message, a
path, a behaviour — not from a guess
about what you did.

## "Don't run this as root!"

The installer stops before doing
anything (transcript t04).

**Cause:** the shell is root (UID 0) and
you are not inside one of the CI or
container setups the script explicitly
permits.

**Fix:** none, in that shell — that is
the point of the message. Run the
installer as an ordinary user who will
own the installation. If the machine
has no such user, creating one is the
next step, and it belongs to your
system's tools, not to brew.

## "Running Homebrew as root is extremely dangerous…"

Every working brew command answers
with the same two lines and exit code 1
(transcript t02):

```text
Error: Running Homebrew as root is extremely dangerous and no longer supported.
As Homebrew does not drop privileges on installation you would be giving all
build scripts full access to your system.
```

**Cause:** as above, one layer in —
brew itself rather than its installer,
usually reached by `sudo brew …` or by
a root shell on an installed machine.

**Fix:** drop the `sudo`; run brew as
the user who owns the prefix. If files
inside the prefix have become owned by
root (the usual scar of past `sudo
brew`), doctor will name them, and the
repair is to give the prefix back to
its owner with your system's `chown`,
run as the administrator you are —
once, outside brew.

## The version is a floor, not a version

`brew --version` answers `Homebrew
>=4.3.0 (shallow or no git repository)`
(transcript t02).

**Cause:** the checkout has no release
tags in it — a shallow clone, or a tree
copied without its `.git`. Brew reads
its version from the checkout's
history, and this checkout cannot
testify.

**Fix:** if the installation is real,
restore the history (a full clone, or
fetch the tags). If you made the clone
yourself for reading, as this guide's
lab did, nothing is broken; the answer
is simply honest about what it knows.

## `brew --prefix` names a checkout

The prefix path ends in the checkout
folder itself, and your exported
`HOMEBREW_PREFIX` was ignored
(transcript t03).

**Cause:** you are running `bin/brew`
straight out of a bare clone. The
wrapper derives its paths from the brew
file's location — the derivation is
there to read at the top of `bin/brew` —
and a bare checkout is not the layout
the installer builds.

**Fix:** install properly (chapter 3)
rather than running a checkout as if it
were an installation; or, if the
checkout is a deliberate sandbox like
this guide's lab, accept its reported
paths as the sandbox's truth.

## "command not found" after a successful install

You installed brew, the installer
printed *Next steps*, and your new
shell has never heard of `brew`.

**Cause:** the `shellenv` lines were
never added to your shell's startup
file — the single most common
first-day failure, because the install
itself gives no further sign.

**Fix:** run the two lines from chapter
3 now, in this shell and in `~/.bashrc`
(or `~/.zshrc`). `eval "$(<prefix>/bin/brew
shellenv)"` fixes the present shell;
the file fixes every future one.

## A tap's formula will not load

Installing from a tap you added stops
with a trust complaint.

**Cause:** since Homebrew 6, an
unofficial tap's code must be trusted
before brew will load it (chapter 6,
transcript t08).

**Fix:** trust exactly what you mean to
use — installing by the full address
`brew install <owner>/<tap>/<formula>`
trusts just that formula — and reach
for `brew trust --tap` only when the
whole tap has earned it. `brew doctor`
lists untrusted taps if you have lost
track.

## The install compiled, slowly, instead of pouring

Your install of a common tool took ten
minutes and a fan, instead of seconds.

**Cause:** no bottle matched your
machine — an architecture or system
version outside the bottle block, or a
formula whose bottles have lapsed — so
brew fell back to building from source
(chapter 12).

**Fix:** usually none; the result is
the same program. If it happens to
everything, `brew config` will show the
fact about your machine that the
bottles are missing, and that is the
fact worth knowing.

## Doctor warns about things that are not brew

`brew doctor` complains about another
tool, an old leftover, a setting you
chose on purpose.

**Cause:** doctor inspects the
installation's *surroundings* as well
as the installation, and its warnings
are advice, offered in case they
explain a symptom you have not met yet.

**Fix:** read each warning as a
question — *is this mine, and do I care?*
— and compare against the baseline you
saved on install day (chapter 4). A
warning that was there on day one and
has never hurt anything is a fact
about your machine, not an emergency.
