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

### 2026-06-12 - Agent development protocol

- Trigger: Multi-agent development needs reliable handoff and mistake prevention.
- Reusable lesson: Agents need a shared project state plus tool-specific skills, not only a startup prompt.
- Evidence: User requested repeatable development rules, process logs, error records, and future skill distillation.
- Proposed form: project template plus global Codex skill and optional Claude skill.
- Promotion threshold: Keep as a maintained protocol if it helps a fresh agent understand status without conversation history.

### 2026-06-12 - PowerShell Markdown template safety

- Trigger: A PowerShell initializer generated malformed Markdown because double-quoted here-strings treated backticks as escapes.
- Reusable lesson: Use literal here-strings plus explicit placeholders for generated Markdown; write UTF-8 without BOM when local parsers may use system encodings.
- Evidence: Script verification initially passed file creation but inspection found missing backticks and literal `$ProjectName`; skill validation also exposed an encoding issue.
- Proposed form: script/template rule.
- Promotion threshold: Promote to a reusable script-authoring skill if another PowerShell template generator is needed.

### 2026-06-12 - Prompt library distillation

- Trigger: User supplied long start/end development prompts and asked whether they help this protocol project.
- Reusable lesson: Long prompts should be distilled into compact protocol surfaces, adaptive gates, and focused skills instead of copied into always-read files.
- Evidence: The supplied prompts contained valuable ideas, but also many domain-specific checks that would be noisy for every project.
- Proposed form: global skill or script-assisted workflow.
- Promotion threshold: Promote if more prompt libraries need to be turned into project rules or skills.

### 2026-06-12 - Adaptive quality gates

- Trigger: The supplied end prompt included a broad pre-release checklist across security, privacy, performance, code quality, testing, APIs, frontend, dependencies, and release readiness.
- Reusable lesson: Use a compact Pass/Warn/Fail/N/A gate with evidence instead of forcing every agent to run every domain checklist every time.
- Evidence: Added `.omx/development/quality-gates.md` and updated both skills to reference it.
- Proposed form: project template now; future global skill if repeated.
- Promotion threshold: Promote when multiple projects reuse the same gate structure successfully.
