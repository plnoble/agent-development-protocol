# Agent Development Protocol Template

This repository contains a reusable agent collaboration protocol for Codex, Claude, and other development agents.

Use it to initialize a project with:

- shared agent rules
- current development state
- worklog, decisions, errors, handoff, reflections, and quality gates
- project-level Claude skill
- global or project-level `agent-dev-protocol` workflow guidance

## Initialize a Project

Clone this protocol repository once:

```powershell
git clone https://github.com/plnoble/agent-development-protocol.git
```

Then run the initializer from the target project directory. Replace `<protocol-repo>` with the path where you cloned this repository:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<protocol-repo>\scripts\init-agent-protocol.ps1" -ProjectName "Your Project Name"
```

Example:

```powershell
cd "<target-project>"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "<protocol-repo>\scripts\init-agent-protocol.ps1" -ProjectName "Your Project"
```

The initializer creates missing protocol files and skips existing files without overwriting them.

## Files Created

```text
AGENTS.md
CLAUDE.md
.claude/skills/agent-dev-protocol/SKILL.md
.omx/development/current.md
.omx/development/worklog.md
.omx/development/decisions.md
.omx/development/error-ledger.md
.omx/development/handoff.md
.omx/development/reflections.md
.omx/development/quality-gates.md
.omx/development/skill-candidates.md
```

## Prompt for Future Agents

When starting development in a project that has been initialized with this protocol, tell the agent:

```text
Use agent-dev-protocol. Read AGENTS.md and .omx/development/current.md before changing code. Keep worklog, decisions, error ledger, quality gates, reflections, and handoff updated.
```

## Intended Workflow

1. Read `AGENTS.md`.
2. Read `.omx/development/current.md` and `.omx/development/handoff.md`.
3. Inspect the current worktree.
4. Identify the objective, dependencies, risks, impact scope, and acceptance criteria.
5. Implement in small, verifiable steps.
6. Record decisions, mistakes, verification evidence, and reusable lessons.
7. Before stopping, update handoff and add a reflection.

## Notes

- `AGENTS.md` is the cross-tool source of truth.
- `CLAUDE.md` and `.claude/skills/` help Claude Code discover the same protocol.
- Codex can use `agent-dev-protocol` as a global skill when installed in the local Codex skills directory.
- The protocol is intentionally compact. Put project-specific rules in `AGENTS.md`; put temporary state in `.omx/development/current.md`.
