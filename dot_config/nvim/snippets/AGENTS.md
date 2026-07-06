# [Project Name]: Agent Manual

[PROJECT-SPECIFIC: Replace this paragraph with one or two factual sentences
describing what this project is. Keep public-facing explanation in `README.md`.]

This file is for AI agents and maintainers working inside the repository. It
should help them navigate the codebase, preserve the development process, and
apply project conventions without turning the public README into an internal
rulebook.

## How To Use This Template

- Sections marked `PROJECT-SPECIFIC` should be filled in or replaced for each
  repository.
- Sections marked `GENERAL` are intended to work across projects. Change them
  only when this project needs a different operating rule.
- Delete placeholder bullets that do not apply. Keep the final project file
  concise enough to read at the start of every fresh chat.
- This section can be removed after project-specific parts are added and 
  the two kind of temporary marks deleted.

## Documentation Roles [GENERAL]

- `README.md`: public overview for users. Explain what the program is, how to
  install or run it, and how to use it. Do not include internal AI-agent rules
  or development workflow policy.
- `AGENTS.md`: internal manual for AI agents and maintainers. Keep navigation,
  conventions, design philosophy, workflow rules, and verification guidance here.
- `ROADMAP.md` or `docs/ROADMAP.md`: temporal context. Record current direction,
  completed milestones, next steps, blocked work, and deferred decisions so a
  fresh chat can resume without guessing.

## Project Map [PROJECT-SPECIFIC]

Update this when repository structure changes in a way that affects navigation.

- `README.md`: public project overview and usage.
- `AGENTS.md`: internal development and AI-agent instructions.
- `ROADMAP.md` or `docs/ROADMAP.md`: current plan and next steps.
- `[path]/`: [purpose].
- `[path]/`: [purpose].
- `[path]/`: [purpose].

## Fast Context [PROJECT-SPECIFIC]

Use this section for the shortest path from a task to the relevant files.

- Main entry point: `[path]`.
- Public API or user-facing surface: `[path]`.
- Core implementation: `[path]`.
- Tests: `[path]`.
- Build or task runner: `[path]`.
- Configuration: `[path]`.
- Generated files: `[path]`; source of truth is `[path or command]`.

## Operating Loop [GENERAL]

- Start by checking the working tree with `git status --short` when the project
  is in git. Do not overwrite user changes.
- Read `AGENTS.md`, then `README.md` for public behavior, then the roadmap when
  choosing or continuing broad project work (you already are reading the agents 
  file, no need to read it twice).
- Find the relevant files and tests before editing. Prefer `rg` or `rg --files`
  when available.
- State assumptions or ask a concise question when missing information affects
  architecture, behavior, data model, or public contracts.
- Make small, coherent source changes. Keep a lightweight note of follow-up
  docs, generated files, tooling metadata, and broader tests that should be
  handled before handoff or before switching topics.
- For small or trivial edits, use the smallest useful verification first rather
  than rebuilding the whole project after every change.
- After a substantial source change, several related small changes, or a change
  of topic, run the broader relevant checks and update docs/tooling that were
  intentionally batched.
- If deferred verification or follow-up work remains, record it in the roadmap,
  a task list, or the final response.

## Change Control [GENERAL]

- Keep the diff focused on the current goal, but do not treat focus as blindness.
- If you notice an obvious bug, inconsistency, risky design, or code that clearly
  conflicts with these instructions, mention it and ask before changing it unless
  it directly blocks the requested task.
- Do not make unrequested behavioral changes, broad refactors, formatting sweeps,
  dependency changes, or cleanup passes without confirmation.
- Remove only the imports, variables, files, or generated outputs made obsolete
  by your own changes.
- Preserve existing public contracts unless the task explicitly changes them or
  the user agrees to the change.

## Project Rules [PROJECT-SPECIFIC]

Replace this section with the conventions that are actually true for this
repository. Avoid generic preferences once the project has real patterns.

- Language/runtime versions: `[fill in]`.
- Formatting command: `[fill in]`.
- Lint command: `[fill in]`.
- Test command: `[fill in]`.
- Build command: `[fill in]`.
- Naming and style: follow existing code until documented here.
- Architecture boundaries: `[fill in]`.
- Dependency policy: `[fill in]`.
- Generated-file policy: `[fill in]`.

## Design Philosophy [PROJECT-SPECIFIC]

Keep this short and actionable. Include only principles that should guide real
implementation choices in this repository.

- [Principle].
- [Principle].
- [Principle].

## Verification [PROJECT-SPECIFIC]

Fill in commands as soon as the project has them.

- Fast local check: `[command]`.
- Focused tests: `[command]`.
- Full test suite: `[command]`.
- Build: `[command]`.
- Release or packaging check: `[command]`.

When a check cannot be run, say why and identify the most relevant untested risk.

## Roadmap Use [GENERAL]

- Treat the roadmap as the source of temporal context, not public documentation.
- Before starting broad work, read the roadmap. After completing planned work or
  changing direction, update it.
- Keep entries concrete enough that another agent can resume the project without
  reconstructing intent from old chats.
- If work is intentionally deferred, record the condition for returning to it.

## Safety [GENERAL]

- Do not commit secrets, credentials, private keys, local environment files, or
  machine-specific paths.
- Prefer documented configuration over hard-coded local values.
- Confirm before destructive commands, migrations, data deletion, external
  writes, or changes that are difficult to reverse.
- Preserve third-party license notices and attribution requirements.
