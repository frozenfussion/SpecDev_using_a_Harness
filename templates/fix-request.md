# Stage <N> Part <X>: fixes after review (planner's decisions first)

Read <path to the review> (<count> findings). Fix findings <list> on branch stage-<N>-part-<x>.
Findings <list> are the planner's (the spec is being updated).

## Decisions
- D1 (finding 1): <fix / the exact thing to do>
- D2 (finding 2): <the spec changes: new wording of section <n>; build to that>
- D3 (finding 3): accepted as it is, because <reason>. No change.
- D4 (finding 4): rejected, because <reason>. No change.

## Rules for this round
- Change only what these findings need. No other improvements.
- Add or adjust a test for each fix.
- Stay inside your Part's file list.
- End with a short report: each finding, what you changed, which checks you re-ran and their results.
