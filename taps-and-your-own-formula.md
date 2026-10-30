# Taps and Your Own Formula

**Outcome:** you understand a tap
completely because you have seen one at
its smallest — a git repository with a
single formula in it — and you can read
every line of that formula.

**Check:** you can explain why the
repository is called `homebrew-labtap`,
what each stanza of `brasslamp.rb`
does, and what brew asks before it will
run your formula the first time.

*Evidence, once, for this chapter: the
tap, the formula and the program below
are real — this guide's lab wrote them,
committed them to git, and ran the
program itself (transcript t06); all
three live in `homebrew-lab/`. The
steps where brew consumes them are the
documented ones, labelled as such,
because the lab's root shell could not
run brew. Nothing about the artefacts
is a sketch: if your account can run
brew, these exact files work.*

## The program: deliberately tiny

A formula deserves a program simple
enough that nothing about it can hide,
so the lab invented one. `brasslamp` is
an eleven-line shell script that prints
one line, optionally addressed:

```text
$ brasslamp
The brass lamp is lit.
$ brasslamp Ada
The brass lamp is lit for Ada.
```

Both lines really were produced by the
script in the lab; keep them in mind,
because they return at the end of the
chapter wearing a different hat.

The program is distributed the way
programs are: as a release tarball,
`brasslamp-1.0.0.tar.gz`, with a SHA-256
the lab computed and printed:

```text
f0f129fe7c59204aa6a5fe575aaa76fbe5e92ada2bc8acfba547ec616afa0326
```

## The formula, line by line

A formula is a Ruby class. Here is the
lab's, complete — it is `brasslamp.rb`
in `homebrew-lab/`, and it follows the
project's Formula Cookbook, which ships
in the checkout:

```ruby
class Brasslamp < Formula
  desc "Tiny invented program that prints one line about a brass lamp"
  homepage "https://example.invalid/brasslamp"
  url "file:///home/hatch/workspace/homebrew-labwork/fixtures/brasslamp-1.0.0.tar.gz"
  sha256 "f0f129fe7c59204aa6a5fe575aaa76fbe5e92ada2bc8acfba547ec616afa0326"
  license "MIT"

  def install
    bin.install "brasslamp"
  end

  test do
    assert_match "The brass lamp is lit.", shell_output("#{bin}/brasslamp")
    assert_match "The brass lamp is lit for Ada.", shell_output("#{bin}/brasslamp Ada")
  end
end
```

- The **class name** is the file name,
  dressed up: `brasslamp.rb` becomes
  `Brasslamp`, a subclass of `Formula`.
  Brew finds your program by this
  correspondence, and a mismatch is the
  first error every formula author
  meets.
- **`desc` and `homepage`** are what
  `brew info` will show your readers.
  The homepage is an `example.invalid`
  address because brasslamp is an
  invented program with no real site;
  a real formula puts the project's
  true home here, and core's style
  checks insist on it.
- **`url`** is where the release lives.
  It is a `file://` address on the
  lab's own disk — a formula does not
  care whether its archive is across
  the internet or across the room, and
  neither should your first one. (The
  path names the lab machine that wrote
  this guide; on yours it would name
  wherever you keep the tarball.)
- **`sha256`** is the checksum from the
  lab's printout above, pasted in.
  This is the same bargain as chapter
  5's bottle: brew will refuse an
  archive that does not match it.
- **`license`** states the terms, in
  the standard short identifiers.
- **`install`** is the whole build:
  one line, putting the script into the
  keg's `bin`. A compiled program's
  install block runs its configure and
  make equivalents here — compare jq's
  formula in transcript t05 — but the
  contract is identical: when this
  method finishes, the keg is complete.
- **`test`** is the formula's own
  check. `brew test brasslamp` runs the
  installed program and asserts on its
  output — and the two assertions are
  exactly the two lines the script
  printed in the lab. A formula's test
  is not decoration; it is how a
  maintainer learns the package broke
  before a user does.

What is missing is as instructive as
what is present. There is no `bottle`
block: nobody's build robot has poured
this one, so every install runs the
install block itself — trivial for a
script, the normal starting state for
any new formula. There is no
`depends_on`: the script needs nothing
but a shell. Each stanza exists in the
cookbook because some real program
needed it, and a small formula shows
you the skeleton they hang on.

## The tap: a repository with a name

Formulae reach brew through taps, and a
tap is a git repository whose name
follows one rule: it is called
`homebrew-<name>`, and it keeps its
formulae in a `Formula` folder. The
lab's tap is the smallest legal
example, and it really exists — a git
repository with one commit:

```text
homebrew-labtap/
  Formula/
    brasslamp.rb
```

The tap is addressed as
**`lab/labtap`**: an owner name (`lab`)
and the repository's name with the
`homebrew-` prefix dropped. You tap it
(documented command) — from the local
repository, like this:

```sh
brew tap lab/labtap /path/to/homebrew-labtap
```

or, for a tap hosted on GitHub, with no
path at all: `brew tap <owner>/<name>`
clones it into your prefix's
`Library/Taps` folder, beside
`homebrew/core`. Tapping is cheap and
reversible — `brew untap lab/labtap`
removes it — and `brew tap` on its own
lists what you have tapped.

## Trust: the question brew asks first

Since Homebrew 6, adding a tap is not
the end of the conversation. A formula
is Ruby code, and loading it runs it —
with your user's privileges, whenever
brew so much as resolves a dependency.
So a tap that is not one of Homebrew's
official ones must be **trusted** before
its formulae will load, and brew's own
documentation (transcript t08 quotes
it) is blunt: commands that need to
load an untrusted tap or item will fail
until the relevant trust is granted.

The calibration is finer than
all-or-nothing, and it is the part
worth learning:

- Installing by the full address —
  `brew install lab/labtap/brasslamp` —
  trusts **that formula**, and only that
  formula. This is the route to prefer.
- `brew trust --formula lab/labtap/brasslamp`
  grants the same thing explicitly.
- `brew trust --tap lab/labtap` trusts
  everything the tap contains now and
  everything it may contain later. The
  documentation advises reserving that
  for taps whose every future formula
  you are prepared to run — which, for
  a tap of your own like this one, you
  are, and for a stranger's, you should
  think about exactly as long as that
  sentence took to read.

`brew doctor` warns about untrusted
taps, so the state of your trust is
part of the health picture from
chapter 4.

## The round trip

Assembled, the documented sequence the
lab's artefacts are ready for is:

```sh
brew tap lab/labtap /path/to/homebrew-labtap
brew install lab/labtap/brasslamp
brasslamp Ada            # The brass lamp is lit for Ada.
brew test brasslamp      # the formula's own assertions
brew uninstall brasslamp
brew untap lab/labtap
```

Every artefact in that sequence — the
program, the tarball, its checksum, the
formula, the repository — was made and
checked by this guide's lab. The
sequence itself awaits only a user
brew is willing to serve. When you run
it on your machine, the last two steps
complete the lesson the first four
teach: a package system is a circle —
publish, install, run, remove — and
nothing in the circle required anybody's
permission but yours.
