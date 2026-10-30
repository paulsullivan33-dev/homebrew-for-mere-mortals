# Keeping Things Healthy

**Outcome:** an installation that stays
boring: brew itself current, your
software current when you choose, old
versions swept, and one habit —
`brew doctor` against a baseline — that
catches trouble while it is still
small.

**Check:** you can name what `brew
update` actually moves (it surprises
most people), and the difference
between pinning a formula and being
stuck with it.

*The commands in this chapter are the
documented ones; the lab's brew could
not run them (chapter 3 explains). What
the lab could do — read the checkout
they operate on — is woven in where it
makes the mechanics visible.*

## `brew update`: the checkout moves

Most tools update themselves by
downloading a new program. Brew updates
itself by updating its **checkout**:
`brew update` pulls the Homebrew
repository to its latest state and does
the same for your taps, then reports
what changed — including, usefully, a
list of new and updated formulae. Two
consequences follow from the mechanics,
and both are visible in the lab's own
clone:

- Update is a git operation, with git's
  failure modes. A checkout whose local
  files you have edited can refuse to
  pull, in git's own words, until you
  put it right (`git -C <repository>
  status` shows you the damage; the
  repository here is the `Homebrew`
  folder from chapter 2).
- "Updating brew" and "upgrading your
  software" are separate acts. The first
  refreshes the *catalogue and the
  tool*; nothing you have installed
  changes. Brew does the first one on
  its own before install and upgrade
  commands — which is why scripts set
  `HOMEBREW_NO_AUTO_UPDATE=1`, as the
  lab did, when they need an operation
  to mean exactly one thing.

## `brew outdated` and `brew upgrade`

`brew outdated` lists installed
formulae that the catalogue has moved
past — name, installed version, current
version. `brew upgrade` then installs
the new kegs and relinks, for
everything on the list, or for the one
formula you name. Upgrading is the
Cellar design paying off: the old keg
remains until cleanup, so a bad upgrade
has a floor to stand on while you read
the error.

The discipline worth adopting is to
read `brew outdated` before running
`brew upgrade`, the way you would read
a bill before paying it. Most weeks it
is a formality. The week it is not, it
is the whole reason.

## Pinning: choosing to stay

Some software you do not want moving —
the database your project is tested
against, the tool whose new version
changed a format. `brew pin <formula>`
exempts it from upgrades; `brew unpin`
releases it. A pin is a preference, not
a padlock: installing is unaffected,
the formula's presence in `brew outdated`
is marked, and nothing about a pin
survives an uninstall. It is also not a
way to run two versions side by side at
once — the Cellar keeps old kegs, but
only one is linked. Switching between
versions as a daily act is a different
tool's job; chapter 11 points at it.

## `brew cleanup`: the broom

Brew is tidy by instinct — installs
normally end with a cleanup of the
formula just touched — but caches and
superseded kegs accumulate across a
system. `brew cleanup` reclaims them:
old downloads from the cache, old kegs
of upgraded formulae. Three refinements:

- `brew cleanup -n` shows what would
  go, with sizes. Run it first, always.
- `HOMEBREW_NO_INSTALL_CLEANUP=1` (the
  lab set it) turns off the automatic
  per-install sweep, for people and
  scripts that prefer to clean on a
  schedule of their own.
- Cleanup never touches the currently
  linked version of anything. What it
  removes is precisely what nothing
  points at.

## The healthy rhythm

Put together, a low-effort rhythm that
keeps all of it boring:

1. `brew doctor` on a new install;
   keep the output (chapter 4).
2. `brew update`, then `brew outdated`,
   whenever you think of it — monthly
   is plenty for a stable machine.
3. `brew upgrade` after reading the
   list; `brew cleanup -n`, then
   `brew cleanup`, after a big one.
4. `brew doctor` again when anything
   behaves oddly, and compare with the
   baseline before believing a warning
   is new.
