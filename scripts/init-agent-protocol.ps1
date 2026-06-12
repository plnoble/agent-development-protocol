param(
    [string]$ProjectName = (Split-Path -Leaf (Get-Location))
)

$ErrorActionPreference = "Stop"

function New-ProtocolFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $fullPath = Join-Path (Get-Location) $Path
    $directory = Split-Path -Parent $fullPath

    if ($directory -and -not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    if (Test-Path -LiteralPath $fullPath) {
        Write-Host "SKIP existing $Path"
        return
    }

    $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText($fullPath, $Content, $utf8NoBom)
    Write-Host "CREATE $Path"
}

$today = Get-Date -Format "yyyy-MM-dd"

$agents = @'
# Agent Development Protocol

This repository uses a lightweight multi-agent development protocol. Every agent must treat these files as the shared source of truth before changing code or project state.

## Startup Rules

1. Read this file first.
2. Read `.omx/development/current.md` and `.omx/development/handoff.md` before making changes.
3. Inspect the current worktree before relying on previous conversation context.
4. Preserve user or agent changes you did not make. Never revert unrelated work unless explicitly asked.
5. Keep records short, factual, and useful for the next agent.

## Development Loop

1. Ground yourself in the current repo state.
2. Before meaningful work, identify objective, dependencies, risks, impact scope, and acceptance criteria.
3. Update the plan or current status before starting meaningful work.
4. Implement in small, verifiable steps.
5. Run the narrowest useful verification after each risky change.
6. Record decisions, mistakes, unresolved risks, and next steps as they appear.
7. Before ending work, run the applicable completion checks, add a reflection, and update the handoff.

## Required Records

- `.omx/development/current.md`: current objective, status, last verification, blockers, and next action.
- `.omx/development/worklog.md`: meaningful development events, not noisy command-by-command output.
- `.omx/development/decisions.md`: important choices, rejected alternatives, and consequences.
- `.omx/development/error-ledger.md`: mistakes, wrong assumptions, root causes, fixes, and prevention rules.
- `.omx/development/handoff.md`: concise state for the next agent.
- `.omx/development/reflections.md`: task-end retrospectives, lessons, waste, and process improvements.
- `.omx/development/quality-gates.md`: adaptive pre-change and pre-delivery checklists.
- `.omx/development/skill-candidates.md`: reusable lessons that may become future skills, scripts, or project rules.

## Recording Rules

- Update `current.md` whenever the objective, status, blocker, verification result, or next action changes.
- Append to `worklog.md` for meaningful phases: planning, implementation milestone, verification, blocker, handoff.
- Add to `decisions.md` when choosing between plausible approaches.
- Add to `error-ledger.md` when an assumption, command, design choice, or implementation path turns out wrong.
- Add to `reflections.md` before declaring a meaningful task finished.
- Use `quality-gates.md` for release, handoff, or risky changes; mark irrelevant checks as not applicable.
- Add to `skill-candidates.md` when a lesson is repeated, high-cost, cross-project, or easy to automate.

## Error Ledger Format

Each error entry should include:

- Symptom
- Wrong assumption
- Root cause
- Detection method
- Fix
- Prevention rule
- Skill candidate: yes/no

## Handoff Standard

Before stopping, update `.omx/development/handoff.md` with:

- Current objective
- What changed
- What is verified
- What is not verified
- Known risks or blockers
- Exact next recommended action

## Quality Gate Standard

Before high-risk changes, delivery, or release, check the applicable categories in `.omx/development/quality-gates.md`.

Use these statuses:

- Pass: verified with evidence.
- Warn: partially covered or residual risk remains.
- Fail: must fix or explicitly defer.
- N/A: not relevant to this project or change.

Always include file, command, or inspection evidence for pass, warn, and fail results.

## Experience Distillation

At task completion, review `error-ledger.md`, `decisions.md`, `worklog.md`, and `reflections.md`.

Promote lessons as follows:

- One-off project detail: keep only in the relevant log.
- Stable project rule: add to `AGENTS.md`.
- Cross-project workflow: add to `skill-candidates.md`.
- Repeated fragile operation: create or update a script/template.
- Repeated agent behavior rule: create or update a global skill.
'@

$claude = @'
# Claude Code Entry

Read and follow the shared agent rules in `AGENTS.md`.

Also read these state files before changing the project:

- `.omx/development/current.md`
- `.omx/development/handoff.md`
- `.omx/development/quality-gates.md`
- `.omx/development/reflections.md`

Keep the development records updated as described in `AGENTS.md`.
'@

$claudeSkill = @'
---
name: agent-dev-protocol
description: Follow the repository's multi-agent development protocol for planning, implementation, quality gates, verification, handoff, reflection, error recording, and experience distillation. Use when working on development tasks, bug fixes, refactors, multi-agent handoffs, implementation plans, pre-change or pre-delivery checks, verification, retrospectives, or reusable lesson capture.
---

# Agent Development Protocol

Follow the shared project protocol before and during development work.

## Startup

1. Read `AGENTS.md`.
2. Read `.omx/development/current.md`.
3. Read `.omx/development/handoff.md`.
4. Inspect the current worktree before trusting conversation history.

## Work Loop

1. State or update the current objective.
2. Plan the next verifiable step.
3. Implement in small, reversible chunks.
4. Verify with the narrowest meaningful command.
5. Record important decisions, errors, risks, and next steps.
6. Run applicable quality gates and add a short reflection before completing meaningful work.
7. Update handoff before stopping.

## Required Updates

- Update `.omx/development/current.md` when status, blockers, verification, or next action changes.
- Append to `.omx/development/worklog.md` for meaningful milestones.
- Append to `.omx/development/decisions.md` when choosing between plausible approaches.
- Append to `.omx/development/error-ledger.md` when an assumption or implementation path fails.
- Append to `.omx/development/reflections.md` before declaring a meaningful task finished.
- Use `.omx/development/quality-gates.md` for risky changes, handoff, delivery, or release.
- Append to `.omx/development/skill-candidates.md` for reusable lessons.
- Update `.omx/development/handoff.md` before ending the session.

## Error Handling

When a mistake happens, record the symptom, wrong assumption, root cause, detection method, fix, prevention rule, and whether it should become a skill candidate.

## Completion

Before reporting completion, verify the requested behavior, record applicable quality-gate results, add a reflection, update handoff, and review whether any project rule, script, template, or skill should be created from the work.
'@

$current = @'
# Current Development State

Project: __PROJECT_NAME__

## Objective

Describe the current task or leave this as the project protocol baseline.

## Status

Initialized agent collaboration protocol.

## Current Branch

Unknown. Check `git status` before making git operations.

## Last Verification

Protocol initialized; project-specific verification not run yet.

## Blockers

None known.

## Next Action

Update this file with the active development objective before starting implementation work.

## Notes for Next Agent

Read `AGENTS.md` and this file before changing code. Keep handoff state current.
'@.Replace("__PROJECT_NAME__", $ProjectName)

$worklog = @'
# Development Worklog

## __DATE__

- Initialized the agent collaboration protocol for `__PROJECT_NAME__`.
'@.Replace("__DATE__", $today).Replace("__PROJECT_NAME__", $ProjectName)

$decisions = @'
# Decision Log

## __DATE__ - Adopt shared agent protocol

Decision: Use `AGENTS.md` and `.omx/development/` as the shared source of truth for agent collaboration.

Alternatives considered:

- Startup prompt only.
- Tool-specific skill only.

Why chosen:

Shared project files survive handoff across tools and sessions.

Consequences:

- Agents must keep records current.
- Tool-specific skills can improve behavior but should not replace project state files.
'@.Replace("__DATE__", $today)

$errorLedger = @'
# Error Ledger

Use this file to record mistakes that should not be repeated.

## Entry Template

### YYYY-MM-DD - Short title

- Symptom:
- Wrong assumption:
- Root cause:
- Detection method:
- Fix:
- Prevention rule:
- Skill candidate: yes/no

## Entries

No errors recorded yet.
'@

$handoff = @'
# Agent Handoff

## Current Objective

Agent collaboration protocol initialized for `__PROJECT_NAME__`.

## What Changed

Added shared protocol files and development state templates.

## Verified

Initialization completed.

## Not Verified

Project-specific tests or build commands have not been run.

## Known Risks or Blockers

None known.

## Next Recommended Action

Update `current.md` with the next concrete development objective before changing code.
'@.Replace("__PROJECT_NAME__", $ProjectName)

$reflections = @'
# Reflections

Use this file at the end of meaningful tasks. Keep entries short and focused on reusable learning.

## Entry Template

### YYYY-MM-DD - Task or milestone

- Related task:
- What worked:
- What failed or slowed down:
- Root lessons:
- Token or time waste:
- Process improvements:
- Future optimizations:
- Potential skill candidates:

## Entries

No reflections recorded yet.
'@

$qualityGates = @'
# Quality Gates

Use this file before risky changes, handoff, delivery, or release. Apply only relevant categories and mark the rest as N/A.

Statuses:

- Pass: verified with evidence.
- Warn: partial coverage or residual risk.
- Fail: issue must be fixed or explicitly deferred.
- N/A: not relevant to this project or change.

## Pre-Change Gate

- Objective, dependencies, risks, impact scope, and acceptance criteria are clear.
- Existing worktree state has been inspected.
- Affected files or modules are identified.
- Verification approach is known before implementation starts.
- Security, privacy, data, API, frontend, or release-sensitive areas are flagged when relevant.

## Pre-Delivery Gate

### Security and Privacy

- Inputs are validated and outputs are encoded where applicable.
- Secrets, tokens, passwords, and PII are not logged or committed.
- Authentication and authorization changes are reviewed for least privilege.
- File paths, uploads, system commands, and outbound requests are checked for injection or traversal risk.

### Data, API, and Consistency

- Schema changes use migrations where applicable.
- API shape, versioning, validation, pagination, and idempotency are reviewed when applicable.
- Money uses integer minor units or decimal types, never binary floating point.
- Time storage and transfer use UTC when the project handles time-sensitive data.

### Code Quality and Maintainability

- The change follows existing project patterns.
- Duplication, dead code, broad types, empty catches, and unhandled TODO/FIXME/HACK comments are reviewed.
- Error handling is explicit and does not silently swallow failures.
- Configuration is separated from code and required config fails fast.

### Testing and Verification

- Unit, integration, E2E, or manual verification is selected according to risk.
- Boundary cases and regression scenarios are covered where relevant.
- Verification commands and results are recorded in `current.md` or `handoff.md`.
- Known unverified areas are stated explicitly.

### Frontend, Accessibility, and UX

- Loading, empty, error, and boundary states are handled when UI is affected.
- Keyboard access, labels, alt text, focus visibility, and color contrast are checked when UI is affected.
- Mobile layout and user-visible text are checked when frontend behavior changes.

### Operations, Dependencies, and Release

- Dependency changes are reviewed for lockfiles, unused packages, vulnerabilities, and licenses.
- Logs, metrics, health checks, retries, timeouts, graceful shutdown, and rate limits are considered when relevant.
- README, API docs, ADRs, changelog, release notes, or migration notes are updated when needed.
- Rollback or recovery path is known for risky delivery.

## Gate Result Template

### YYYY-MM-DD - Gate name

| Category | Status | Evidence | Notes |
| --- | --- | --- | --- |
| Security and privacy | N/A |  |  |
| Data, API, and consistency | N/A |  |  |
| Code quality and maintainability | N/A |  |  |
| Testing and verification | N/A |  |  |
| Frontend, accessibility, and UX | N/A |  |  |
| Operations, dependencies, and release | N/A |  |  |

Open issues:

- None.
'@

$skillCandidates = @'
# Skill Candidates

Use this file to collect lessons that may become future global skills, project rules, scripts, or templates.

## Candidate Template

### YYYY-MM-DD - Candidate title

- Trigger:
- Reusable lesson:
- Evidence:
- Proposed form: project rule / global skill / script / template / discard
- Promotion threshold:

## Candidates

No candidates recorded yet.
'@

New-ProtocolFile -Path "AGENTS.md" -Content $agents
New-ProtocolFile -Path "CLAUDE.md" -Content $claude
New-ProtocolFile -Path ".claude/skills/agent-dev-protocol/SKILL.md" -Content $claudeSkill
New-ProtocolFile -Path ".omx/development/current.md" -Content $current
New-ProtocolFile -Path ".omx/development/worklog.md" -Content $worklog
New-ProtocolFile -Path ".omx/development/decisions.md" -Content $decisions
New-ProtocolFile -Path ".omx/development/error-ledger.md" -Content $errorLedger
New-ProtocolFile -Path ".omx/development/handoff.md" -Content $handoff
New-ProtocolFile -Path ".omx/development/reflections.md" -Content $reflections
New-ProtocolFile -Path ".omx/development/quality-gates.md" -Content $qualityGates
New-ProtocolFile -Path ".omx/development/skill-candidates.md" -Content $skillCandidates

Write-Host "Agent protocol initialization complete for $ProjectName."
