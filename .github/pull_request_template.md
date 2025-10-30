## Summary

Briefly describe what this PR changes and why.

- Motivation / Context:
- Related discussions / background:

## Type of change

- [ ] fix: Bug fix (non-breaking change)
- [ ] feat: New feature / new component
- [ ] perf: Performance improvement
- [ ] refactor/chore: Code refactor or tooling update
- [ ] docs: Documentation only
- [ ] build/devtools: Generators, scripts, or infra changes

## Scope (check all that apply)

- [ ] Components (lib/src/components/...)
- [ ] Utilities (lib/src/util.dart, animation/collection, platform)
- [ ] Icons / Fonts (icons/, lib/icons/, pubspec fonts)
- [ ] Theme / Colors (lib/src/theme/, colors/ + style transpilers)
- [ ] Docs app (docs/)
- [ ] Generators / Tools (gen/bin/)
- [ ] Example app (example/)
- [ ] Tests (example/test/, test_widget/)
- [ ] CI / Workflows

## Linked issues

Closes # Refs #

## Screenshots / Videos (if UI)

Include light/dark and relevant states.

## Breaking changes

- [ ] Yes (add migration notes below)
- [ ] No

Migration notes (if breaking):

## How I tested

- Manual verification in example app
- Manual verification in docs app (Chrome)
- Widget tests added/updated
- Other:

## Checklist

Please ensure the following are complete before requesting review. See
CONTRIBUTING.md for details.

- [ ] Code formatted (dart format .)
- [ ] Analyzer passes (flutter analyze)
- [ ] Tests added/updated and passing (flutter test where applicable)
- [ ] Public API documented (public_member_api_docs)
- [ ] Docs/examples updated (docs pages or README images)
- [ ] Exports updated in lib/shadcn_flutter.dart (for new public widgets)
- [ ] A11y validated in docs (run_docs_web_semantics.bat)
- [ ] Generators run when relevant:
  - [ ] Icons (bootstrap/lucide/radix generators)
  - [ ] Styles/Colors (style_transpiler_v4.dart or style_transpiler.dart,
        color_generator.dart)
  - [ ] LLMs / Guides (gen_llms.bat, gen_dotguides.bat)
  - [ ] Analyzer task lists (docs_divide.dart)
- [ ] CHANGELOG updated (if user-visible change)

## Additional notes

Optional: risks, roll-out plan, or follow-ups.
