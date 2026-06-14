# Agent Handoff

## Current Objective

Implement a reusable agent collaboration protocol template in this repository.

## What Changed

Added shared protocol files, an initializer script, a project-level Claude skill, and a global Codex skill. Then distilled the user-provided prompt library into `reflections.md`, `quality-gates.md`, and updated skill instructions. Added `README.md` for GitHub publication.

## Verified

- `scripts/init-agent-protocol.ps1` creates the expected protocol files in a temporary project.
- Running the initializer a second time skips existing files and does not overwrite them.
- Generated Markdown preserves inline-code backticks and fills the project name correctly.
- The global Codex `agent-dev-protocol` skill passes `quick_validate.py`.
- `.claude/skills/agent-dev-protocol` passes `quick_validate.py`.
- Enhanced initializer creates `.claude/skills/agent-dev-protocol/SKILL.md`, `.omx/development/reflections.md`, and `.omx/development/quality-gates.md`.
- Enhanced initializer skips all existing files on rerun.
- `git diff --check` passed.

## Not Verified

- Real-world behavior during a future multi-agent development task.
- Whether the compact quality gates should later be split into domain-specific skills.
- GitHub push, because this local repository has no remote and GitHub CLI is not installed or not on PATH.

## Known Risks or Blockers

- Claude and Codex do not share a skill mechanism; `AGENTS.md` must remain the shared source of truth.
- On Windows, run the initializer with `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/init-agent-protocol.ps1` unless script execution is already enabled.
- To publish, provide a GitHub repository URL/`owner/repo`, install `gh`, or add an `origin` remote manually.

## Next Recommended Action

Create or connect a GitHub repository, then push the initial protocol template commit.
