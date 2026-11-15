# <project>: global rules for every build stage

Applies to every stage spec in this folder. Readers: the builders, the reviewer, the owner, the planner.
A stage spec may add rules. It may not remove any rule in this file.
Written <date>.

## 1. Who does what

| Who | Does |
|---|---|
| **<Owner>** | Owns every decision. Runs every privileged command personally, in a plain terminal. Tests each stage. Says when a stage is accepted. |
| **Planner** (<tool>) | Writes the stage specs, splits each into Parts, keeps the status file, the logs and the board in step. Does not write product code. |
| **Builder** (<tool>, one window per Part) | Builds exactly what its Part says, in its own worktree. Runs only checks that need no privileges and change nothing shared. Reports in the format in section 7. |
| **Reviewer** (<tool>, a new session each time) | Reviews each spec and each finished Part against the spec and this file, with the checklist in section 8, before the owner tests. |

A builder **never**:
- runs privileged commands (`sudo`, admin consoles), or asks the owner to type a password into the agent;
- changes shared infrastructure (<list the commands that count>). Read-only commands for checks are allowed: <list>;
- starts a process that keeps running in the background;
- installs system packages or changes system configuration;
- pushes to `main` before the owner has said the stage is accepted;
- changes a file its Part does not list;
- puts a password, token, key or real secret value into the repo, a log, a commit message or its report;
- deletes data, migrations or audit records;
- adds a feature, table, dependency or test the spec did not ask for;
- puts a client's or employer's name, or anyone's personal data, into the repo.

When a builder needs something only the owner may do, it writes the exact commands into a script under `install/` and stops with: **"Please run install/<file> as described in README"**. It does not continue until the owner says it is done.

## 2. Fixed decisions (do not revisit)

**Product**
- <name, licence, repo>
- <architecture rules: how modules may talk to each other>
- <safety rules: what happens when something does not answer>

**Stack**
- <languages and major versions, database, messaging, sign-in, where it runs>
- Exact versions are fixed and dated in each stage spec.

**Places and names**
- <build machine, main clone path, worktree folder, local settings folder>
- <terminal layout: session name, and what each numbered tile is for>
- <public addresses>
- Secrets live only in <where>. The repo holds example files with names and no values.
- <time zone for stored times, language of the user interface>

**Agreed exceptions** (each with its limit, who agreed, and the date)
- <none yet>

## 3. Repo layout (fixed)

```
<project>/
  AGENTS.md          read by <tool> (same content in every tool's start file)
  README.md          starts with the QUICK GUIDE (section 6)
  docs/
    STATUS.md        what is built, what passed, what is open (updated every stage)
    specs/           this file + stage-N-*.md
  <folders, one line each, with the stage they first appear in>
```

## 4. Code rules

**All code**
- Pin exact versions. Commit lock files. Every new dependency is named in the report with one line saying why.
- Logs never contain request bodies, passwords, tokens, file contents or personal details.
- Every route validates its input and has at least one test.
- <your rules>

**<Language 1>**: <formatter, linter, test command; all must pass>
**<Language 2>**: <...>
**Scripts in `install/`**: safe to run twice; print `STOP: <plain reason>` and exit non-zero when something is wrong; end with `DONE` on success.

## 5. Build and deploy flow (every stage)

1. The planner commits the stage spec to `main`. That commit is the stage's **base commit**, tagged `stage-N-base`.
2. Each Part runs in its own builder window, in its own worktree, on its own branch:
   `git -C <main clone> worktree add <worktrees>/stage-N-part-x -b stage-N-part-x stage-N-base`
3. **Part rule:** a Part changes only the files its spec lists. No Part changes a file another Part lists. If a Part needs another Part's file, it stops and asks.
4. When its Part is complete and its checks pass, the builder commits on its branch and writes its report (section 7).
5. The reviewer reviews each Part. The planner decides each finding. The builder fixes on the same branch. A new reviewer session re-reviews.
6. The builder merges the Parts into `stage-N` (made from the base commit) and runs all checks again on a clean worktree.
7. The stage's scripts deploy it, and the owner tests the spec's "Done when" list.
8. When the owner says the stage is accepted, the builder commits "Stage N: accepted", merges `stage-N` into `main`, pushes, and creates the stage's tag.

## 6. Documentation rule

Every `README.md` starts with a **QUICK GUIDE**: short numbered steps, exact commands, where to type each, and the good result of each. It covers every everyday job for what exists so far: set up, deploy, check, start, stop, restart, status, logs, run tests, what each `STOP:` message means, and what to do after a restart. The builder updates it in every stage.

## 7. Builder report format (end of every Part)

```
STAGE N PART X REPORT
1. Built: <files/folders added or changed, one line each>
2. Dependencies added: <name, exact version, why> (or "none")
3. Checks run and results: <each check, passed/failed, counts>
4. Things I could not do (needed privileges / the live system / network / a decision): <list>
5. Deviations from the spec: <none, or each one with the reason>
6. Open questions for the owner: <one per line, plain words, why it matters>
7. For the guide: <what the owner ran, what they should see, what failed and the fix, time taken>
```

## 8. Review checklist (every Part)

1. Does every item in the Part's "Done when" exist and work? Run the checks yourself where possible.
2. Did the Part change any file it does not list? (Must be none.)
3. Any privileged command, system change, background process or shared-infrastructure change made by the builder? (Must be none.)
4. Any key, token or secret in code, config or docs? (Must be none.)
5. Any client or employer name, or personal data? (Must be none.)
6. Any deletion of data, migrations or audit records? (Must be none.)
7. Any dependency not justified in the report? Any version not pinned exactly?
8. Any route without input validation or without a test?
9. Any script that is not safe to run twice, or lacks `STOP:`/`DONE`?
10. README Quick Guide: present, first, complete for this stage, plain words?
11. `docs/STATUS.md` updated?
12. Anything built that the spec did not ask for?
13. <one item per trap this project has already fallen into>

Report findings as a numbered list: file, line, what is wrong, what the spec says. No praise, no summary of what is fine.

## 9. How to talk to the owner (MANDATORY; identical copy in every tool's start file)

- Anything the owner must act on or decide goes at the TOP of the message.
- Every command you give the owner starts with one line saying exactly where to type it.
- If a command asks for a password, say which one.
- Say which folder to be in, with the exact `cd` command, or "the folder doesn't matter for this command".
- Give every command one short plain-English line saying what it does, and say what the good result looks like.
- Short, plain instructions. No jargon. One step at a time; wait for the owner's output before the next step.
- Say things in plain words. Never refer to something only by an internal number or code.
- When a correction is needed in text the owner will paste, give the complete corrected text, never "change this line".
- Never make assumptions. If something is not in the spec, stop and ask the owner one short question, saying why it matters.
