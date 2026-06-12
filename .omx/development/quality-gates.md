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

### 2026-06-12 - Prompt distillation protocol enhancement

| Category | Status | Evidence | Notes |
| --- | --- | --- | --- |
| Security and privacy | N/A | Prompt/protocol documentation only. | No application security surface changed. |
| Data, API, and consistency | N/A | Prompt/protocol documentation only. | No data model or API changed. |
| Code quality and maintainability | Pass | `git diff --check` exited 0. | Protocol stayed compact instead of copying full prompts. |
| Testing and verification | Pass | Temporary initializer run created new files and skipped existing files on rerun; both skills passed `quick_validate.py`. | Output included `.claude` skill, `reflections.md`, and `quality-gates.md`. |
| Frontend, accessibility, and UX | N/A | No frontend files. |  |
| Operations, dependencies, and release | N/A | No dependency or release pipeline changes. |  |

Open issues:

- Real-world usefulness of the compact quality gate still needs observation on future tasks.

### 2026-06-12 - GitHub publication preparation

| Category | Status | Evidence | Notes |
| --- | --- | --- | --- |
| Security and privacy | Pass | `README.md` contains no secrets; protocol files contain no tokens. | GitHub publication is documentation/template only. |
| Data, API, and consistency | N/A | No data model or API changed. |  |
| Code quality and maintainability | Pass | README documents initialization command, generated files, and agent startup prompt. |  |
| Testing and verification | Warn | Local validation pending after final commit prep; GitHub push blocked by missing remote/gh. | Need remote before push. |
| Frontend, accessibility, and UX | N/A | No frontend files. |  |
| Operations, dependencies, and release | Warn | `git remote -v` returned empty and `gh` was not found. | Provide remote or install GitHub CLI. |

Open issues:

- GitHub push cannot complete until a remote repository is available.
