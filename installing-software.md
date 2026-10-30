# Installing and Removing Software

**Outcome:** you can install a tool with
brew, prove it is the brewed copy that
runs, read its entry in the catalogue,
see what it depends on — and remove it
all again.

**Check:** the worked example is jq. By
the end you can show `which jq` pointing
into a Cellar keg, and reproduce the
three fixture answers at the end of the
chapter from the file in `homebrew-lab/`.

*A note on evidence, once, for the whole
chapter: this guide's lab could not run
`brew install` — its root shell met the
refusal in chapter 3. The procedure
below is the documented one, built
around a real formula the lab read in
full (transcript t05). The jq commands
and their answers were checked with the
sandbox distribution's own jq, which is
a different copy of the same program;
the lab says so wherever those answers
appear.*

## Finding the name

Formulae are found with `brew search
<word>`, which lists matching formulae
and casks, and read with `brew info
<name>`, which prints the catalogue
entry: description, homepage, the
current stable version, what it depends
on, and whether it is installed. For
the guide's example:

```text
brew info jq
```

describes **jq 1.8.2**, "Lightweight and
flexible command-line JSON processor",
licensed MIT, with one dependency that
matters in a moment: `oniguruma`, the
regular-expression library jq is built
against.

## What `brew install jq` does

```sh
brew install jq
```

Five things happen, in an order worth
knowing because each has a symptom when
it fails:

1. **The formula is read.** Brew loads
   core's jq formula — the file from
   transcript t05 — and works out the
   dependency list. jq needs oniguruma,
   so oniguruma is on the list too.
2. **The bottle is chosen.** The
   formula's bottle block names an
   archive per platform. On the lab's
   kind of machine the entry is the one
   labelled `x86_64_linux`, checksum
   `631787d9…` in the formula the lab
   read. No matching bottle would mean
   a source build instead; chapter 12
   covers that edge.
3. **The download is verified.** The
   archive lands in the cache and its
   SHA-256 is compared with the
   formula's. A mismatch stops the
   install. This is the step that makes
   "download a binary from the internet"
   a checked act rather than a hopeful
   one.
4. **The keg is poured.** The archive is
   unpacked into `Cellar/jq/1.8.2/` —
   its own folder, touching nothing
   else.
5. **The links are made.** `jq` appears
   in the prefix's `bin`, pointing into
   the keg. From this moment `jq` at
   your prompt is the brewed one, and
   `brew list jq` will recite every file
   it owns.

Dependencies are installed the same
way, before the formula that needs
them: oniguruma gets its own keg and
its own links, and `brew deps jq`
prints the relationship — one word,
`oniguruma` — while `brew deps --tree
jq` draws it for formulae whose trees
are worth drawing.

## Proving it is the brewed jq

Two checks, both cheap:

```sh
which jq        # a path inside your prefix's bin
jq --version    # jq-1.8.2 for the formula the lab read
```

`which` matters more than the version.
Machines accumulate jq copies — the
distribution's, a project's vendored
one — and the brewed copy is the one
whose path runs through the prefix,
because the prefix's `bin` is what
`brew shellenv` put first on your path.

Then the fixture. `homebrew-lab/`
holds `stall.json`, an invented market
stall's stock list: three items, one of
them out of stock. The three questions
a new jq owner asks first, with the
answers the lab verified (with the
distribution's jq, as the note at the
top of this chapter says — a brewed jq
answers identically; the filters are
the program's, not the copy's):

```text
$ jq -r '.items[] | select(.stock > 0) | .name' stall.json
lamp oil
cotton wick

$ jq '[.items[].price] | add' stall.json
11.75

$ jq -e '.open' stall.json
true
```

Names of what is in stock, the value of
the shelf, and a yes that a script can
branch on — that is the whole shape of
jq in one fixture, and the same shape
works unchanged on a ten-thousand-line
file from a real API.

## Removing, reinstalling, cleaning

Removal is the promise from chapter 1
kept:

```sh
brew uninstall jq
```

takes away the keg and the links — and,
by default, stops and warns if
something still installed depends on
the thing you are removing, which is
the dependency list working in the
other direction. `brew reinstall jq`
rebuilds the installation from the
formula afresh — the standard answer to
"this copy seems damaged" — and
`brew cleanup` sweeps the cache and any
kegs that upgrades have left behind. A
dry run first is the habit:

```sh
brew cleanup -n    # what would go
brew cleanup       # and now it goes
```

Everything in this chapter is a
two-way door. That, more than the size
of the catalogue, is what makes brew
safe to be curious with.
