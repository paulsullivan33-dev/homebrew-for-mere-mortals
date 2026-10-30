# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's fixture is an invented market stall; its example
   program is an invented lamp.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 12 names what the tool
   cannot do: the absolute root refusal, no privilege-dropping,
   no keeping of the system itself, bottles with edges, one
   linked version at a time, removals that are tidy rather than
   total, and trust in taps that no tool can make safe for you.
8. **The safety rule is in the text, early.** Homebrew's bargain
   — installing software means running other people's code, so
   brew runs only ever as you, verifies downloads against the
   formula's checksum, and asks before trusting a stranger's
   tap — is stated in chapter 1 and the README before any
   procedure depends on it.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a small Ubuntu Linux sandbox whose shell
is the **root account**, shared with other work while the lab
ran. That single fact decides what this guide could prove, and
the guide says so wherever it matters: Homebrew refuses to run
as root, and the lab had no ordinary user to switch to. The
lab therefore ran everything that does not require a working
brew, and treated the boundary of the refusal itself as
evidence — it is the first behaviour a reader in the same
position will meet, and it is quoted verbatim.

What the lab ran was the current Homebrew itself: a
`--depth=1` git clone of the project's own repository,
`Homebrew/brew`, made on 2026-10-30 (HEAD
`411ad3ef42e94b1c3d05a19fe289c13f0ce70f6b`; the project's tag
list the same day ended at release 7.0.9). The clone lives in
the lab's own prefix layout under `~/workspace/homebrew-labwork`
and was read, greped and executed — not a description of
Homebrew, but Homebrew, declining to work. The project's
documentation and cookbooks ship inside that checkout and are
the source of everything labelled documented-only; the lab
quotes them from the files, not from memory. All transcripts
are in `homebrew-lab/`.

Run for real, with transcripts as evidence:

- The lab environment itself: root shell, kernel, the absence
  of any ordinary user account or system Ruby (t00).
- The clone: `git clone --depth=1` of Homebrew/brew into the
  lab prefix, its HEAD commit, and its size (34 MB) (t01).
- The root refusal, verbatim, three times over:
  `brew doctor`, `brew install jq` and `brew info jq` /
  `brew config` each answering "Error: Running Homebrew as
  root is extremely dangerous and no longer supported…" with
  exit code 1 (t02, t03).
- The boundary of the refusal: the shell wrapper answering
  `brew --version` ("Homebrew >=4.3.0 (shallow or no git
  repository)" — a floor, because the clone is shallow),
  `brew --prefix`, `brew --cellar`, `brew --repository`
  (deriving the checkout itself as the prefix, exactly as the
  top of `bin/brew` says it will), and `brew list` exiting 0
  in silence over an empty Cellar (t02, t03).
- The official installer's own refusal: the install script
  fetched and read (its root check sits at line 443, `abort
  "Don't run this as root!"`), then run in the lab's root
  shell, where it printed the refusal and exited 1 (t04).
- A real core formula read in full: jq's, from homebrew-core —
  version 1.8.2, its `oniguruma` dependency, and its bottle
  block, including the `x86_64_linux` bottle checksum this
  guide quotes (t05).
- The guide's own package, built for real: the invented
  `brasslamp` shell script, run both bare and with a name (its
  two output lines, which the formula's test block asserts);
  its release tarball and real SHA-256
  (`f0f129fe…a0326`); the complete formula written to the
  project's Formula Cookbook; and the tap as a real git
  repository named `homebrew-labtap` with the formula
  committed (t06).
- The chapter-5 fixture exercised: the invented `stall.json`
  read by the sandbox distribution's own jq 1.7 (a different
  copy of the program, and the guide says so wherever the
  answers appear) — stock filtering, a price total of 11.75,
  and a boolean read with exit 0 (t07).
- The documentation lines the guide's claims rest on, greped
  from the checkout: the default prefixes, the Linux install
  requirements, the tap-trust rule ("Non-official taps require
  explicit trust by default", Tap-Trust.md line 11), and the
  Cask Cookbook's OS-specific artifact stanzas (t08). The
  `brew services` backends (launchd paths on macOS, systemd
  user paths on Linux) were likewise read in the checkout's
  `Library/Homebrew/services` source.

Documented only — described from the project's own
documentation and cookbook, not run, and the text does not
claim otherwise:

- Every working brew operation: `brew install`, `uninstall`,
  `reinstall`, `cleanup`, `search`, `deps`, `update`,
  `outdated`, `upgrade`, `pin`, `doctor`'s actual warning
  output, and `brew config`'s report. Each requires a non-root
  user; the lab had none. The procedures are written from the
  documentation and checked against the formulae and source
  the lab read.
- The tap round trip of chapter 6 (`brew tap`, installing the
  labtap formula, `brew test`, untap) and the trust exchange
  (`brew trust`, installing by fully-qualified name). The
  artefacts are real and present; only brew's consumption of
  them awaits a non-root account.
- Casks entire: the catalogue, `--cask` commands, the
  Caskroom in use, and which casks declare Linux artifacts.
  The lab had no Mac, and its brew could not have run one on
  Linux either. Chapter 8 is written from the Cask Cookbook in
  the checkout — including its correction of the older
  folklore: `app`/`pkg` artifacts are macOS-only, `app_image`
  is Linux-only, and `binary` works on either.
- `brew services` in operation, on both its launchd and its
  systemd backends (read in source only).
- macOS itself: the `/opt/homebrew` prefix on a real Apple
  Silicon machine, the `.pkg` installer, shellenv in a real
  login shell, and the Intel-Mac layout.
- Brew Bundle against a real machine, bottle pours and source
  builds, and analytics traffic (the off switch is documented;
  no working brew ever sent any from this lab).

Fixtures are this guide's own and deliberately generic: an
invented market stall's stock list, an invented brass-lamp
program, and a given name ("Ada") used the way documentation
has always used one — no real people, organisations, or
machines. The lab left no system state behind: its checkout,
prefix, taps and tarballs all live inside its own lab folder,
and nothing was installed anywhere else.
