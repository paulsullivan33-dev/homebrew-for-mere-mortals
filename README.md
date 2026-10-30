# Homebrew for Mere Mortals

Every operating system ships with some
software and a way to install more, and
every working machine eventually needs a
tool the system never packaged, or a
newer version than the system offers.
**Homebrew** — almost everyone calls it
**brew** — is the package manager built
for that gap. It began on the Mac, where
it became the standard way to install
command-line tools, and it now runs the
same way on Linux and on Windows'
WSL 2. You name a program; brew finds
the recipe, downloads a ready-built
package where one exists, puts the
result in its own tidy corner of the
disk, and can take it all away again
just as cleanly.

One property of Homebrew shapes this
whole guide, so it comes first: **brew
works as your ordinary user account and
refuses to work as root.** It does not
ask for your password, it does not use
`sudo` after its own installation, and
if you try to run it with full
privileges it stops and tells you why,
in so many words. That refusal is not a
limitation to work around; it is the
safety model. Installing software means
running other people's build scripts and
binaries, and Homebrew's answer is to
run them with exactly your permissions
and no more.

The lab behind this guide ran into that
rule head first, and the guide is
honest about what that means. The lab's
shell was the **root** account of a
small Linux sandbox, and there was no
ordinary user to switch to. So the lab
did everything that can be done without
a working brew, and labelled the rest:
it fetched Homebrew the official way —
a git clone of the project's own
repository, the same checkout the
installer would have made — read the
official installer and ran it (it stops
with `Don't run this as root!`), and ran
brew itself to find the exact boundary
of the refusal. A handful of harmless
questions are answered by brew's shell
wrapper before the rule bites; every
command that would do real work —
`doctor`, `info`, `install` — refused,
word for word the same way, and those
refusals are printed in the transcripts
exactly as they arrived. The lab built
the guide's own example package for
real: a tiny invented program, its
release tarball with a real checksum,
and a complete formula in a real git
repository laid out as a personal tap.
The program itself runs; the formula is
written to the project's own cookbook
and checked against a real core formula
the lab read in full. What the lab
could not do is press the button:
installing anything *with brew* needs
the one thing the lab did not have, a
normal user. Those procedures are
taught from Homebrew's own
documentation — which ships inside the
checkout the lab cloned — and labelled
documented-only wherever they appear.
`criteria.md` keeps the full ledger.

## What this guide covers

- [**What Homebrew is**](what-homebrew-is.md) —
  the gap it fills, the user-not-root
  rule, and what a package manager owes
  you
- [**The moving parts**](the-moving-parts.md) —
  formulae, bottles, the Cellar, taps
  and casks: which part holds what
- [**Installing Homebrew**](installing-homebrew.md) —
  the installer, the git route the lab
  took, the default prefixes, and the
  refusal that proves the root rule
- [**First checks**](first-checks.md) —
  the version question, `brew doctor`,
  and the few commands that answer even
  for root
- [**Installing and removing software**](installing-software.md) —
  `brew install` with jq as the worked
  example, listing, inspecting,
  dependencies, uninstalling and
  cleaning up
- [**Taps and your own formula**](taps-and-your-own-formula.md) —
  the centre of the guide: a personal
  tap in a git repository, a formula
  written line by line, and the trust
  Homebrew asks for before it runs a
  stranger's recipe
- [**Keeping things healthy**](keeping-things-healthy.md) —
  updating, upgrading, pinning, and the
  habits that keep a brew installation
  boring
- [**Casks and GUI apps**](casks-and-gui-apps.md) —
  the other half of the catalogue: what
  a cask is, and an honest account of
  which casks can live on Linux and
  which cannot
- [**Homebrew on Linux and macOS**](linux-and-macos.md) —
  the same tool on two systems: what is
  identical, what differs, and what
  this Linux lab could not see
- [**Recipes**](recipes.md) — a Brewfile
  for a whole machine, scripts that
  should not be interrupted by updates,
  and tidy-up passes
- [**The neighbours**](the-neighbours.md) —
  the system's own package manager,
  version managers, and app stores:
  who does which job
- [**Limits**](limits.md) — what brew
  will not do: root, your kernel, your
  system libraries, and the versions it
  cannot switch between
- [**Troubleshooting**](troubleshooting.md) —
  the root refusal in both its forms,
  the checkout that calls itself a
  prefix, the untrusted tap, and the
  doctor's warnings
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Writing software of your own beyond the
one small formula in chapter 6, which
exists to prove how a formula works.
Maintaining a formula in the official
core — the contribution process, its
style rules and its review — is
described by the project's own cookbook
and pointed to, not taught. Running
Homebrew on a machine you manage for
other people, with central policies and
approvals, is a documented feature this
guide mentions once and leaves there.

## How to use this guide

Read chapter 1 for the model and
chapter 2 before installing anything —
knowing which part holds what turns
later confusion into a named problem.
Chapter 3 gets you a brew of your own
(if your shell is a normal user
account; if it is root, chapter 3 shows
you the exact message to expect and
why). Chapters 4 and 5 install and
remove a real tool. Chapter 6 is the
one to read slowly: it is where the
machine stops being a shop and becomes
a workshop. The lab's transcripts live
in `homebrew-lab/`, alongside the JSON
fixture, the little program, and its
formula.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Linux for Mere Mortals](https://paulsullivan33-dev.github.io/linux-for-mere-mortals/)
- [Mise for Mere Mortals](https://paulsullivan33-dev.github.io/mise-for-mere-mortals/)
- [pipx for Mere Mortals](https://paulsullivan33-dev.github.io/pipx-for-mere-mortals/)
- [Git for Mere Mortals](https://paulsullivan33-dev.github.io/git-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/homebrew-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/homebrew-for-mere-mortals/blob/main/LICENSE-CODE).
