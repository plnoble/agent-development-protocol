# Decision Log

## 2026-06-12 - Use a hybrid protocol model

Decision: Use a shared project protocol plus tool-specific skills.

Alternatives considered:

- Long startup prompt only.
- Codex skill only.
- Claude skill only.

Why chosen:

The shared project files give all agents the same handoff state, while tool-specific skills improve behavior inside each agent ecosystem. A long startup prompt is easy to forget and hard to evolve.

Consequences:

- New projects need one initialization step.
- Codex and Claude skills must be maintained separately if both are used.
- `AGENTS.md` remains the cross-tool source of truth.

## 2026-06-12 - Distill prompt libraries into compact protocol surfaces

Decision: Extract the useful ideas from the prior prompt files into lightweight project files instead of copying the long prompts verbatim.

Alternatives considered:

- Store the full prompts in the repository.
- Expand `AGENTS.md` with every engineering rule and release checklist item.
- Keep the current protocol unchanged.

Why chosen:

The old prompts contain useful concepts, especially task-start analysis, structured memory, end-of-task reflection, quality checks, and skill distillation. Copying all of them would make every agent read too much generic text and would increase the chance of noisy logs.

Consequences:

- `reflections.md` captures the mandatory end-of-task retrospective.
- `quality-gates.md` captures adaptive pre-change and pre-delivery checks.
- `AGENTS.md` stays short enough to be read every session.
- Long domain-specific checks can later become separate skills or scripts if repeated.
