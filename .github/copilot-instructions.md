# GitHub Copilot Instructions for this Repository

This document tells an LLM how to write and validate two critical things in this repo:

- The CHANGELOG (how to structure it, when to update it, and how to reconstruct missing entries)
- The API/class documentation for Dart/Flutter code (how to write comprehensive, analyzer-friendly docs)

Keep responses concise, actionable, and consistent with the rules below.

---

## CHANGELOG — How to write and maintain CHANGELOG.md

These instructions explain how `CHANGELOG.md` should be written, when it must be updated, and how to retroactively reconstruct entries from git history. They’re written so an LLM can produce deterministic, high-quality entries.

### High-level contract

- Input: a set of commits (or a PR) with file changes and metadata.
- Output: one or more well-formed markdown bullets under the `Unreleased` section (or under a new version when releasing). Each bullet includes category, short description, and reference (PR/commit) plus author.
- Error modes: missing context, very large diffs (>= 1000 changed lines). For large diffs, write a concise summary and flag for human review.

### Structure

Follow Keep a Changelog style, adapted for this repo:

- Top-level sections per version: `## [Unreleased]`, `## [x.y.z]`
- Categories under each version:
	- Added — new features
	- Changed — notable changes in existing functionality
	- Deprecated — features to be removed
	- Removed — features that have been removed
	- Fixed — bug fixes
	- Security — security-related fixes
	- Breaking Changes — any breaking change; must include a migration guide

Repository convention: Do not include dates in version headers. Use only the version number, e.g., `## [1.2.0]`.

Example header snippet:

```
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added

- ...

### Breaking Changes

- ...

## [1.2.0]

### Added

- Added example entry
```

### When to update

- Update `CHANGELOG.md` in the same PR whenever something user-visible is added, changed, or removed (API, behavior, UI, DX).
- Purely internal refactors with no user-visible impact may be omitted; this should be rare and explained in the PR.
- Breaking changes MUST be called out under `Breaking Changes` and include a migration guide.

### Entry format

Each bullet includes:

- Short summary in imperative voice, one line
- Reference and author in parentheses: `(PR 1234, @alice)` or `(commit abcdef1, @bob)`
- Optional short code example or link to docs

Examples:

- Added: New `FancyWidget` with dark mode (PR 1234, @alice)
- Fixed: Handle null pointer in `parseConfig` (fixes issue 432) (PR 2345, @carol)

### Breaking changes and migration guide

For breaking changes:

1. Add a bullet under `### Breaking Changes` with a short explanation and references.
2. Include a short migration guide (2–6 steps) with old → new examples.
3. Note any config/env/version requirements.

Example:

```
- Breaking: `WidgetX` removed in favor of `WidgetY` (PR 9999, @dev)

Migration guide:

1. Replace `WidgetX` with `WidgetY`.

```dart
// before
WidgetX(a: 1)

// after
WidgetY(a: 1, options: DefaultOptions())
```

2. Rename styles from `x-` to `y-` in CSS.

Notes: `WidgetY` changes default serialization; bump to v2.0.0.

### Retroactive updates (when the author forgot the CHANGELOG)

If a change merged without updating `CHANGELOG.md`, reconstruct entries using this algorithm:

1. Identify the PR or commit(s) that introduced the change.
2. Read the commit message. If descriptive (e.g., `feat: add X`), propose a bullet from it.
3. If the message is vague (e.g., `update`), compute diff size:
	 - Use a numstat view and sum inserted + deleted lines.
	 - If total changed lines < 1000: parse the diff to produce actionable bullets (Added/Changed/Fixed/Removed/Deprecated), mentioning affected APIs/files.
	 - If >= 1000: do NOT attempt detailed reconstruction. Write a brief summary and add a “manual review required” note with files-changed count.
4. Detect public API or behavior changes; if compatibility breaks, mark as Breaking and add a migration guide (or “Possible Breaking — needs review” if unsure).
5. Combine bullets, deduplicate, keep lines short (< 120 chars when possible), and use imperative tone (“Add X”).

### Quick examples (good style)

- Added: Support `--fast-mode` flag for `build` (PR 88, @alice)
- Changed: Large CLI refactor; removed legacy plugin adapter (PR 99, @bob) — Manual review required (diff >= 1000 lines)

### Reviewer checklist

- Ensure `CHANGELOG.md` is updated with each user-visible change.
- If missing, request updates or add them in a follow-up with attribution.
- For squash merges, ensure the PR still contains the changelog entry.

---

## Docs — How to write comprehensive Dart/Flutter documentation

Applies to all public APIs in `lib/**/*.dart`. This section helps LLMs produce consistent, analyzer-friendly docs.

### Goals

Each public API (class, constructor, named constructor, method, function, typedef, public field) should include:

- One-sentence summary (what it is/does)
- Overview (why, when to use, key behavior)
- Parameters with types/defaults/semantics
- Returns and side-effects (if applicable)
- 1–2 runnable examples (basic + slightly advanced)
- Notes, edge cases, gotchas
- Optional: See also (related APIs/components)

Keep it skimmable and concrete.

### Critical formatting rules (Dart/Flutter)

- Use triple-slash comments: `///`.
- Wrap generic types in backticks to avoid HTML interpretation:
	- Correct: `List<int>`, `ValueChanged<T?>`, `Map<FormKey, FutureOr<ValidationResult?>>`
	- Incorrect: List<int>, ValueChanged<T?>, Map<FormKey, FutureOr<ValidationResult?>>
- Link symbols with bracket links without generics: `[AnimatedBuilder]`, `[SelectController]`.
	- Show generics in inline code: `SelectController<T>` not `[SelectController<T>]`.
- Use fenced code blocks for examples: triple backticks with `dart`.
- Avoid HTML and angle brackets in prose; prefer Markdown and code spans.
- Prefer American English, present tense, active voice.

Analyzer tip: Fix `unintended_html_in_doc_comment` by wrapping generics in backticks.

### Standard sections and order

1. Short summary line
2. Overview/Details paragraph(s)
3. Parameters (bulleted):
	 - Pattern: `- [paramName] (`Type`, qualifiers): Description`
	 - Include defaults, optionality, constraints
4. Returns
5. Errors/Assertions
6. Example(s): fenced `dart` code
7. Notes/Edge cases
8. See also (bracket links; generics in code spans)

Example parameter bullets:

```
/// Parameters:
/// - [onChanged] (`ValueChanged<T>?`, optional): Called when the value changes.
/// - [controller] (`ComponentController<T>?`, optional): External state source.
/// - [items] (`List<Widget>`, required): Widgets to display.
```

### Templates

Class (component):

```
/// A concise one‑sentence summary of what this component does.
///
/// Longer overview explaining when and why to use it. Mention key behaviors,
/// lifecycle, state interactions, and customization points at a high level.
///
/// Parameters:
/// - [param1] (`Type`, required|optional|default: x): What it does.
/// - [param2] (`Type?`, optional): What it does.
/// - [onChanged] (`ValueChanged<T>?`, optional): When it fires and how.
///
/// Example:
/// ```dart
/// // Minimal usage
/// MyComponent(
///   value: 42,
///   onChanged: (v) => print(v),
/// )
/// ```
class MyComponent<T> extends StatelessWidget {
	// ...
}
```

Constructor (default):

```
/// Creates a [MyComponent].
///
/// Describe constructor‑specific behavior or constraints.
///
/// Parameters:
/// - [value] (`T`, required): Target value.
/// - [duration] (`Duration`, required): Animation duration.
/// - [curve] (`Curve`, default: `Curves.linear`): Timing curve.
/// - [onEnd] (`VoidCallback?`, optional): Called when complete.
///
/// Example:
/// ```dart
/// MyComponent<int>(
///   value: 10,
///   duration: const Duration(milliseconds: 300),
/// )
/// ```
const MyComponent({ /* ... */ });
```

Named constructor:

```
/// Creates a [MyComponent] with <mode> behavior.
///
/// Explain what’s different in this mode and when to use it.
///
/// Parameters:
/// - [builder] (`AnimationBuilder<T>`, required): Uses the animation directly.
/// - [curve] (`Curve`, default: `Curves.linear`): Timing curve.
///
/// Example:
/// ```dart
/// MyComponent<double>.animation(
///   value: 1,
///   duration: const Duration(seconds: 1),
///   builder: (context, animation) => FadeTransition(
///     opacity: animation,
///     child: const Text('Hello'),
///   ),
/// )
/// ```
const MyComponent.animation({ /* ... */ });
```

Method / Function:

```
/// One‑line description of what this does.
///
/// Longer explanation with context, inputs/outputs, and side‑effects.
///
/// Parameters:
/// - [source] (`Iterable<T>`, required): Items to process.
/// - [predicate] (`bool Function(T)`, optional): Filter condition.
///
/// Returns: `List<T>` — the filtered items.
///
/// Example:
/// ```dart
/// final result = filter<int>([1,2,3], (x) => x.isOdd);
/// ```
List<T> filter<T>(Iterable<T> source, [bool Function(T)? predicate]) { /* ... */ }
```

Typedef:

```
/// A callback that does X with Y and returns Z.
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [value] (`T`): Current value.
/// - [child] (`Widget?`): Optional child.
typedef MyBuilder<T> = Widget Function(BuildContext context, T value, Widget? child);
```

### Examples — guidance

- Use fenced code with `dart` and keep examples runnable.
- Prefer `const` where appropriate; avoid private/test-only APIs.
- Provide basic and slightly advanced examples when useful.

### Linking and cross-references

- Use bracket links for symbols: `[AnimatedValueBuilder]`, `[Button.primary]`.
- Do not include generics in link text; use inline code: `AnimatedValueBuilder<T>`.
- Use “See also” to reference related APIs.

### Common component patterns in this repo

- Controlled components: accept `controller` or `initialValue` with `onChanged`. Document that controller is the source of truth when provided.
- Theming: examples often use `ComponentTheme<SomeTheme>` — always wrap generics in backticks: `ComponentTheme<TrackerTheme>`.
- Animation builders: generics go in inline code: `AnimatedChildBuilder<T>`.
- Collections/predicates: always inline code: `List<T>`, `Iterable<T>`, `Predicate<T>`.

### Edge cases and gotchas

- Don’t write `[SelectController<T>]`. Write `[SelectController]` and show generics as `SelectController<T>`.
- Angle brackets in links cause analyzer warnings; wrap generics in backticks.
- Keep doc comments adjacent to the declarations they describe.

### Quality checks (quick pass)

- Run analyzer: PASS expected (`dart analyze`).
- Zero `unintended_html_in_doc_comment` warnings.
- No trailing spaces; consistent sentence casing.

### Auto-fix support (optional)

If generic angle brackets slipped through:

- Windows preview (no changes): `./fix_doc_generics.bat --dry-run`
- Windows apply: `./fix_doc_generics.bat`

The script scans `lib/**/*.dart` and wraps generic types in backticks in doc comments, skipping fenced code and already backticked spans.

### Quick Do / Don’t

- Do: `- [onChanged] (`ValueChanged<T>?`, optional): Called when value changes`
- Don’t: `- [onChanged] (ValueChanged<T>?, optional): Called when value changes`
- Do: use fenced `dart` code blocks
- Don’t: inline long examples or use HTML tags

---

## Tests — Component testing guidelines

All public components must ship with a dedicated test file and comprehensive widget tests. Tests should verify behavior, visuals, and accessibility across themes, text directions, and screen sizes.

### Goals

- Every public component has a corresponding test file in `test/`.
- Tests cover happy paths and edge cases, not just snapshots.
- Accessibility and responsiveness are validated whenever applicable.

### Placement and naming

- File location: `test/<package or area>/<component_name>_test.dart`
- One primary file per component; add focused companion files if needed (e.g., `..._rtl_test.dart`, `..._golden_test.dart`).

### What to test (checklist)

- Visibility and rendering
	- Renders without exceptions; visible with expected default state.
	- Important subparts present (e.g., label, icon, helper/error text).
- Size and layout
	- Respects constraints; min/max sizes behave as documented.
	- Expands/shrinks correctly in Flex/Stack/Constrained layouts.
- Position and alignment
	- Aligns as configured; anchors/offsets applied correctly.
- Interactivity and gestures
	- Tap/click/long‑press/hover trigger expected callbacks and state changes.
	- Disabled and read‑only states block interaction appropriately.
- Focus and keyboard
	- Focus traversal works; focus/blur events update visuals/state.
	- Keyboard shortcuts and text input behave per platform conventions.
- Scrolling and overflow
	- Scrolls when content exceeds bounds; no unexpected overflow.
- Theming and variants
	- Light/dark themes, high‑contrast modes, and variants (sizes/intent) apply correct colors, paddings, radii.
- RTL and internationalization
	- Layout mirrors in RTL; icons and paddings flip when appropriate.
	- Large text scales (e.g., `textScaleFactor=2.0`) do not clip or overlap.
- Responsiveness
	- Works on small and large screens; orientation changes do not break layout.
	- Respects breakpoints/constraints; no clipping or unintended wrapping.
- Accessibility and semantics
	- Proper semantics: roles, labels, values, states; `SemanticsTester` passes.
	- Tap targets meet minimum size; focus order logical.
- Error states and assertions
	- Invalid configurations throw meaningful assertions in debug mode.
	- Error UI renders when provided (e.g., validation messages).
- Animation timing and transitions
	- Animations run with expected curves/durations; intermediate frames stable.
- Optional: Golden tests
	- Add goldens for stable visual components; cover light/dark and key variants.

### Minimal widget test template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
// import your component

void main() {
	testWidgets('renders and is visible', (tester) async {
		await tester.pumpWidget(
			MaterialApp(
				theme: ThemeData.light(),
				home: Scaffold(body: YourComponent()),
			),
		);

		expect(find.byType(YourComponent), findsOneWidget);
	});

	testWidgets('responds to tap', (tester) async {
		var tapped = false;
		await tester.pumpWidget(MaterialApp(home: YourComponent(onTap: () => tapped = true)));

		await tester.tap(find.byType(YourComponent));
		await tester.pumpAndSettle();

		expect(tapped, isTrue);
	});
}
```

### Coverage expectations

- Aim for meaningful coverage over a numeric target; cover the checklist items relevant to the component.
- Prefer small, focused tests that assert behavior and user‑visible outcomes.

### Tips

- Use `pumpWidget` + `pump`/`pumpAndSettle` thoughtfully to advance animations.
- For semantics: wrap in `SemanticsTester` and assert roles/labels.
- For themes/RTL: run the same tests via helpers that rebuild with alternate `ThemeData` and `Directionality.rtl`.
- Use helpers from `test_helper.dart` for common test setup and utilities.

---

If these instructions ever change (e.g., a new threshold or style rule), update this file and mention the change in `CHANGELOG.md` under `Changed` in the next release.

