# Installing Homebrew

**Outcome:** Homebrew installed under
one ordinary user account — or, if your
shell is root, a clear understanding of
the message you will get instead and
why it is the right message.

**Check:** `brew --version` answers
with a version. If instead you see
either refusal quoted in this chapter,
you have met the root rule, not a bug.

## Before anything: the account

Homebrew's first requirement is not
software. It is that you run it as a
**normal user who owns the
installation**. On your own laptop that
is simply your account. On a server,
that is a regular login — not root, and
not a `sudo` habit. The project's
documentation puts the reason plainly:
the installer uses its privileges once,
at the start, precisely so that you
don't need *sudo* after Homebrew's
initial installation when you install
formulae.

The machine also needs the ordinary
build plumbing, because some formulae
still compile. On Debian or Ubuntu, the
project's own list is:

```sh
sudo apt-get install build-essential procps curl file git
```

Other systems have equivalents on the
project's Linux page; macOS gets its
compiler tools from Xcode's Command
Line Tools, which the installer offers
to fetch.

## The standard route: the installer

The supported installation is a single
script, run from the project's home
page, which checks the machine, creates
the prefix, clones the repository into
it, and prints the *Next steps* that
put brew on your shell's path. This
guide's lab fetched that script and
read it before running anything — a
habit worth copying with any
install-my-operating-system script —
and three facts from the reading are
worth knowing:

- It installs to the default prefix for
  your platform: `/opt/homebrew` on
  Apple Silicon, `/home/linuxbrew/.linuxbrew`
  on Linux.
- It asks for your password at the
  start, for the few steps that create
  directories owned correctly — and
  arranges things so it never has to
  ask again.
- It refuses root. Early in the script
  sits a check whose whole job is to
  stop and say so.

The lab then ran the script in its
root shell — deliberately, to see the
refusal a root user would meet — and
got exactly that, as transcript t04
records:

```text
==> Running in non-interactive mode because `$NONINTERACTIVE` is set.
Don't run this as root!
```

## The route the lab took: the git checkout

Homebrew's other documented route is to
make the checkout yourself: clone the
project's repository, put its `bin` on
your path, and let brew arrange itself
from there. It is the route to take
when you want a non-default prefix, or
when you want to see the machinery —
and it is the only route that leaves
anything for a root shell to look at,
so it is the one this guide's lab used.
Its prefix was a folder inside the lab,
its repository cloned like this
(transcript t01):

```sh
git clone --depth=1 https://github.com/Homebrew/brew <prefix>/Homebrew
```

with the layout variables pointed at
the lab's folders:

```sh
export HOMEBREW_PREFIX=<lab>/prefix
export HOMEBREW_CELLAR=<lab>/prefix/Cellar
export HOMEBREW_REPOSITORY=<lab>/prefix/Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
```

Two honest notes on that clone. It was
**shallow** (`--depth=1`), which is
fine for reading and useless for
history — chapter 4 shows the visible
consequence in `brew --version`. And
the repository's folder matters: the
checkout belongs in a folder named
`Homebrew` inside the prefix, which is
where a real installation keeps it.

## The Next steps: shellenv

However it was installed, brew is not
on your path until your shell is told.
The installer's *Next steps* give you
the lines; on Linux with Bash they are:

```sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
```

(Use `~/.zshrc` for zsh.) `brew shellenv`
prints the exports — prefix, PATH,
manual and info paths — that make the
installation usable, and the second
line makes them permanent. Skipping
this is the single most common reason a
fresh install "isn't found" afterwards;
chapter 13 keeps the symptom.

## What root gets instead

With the checkout in place, the lab
asked brew to do real work and met the
second refusal — the one from brew
itself rather than its installer. It is
the same for every working command, and
chapter 4 maps exactly which questions
are answered before it bites. If you
are reading this guide on a machine
where you only have root — a fresh
container, a minimal server image —
the path forward is not a flag or an
environment variable. There isn't one.
It is to give the machine an ordinary
user, let that user own the prefix, and
install as them. That is not Homebrew
being difficult; it is the whole design
from chapter 1, enforced at the door.
