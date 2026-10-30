# First Checks

**Outcome:** you know how to ask a new
installation the three questions that
matter — what are you, where do you
live, are you healthy — and how to read
the answers, including the odd ones
this guide's lab collected.

**Check:** after this chapter you can
explain why a shallow clone's version
answer is a floor rather than a
version, and which commands answer even
when brew refuses to work.

## `brew --version`: the identity question

The first check is the version. On a
normal installation it answers with the
release it is running — the 7.0 series
was current when this guide's lab
cloned the project (the tag list the
lab fetched ended at 7.0.9).

The lab's own answer was stranger, and
more instructive:

```text
$ brew --version
Homebrew >=4.3.0 (shallow or no git repository)
```

That is not an error. Brew takes its
version from the checkout's git
history — from the release tags in it —
and the lab's `--depth=1` clone has
almost no history and no tags. Unable
to name a release, brew says the
honest thing available to it: *at
least* this old, and why it cannot be
more precise. The lesson generalises:
brew's identity **is** its checkout, so
anything that damages the checkout —
deleting its `.git`, copying the tree
without its history — shows up here
first, wearing this exact sentence.

## The boundary: what answers, what refuses

Because the lab's shell was root, it
could map something a normal user never
sees: exactly where the root rule sits
inside the tool. Brew's command line
starts as a shell script, and the
wrapper answers a few simple questions
itself before the real program — the
part that enforces the rule — is
loaded. Transcript t03 is the map:

Answered by the wrapper, even for root:

```text
$ brew --prefix
/home/hatch/workspace/homebrew-labwork/prefix/Homebrew
$ brew --cellar
/home/hatch/workspace/homebrew-labwork/prefix/Homebrew/Cellar
$ brew --repository
/home/hatch/workspace/homebrew-labwork/prefix/Homebrew
```

Refused, every time, with the same two
lines from chapter 1: `brew doctor`,
`brew info jq`, `brew config`,
`brew install jq`. And one curiosity:
`brew list` exited successfully in
silence — an empty Cellar has nothing
to list, and that question, it turns
out, is answered before the rule is
consulted. On your own install, `brew
list` is simply the inventory: every
formula you have, one per line, and
adding a name shows that formula's
files.

One wrinkle in those paths deserves a
sentence, because you may meet it. The
lab ran `bin/brew` straight out of a
bare checkout, and the wrapper derives
its prefix from the brew file's own
location — read `bin/brew` in the
checkout and you can watch it do so —
so it reported the checkout itself as
the prefix, politely ignoring the
`HOMEBREW_PREFIX` the lab had exported.
A real installation is laid out by the
installer so that this derivation lands
on the true prefix; if `brew --prefix`
ever names a folder that is plainly a
checkout, you are running an uninstalled
tree. Chapter 13 keeps the symptom.

## `brew doctor`: the health question

`brew doctor` is the check this chapter
is named for, and the one the lab could
not run: as root it meets the refusal.
What follows is therefore from the
project's documentation and the tool's
own help, and is labelled accordingly —
the shape of the thing, so you know
what you are looking at on your own
machine.

Doctor examines the installation and
its surroundings: whether the prefix is
writable by you, whether the checkout
is healthy, whether your compiler tools
are present and sane, whether anything
in the prefix is a leftover from
another package manager, whether taps
you have added are ones you have not
trusted. It prints warnings in plain
language, each naming the thing it
found and usually the command that
fixes it. Two habits make it useful
rather than noisy:

- Run it when you **install**, and keep
  the output. A new install's warnings
  are your baseline; later runs are
  read against it.
- Treat warnings as advice, not a
  verdict. Doctor itself says its
  warnings are suggestions about things
  that *may* matter; a machine can run
  brew happily for years with a warning
  about an unrelated tool it happens to
  have noticed. What you are watching
  for is *change*.

## `brew config`: the machine's confession

The third question is `brew config`,
which prints the whole situation in one
screen: brew's version, the prefix and
Cellar, the taps, the operating system,
the CPU, the compiler and Ruby brew is
using, and the `HOMEBREW_*` environment
variables in force. It refused the lab,
like doctor. On your machine it is the
first thing to paste into any request
for help — yours or anyone else's —
because half of all brew confusion is
two people picturing different prefixes
while using the same words.
