# Recipes

**Outcome:** four jobs people actually
do with brew, assembled from the pieces
the earlier chapters verified or
documented, each with the check that
tells you it worked.

**Check:** each recipe names its
evidence — run for real in the lab, or
documented — next to the job it does.

## A new machine, from one file

Homebrew can write down everything it
has installed in a **Brewfile** and
replay it elsewhere — the feature is
called Brew Bundle, and its
documentation ships in the checkout.

```sh
brew bundle dump        # writes ./Brewfile
brew bundle             # installs from ./Brewfile
brew bundle check       # is this machine satisfied?
```

The Brewfile lists taps, formulae and
casks as plain lines (`brew "jq"`,
`tap "lab/labtap"`) — a file you can
keep in git beside your other machine
configuration. *(Documented; the lab's
brew could not run it. The check is the
third command's answer, and the file
itself is readable enough to serve as
its own evidence.)*

## A script that must not be interrupted

Any script that runs `brew install` or
`brew upgrade` inherits brew's habit of
updating itself first — occasionally
the wrong surprise at the wrong
moment. The switches are environment
variables, and the lab set two of them
for its own session (transcript t02):

```sh
export HOMEBREW_NO_AUTO_UPDATE=1     # no silent self-update
export HOMEBREW_NO_INSTALL_CLEANUP=1 # leave the cache to me
export HOMEBREW_NO_ANALYTICS=1       # no usage statistics either
```

The third deserves its sentence:
Homebrew collects anonymous install
statistics by default — the project's
analytics document describes exactly
what is sent — and this variable is the
documented off switch. *(The variables
are real and were set in the lab; their
effects are documented-only, since no
working command ran under them except
the refusals, which honour them too.)*

## Your own tool, on every machine

Chapter 6's circle, put to work. Host
the tap repository anywhere git can
reach; then, on each machine:

```sh
brew tap <you>/<yourtap>
brew install <you>/<yourtap>/<tool>
```

Installing by the full address trusts
just that formula (chapter 6), the
checksum in the formula verifies the
tarball on every machine, and `brew
upgrade` keeps your tool current
alongside everything else. *(The
artefacts were built for real in the
lab; the sequence is documented.)*

## The quarterly sweep

For a machine that is not a project —
the one that simply must keep working:

```sh
brew update
brew outdated          # read before you leap
brew upgrade
brew cleanup -n        # the bill, itemised
brew cleanup
brew doctor            # compare with your baseline
```

Twenty minutes, four times a year, and
the installation stays the boring kind.
Chapter 7 explains each step; nothing
here is new, which is rather the point
of a recipe. *(Documented as a
sequence; every command in it is one
chapter 7 covers.)*
