# Stage N: <name of the stage>

Written <date> by <who>. Read `00-GLOBAL-RULES.md` first; it applies in full.
**Base commit:** <commit>, tagged `stage-N-base`. Every Part starts from that tag.
**Tag when accepted:** `<tag>`.

## 0. The owner's words and decisions

- <date time>: <what the owner said or agreed, in their words where short>

## 1. Purpose

<One short paragraph: what exists after this stage that did not exist before.>

<One line: what this stage deliberately does not contain.>

## 2. Done when (all of these)

1. <A check that can be run, with the result that means pass.>
2. <The check script> prints `PASS` for every line and ends with `DONE`. It checks:
   a. <the normal case>
   b. <a refusal>
   c. <a repeat or duplicate>
   d. <a failure of something it depends on>
3. After a restart, <the check script> passes again without anyone touching anything.
4. In a clean copy of the branch: <formatter>, <build>, <tests>, <linters> pass.
5. The user guide covers everything in section 9.

## 3. Prerequisites (before the builders start)

1. <What>, done by <who>. Where to type it: <which terminal, which folder>. Password asked: <which, or none>.
   ```
   <exact command>
   ```
   Good result: `<what you should see>`.

## 4. Decisions for this stage (fixed; versions checked <date> from <sources>)

| Item | Decision | Why |
|---|---|---|
| <item> | <exact choice and version> | <the problem it solves> |

## 5. Data model

| Table | Holds | Rules |
|---|---|---|
| <table> | <columns> | <unique keys, what may never happen> |

## 6. Interfaces

| Entry | Who may use it | Does | On bad input / on failure |
|---|---|---|---|
| <route, command or topic> | <exact condition> | <what it does> | <what it returns> |

## 7. Parallel Parts

**Rule: Part A changes no file Part B lists, and the reverse.** Nobody changes the files in section 10.

### Part A: <name> (branch `stage-N-part-a`, builder <who>)

Files (only these):
```
<path>
<path>
```
What to build:
1. <...>

Part A done when: <checks this Part can pass on its own>.

### Part B: <name> (branch `stage-N-part-b`, builder <who>)

Files (only these):
```
<path>
```
What to build:
1. <...>

Part B done when: <checks this Part can pass on its own>.

### Merge (after both Parts pass review)

<Who merges, into which branch, and which checks run on the merged result.>

## 8. Fixed names between the Parts

| What | Value |
|---|---|
| <port, variable, secret, image, path> | <exact value> |

## 9. User guide additions (in order; each with where to type it, which password, the good result)

1. <...>
2. Every new error message and what to do.

## 10. Files that must not change

<List.> If a builder believes one must change, it stops and asks the owner with the reason.

## 11. Pre-mortem

| Step | Failure | How it shows | Action |
|---|---|---|---|
| <step> | <what goes wrong> | <the message or symptom> | <what to do> |

## 12. Unverified (each one stops with a clear message if wrong)

1. <What the author believes but did not check.>

## 13. Out of scope for this stage

<List.> Builders do not pre-build any of it.

## 14. Changes agreed during the build (these override the sections above)

| # | Change | Who / when |
|---|---|---|
| 1 | <what changed and why> | <who agreed, date and time> |
