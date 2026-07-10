# Contributing to shadcn_flutter

Thanks for your interest in contributing! This guide explains how the project is
organized, how to set up your environment, and the expectations for
contributions across components, utilities, icons, docs, and developer tooling.

If you get stuck, please open a discussion or hop into Discord:
https://discord.gg/ZzfBPQG4sV

## Before opening a pull request

To ensure your contribution is accepted and to prevent wasted effort, please follow these steps before submitting a Pull Request (PR):

1.  **Open an issue first**: Describe the problem you are solving or the feature you are proposing.
2.  **Propose your solution**: Explain how you intend to fix the issue. This allows us to validate the problem and discuss the approach before you invest time in coding.
    - Some issues might be better solved in user code rather than the library.
    - We may have a specific design or architectural preference for the solution.
3.  **Request assignment**: State in the issue that you would like to work on it and wait for it to be assigned to you.
4.  **Link the issue**: When you open your PR, please link to the issue it resolves.

PRs that do not follow this process may be closed if the solution is not aligned with the project's goals or if the problem is deemed invalid.

## Quick start

- Flutter: >= 3.32.3
- Dart SDK: >= 3.6.0 < 4.0.0
- Platforms: mobile, desktop, and web (docs run on web)

Windows PowerShell quickstart:

```powershell
# From repository root - resolves dependencies for every package in the workspace
flutter --version
flutter pub get

# Run the example app
cd packages/shadcn_flutter/example
flutter run

# Run the docs app in Chrome with web semantics (recommended for a11y checks)
cd ../../..
./run_docs_web_semantics.bat
```

## Project layout (high level)

- `packages/shadcn_flutter/` – The published library package
  - `lib/` – Public package code
    - `shadcn_flutter.dart` – Barrel exports for the public API
    - `src/` – Implementation details
      - `components/` – Components grouped by domain (form, layout, overlay, etc.)
      - `theme/` – Tokens, generated themes, typography, color schemes
      - `icons/` – Icon primitives (wired to fonts configured in `pubspec.yaml`)
      - `util.dart`, `animation.dart`, `collection.dart` – Shared utilities
  - `test/` – Widget/unit tests for the library
  - `icons/` – Source icon sets and licenses
  - `colors/` – CSS sources used by style transpilers (for docs/themes)
  - `docs_images/` – Images used in the package README
- `packages/docs/` – Flutter Web docs application (component gallery, usage examples)
- `packages/shadcn_flutter/example/` – Minimal consumer app, nested inside the
  library package so it's included in the pub.dev "Example" tab on publish
- `packages/gen/` – Developer tools and generators (icons, styles, LLM docs, analyzer
  helpers)
  - `bin/` – Entrypoints (e.g. `docs_divide.dart`, `llms_gen.dart`,
    `style_transpiler_v4.dart`)
  - `log/` – Analyzer outputs and derived task lists
- `packages/shadcn_flutter_genui/` – GenUI catalog that renders AI-generated
  interfaces using shadcn_flutter widgets
- `web_loaders/` – Standalone JS loader served via CDN at a fixed public URL
  (`cdn.jsdelivr.net/gh/sunarya-thito/shadcn_flutter@latest/web_loaders/...`);
  intentionally kept at the repo root and must not be moved.

## Contribution types

- Components: new widgets or improvements to existing ones
- Utilities: shared helpers, platform interfaces, collection/animation utils
- Icons/Fonts: adding or updating icon sets and font assets
- Docs: pages, examples, and site-level improvements
- Dev tools: generators and scripts that help build/maintain the library
- Tests: unit/widgets tests (example and test projects)

## Standards and expectations

- Code style: follow the repo lints (`packages/shadcn_flutter/analysis_options.yaml`).
  Public members must have API docs (`public_member_api_docs`).
- Null-safety: all code must be null-safe.
- API design: favor composition over inheritance, keep widgets small and
  testable, avoid breaking changes without discussion.
- Theming: consume tokens from `src/theme` and keep visual parity with shadcn/ui
  defaults when applicable.
- Accessibility: ensure focus management, keyboard navigation, semantics, and
  readable contrast. Validate using the docs app with web semantics enabled.
- Performance: use `const` where possible, avoid unnecessary rebuilds, prefer
  lightweight layouts, and memoize expensive computations where appropriate.
- Tests: add or update tests when behavior changes; keep example/test_widget
  green.
- Commits/PRs: use clear commit titles (Conventional Commits encouraged) and a
  concise PR description with screenshots/gifs for UI changes.
- Scope: avoid editing files that are not related to your pull request.
  - Do not include large diffs caused by formatting unrelated files.
  - Do not commit build outputs or generated files unless strictly necessary.
  - Do not include additional changes that were not stated in your proposal.
    - If you want to add additional changes, please open another issue and PR, or edit your proposal and notify your assignee.

## Local development

- Install tooling once:
  - Flutter 3.32.3+ and Dart 3.6+
  - Chrome for web docs

- Typical workflow:

```powershell
# 1) Get packages (resolves the whole workspace in one shared pubspec.lock)
flutter pub get

# 2) Run analyzer (root; analyzes every workspace package)
flutter analyze

# 3) Run example app while iterating on widgets
cd packages/shadcn_flutter/example
flutter run

# 4) Run docs with web semantics to check a11y/keyboard behavior
cd ../../..
./run_docs_web_semantics.bat
```

- Format code:

```powershell
# From repo root
dart format .
```

## Submitting changes

1. Discuss first for big changes. Open an issue to align on API and scope.
2. Create a feature/fix branch (e.g. `feat/card-media`,
   `fix/select-focus-trap`).
3. Make changes and update docs and tests as needed.
4. Ensure quality gates pass locally:

```powershell
flutter pub get
flutter analyze

# Run tests (example and test_widget projects, if applicable)
cd packages/shadcn_flutter/example; flutter test; cd ../../..
cd test_widget; flutter test; cd ..

# Optional: rebuild LLM/docs helper files when relevant
./gen_dotguides.bat

# Optional: generate analyzer task parts after heavy changes
# Produces checklists under packages/gen/log/analyze_parts/
dart run packages/gen/bin/docs_divide.dart
```

5. Push and open a pull request. Include:
   - Summary of the change and motivation
   - Screenshots/gifs for visual components (light/dark if relevant)
   - Breaking changes (if any) and migration notes
   - Checklist confirming analyzer/tests/docs were updated

## Feature-specific guides

### 1) Components

Where:

- `packages/shadcn_flutter/lib/src/components/<domain>/...` for implementation
- Export from `packages/shadcn_flutter/lib/shadcn_flutter.dart` to make the component public
- Add docs examples under `packages/docs/lib/pages/docs/components/<component>/...`

Checklist:

- Name: match shadcn/ui naming where it makes sense; use Flutter idioms for
  props.
- API: keep props minimal; prefer stateless widgets and composition; support
  theming via `src/theme` tokens.
- Accessibility: verify focus order, keyboard navigation, and semantics. Use
  `./run_docs_web_semantics.bat` to run docs with `ENABLE_WEB_SEMANTICS`.
- Layout: ensure responsiveness; test in narrow and wide layouts.
- Exports: update `packages/shadcn_flutter/lib/shadcn_flutter.dart` to export your widget(s) in the
  appropriate section.
- Docs: add at least one runnable example and a short explanation. If images are
  needed for README, place them in `packages/shadcn_flutter/docs_images/`.
- Tests: add widget tests in `packages/shadcn_flutter/example/test` or `test_widget/test` (pick the
  closest target).

Suggested structure:

- One primary widget file; split subparts when it improves clarity.
- Keep internal helpers private (prefix with `_`) and document all public
  classes/members.

### 2) Utilities

Where:

- `packages/shadcn_flutter/lib/src/util.dart`, `packages/shadcn_flutter/lib/src/animation.dart`,
  `packages/shadcn_flutter/lib/src/collection.dart`, or a new file under
  `packages/shadcn_flutter/lib/src/`

Guidelines:

- Keep APIs small and composable; document behavior and edge cases.
- Avoid leaking implementation details to the public API unless intended;
  re-export from `shadcn_flutter.dart` only when stable.
- Add unit tests where feasible; add a docs page if the utility affects
  user-facing behavior.

### 3) Icons and fonts

Sources & assets:

- Icon sources live under `packages/shadcn_flutter/icons/` (e.g.,
  `packages/shadcn_flutter/icons/bootstrap`, `packages/shadcn_flutter/icons/lucide`,
  `packages/shadcn_flutter/icons/radix`) with licenses included.
- Packaged fonts are registered in `packages/shadcn_flutter/pubspec.yaml` under
  `flutter/fonts` and stored in `packages/shadcn_flutter/lib/icons/`.

Generators:

- Bootstrap: `packages/gen/bin/bootstrap_icon_generator.dart`
- Lucide: `packages/gen/bin/lucide_icons_generator.dart`
- Radix: `packages/gen/bin/radix_icon_generator.dart`
- Convert WOFF2 → OTF: `packages/gen/bin/woff2otf.dart`

Typical flow (run from the repo root):

```powershell
# After updating sources under packages/shadcn_flutter/icons, regenerate the Dart bindings/fonts as needed
dart run packages/gen/bin/bootstrap_icon_generator.dart
dart run packages/gen/bin/lucide_icons_generator.dart
dart run packages/gen/bin/radix_icon_generator.dart

# If you add new font files, ensure packages/shadcn_flutter/pubspec.yaml has matching entries under flutter/fonts
```

Docs:

- Update icon showcase pages in `packages/docs/lib/pages/docs/icons_page.dart` if new
  sets are added.

### 4) Translations

- Localization files are located in `packages/shadcn_flutter/lib/l10n/`.
- The source of truth is `shadcn_en.arb`.

To add a new language:

1. Create a new ARB file in `packages/shadcn_flutter/lib/l10n/` (e.g., `shadcn_es.arb` for Spanish).
2. Copy the content from `shadcn_en.arb` to the new file.
3. Update the `@@locale` key to the new locale code (e.g., `"@@locale": "es"`).
4. Translate the values.
5. Run `flutter gen-l10n` (from `packages/shadcn_flutter/`) to generate the Dart code.

To update existing translations:

1. Modify the relevant ARB file in `packages/shadcn_flutter/lib/l10n/`.
2. Run `flutter gen-l10n` (from `packages/shadcn_flutter/`) to regenerate the Dart code.

### 5) Theming and colors

- Theme tokens and generated themes live under `packages/shadcn_flutter/lib/src/theme/`.
- If you change color sources in `packages/shadcn_flutter/colors/`, use the style transpilers to
  regenerate Dart styles (run from the repo root):

```powershell
# Transpile styles (versioned)
dart run packages/gen/bin/style_transpiler_v4.dart
# or
dart run packages/gen/bin/style_transpiler.dart

# Generate color helpers if needed
dart run packages/gen/bin/color_generator.dart
```

- Validate changes visually in the docs app (light/dark + multiple color
  schemes).

### 5) Docs site and examples

Run locally:

```powershell
# Recommended (enables accessible web semantics)
./run_docs_web_semantics.bat

# Manual
cd packages/docs
flutter run -d chrome --dart-define=ENABLE_WEB_SEMANTICS=true
```

Add docs:

- New component page: add an example directory under
  `packages/docs/lib/pages/docs/components/<component>/` and register in the component
  pages where needed.
- Global docs (installation, theme, typography, etc.): see
  `packages/docs/lib/pages/docs/*`.
- Sidebar/nav: `packages/docs/lib/pages/docs/sidebar_nav.dart` and related pages.

LLMs and guides:

- Generate machine‑readable references after component changes (run from the repo root):

```powershell
./gen_llms.bat         # runs: dart run packages/gen/bin/llms_gen.dart
./gen_dotguides.bat    # runs: dart run packages/gen/bin/dotguides_gen.dart
```

Analyzer task lists for docs reviews:

```powershell
dart run packages/gen/bin/docs_divide.dart
# Outputs checklists under packages/gen/log/analyze_parts/
```

## Testing

- Prefer adding a minimal widget test when changing behavior.
- Places to put tests:
  - `packages/shadcn_flutter/example/test/` – runs against the example app
  - `test_widget/` – separate test harness project

Run tests:

```powershell
cd packages/shadcn_flutter/example; flutter test; cd ../../..
cd test_widget; flutter test; cd ..
```

## Commit messages and PRs

- Conventional Commits encouraged (e.g., `feat: add pagination widget`,
  `fix(select): correct focus restoration`).
- Scope examples: `alert`, `pagination`, `theme`, `docs`, `icons`, `generator`.
- Keep PRs focused; large refactors should be split where possible.

PR checklist:

- [ ] Code formatted (`dart format .`)
- [ ] Analyzer passes (`flutter analyze`)
- [ ] Tests added/updated and passing (`flutter test` where applicable)
- [ ] Public API documented (`public_member_api_docs`)
- [ ] Docs/examples updated (docs pages or README images if needed)
- [ ] Exports updated in `packages/shadcn_flutter/lib/shadcn_flutter.dart` (for new public widgets)
- [ ] Generators run (icons/styles/LLMs) when relevant

## Issue reporting

- Use GitHub Issues for bugs and feature requests.
- Include reproduction steps, expected vs. actual behavior, environment
  (`flutter doctor -v`), and screenshots when UI-related.

## Code of conduct

Please be respectful and follow the GitHub Community Guidelines in all
interactions. We foster an inclusive, welcoming environment for contributors of
all backgrounds and experience levels.

## License

By contributing, you agree that your contributions will be licensed under the
project’s license (see `LICENSE`).
