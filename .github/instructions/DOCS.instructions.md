---
applyTo: "**/*.dart'
---

# Guide for Writing Comprehensive Docs in this Repository

This guide is for AI assistants (and humans) contributing documentation to this Dart/Flutter codebase. It explains the style we expect and the exact patterns to use so your docs are complete, linkable, and analyzer-friendly.

## Goals at a Glance

Every public API (class, constructor, named constructor, method, function, typedef, public field) should have:

- A short, one‑sentence description (what it is/does)
- A clear overview (why, when to use, key behavior)
- Parameters section with types, defaults, and semantics
- Returns and side‑effects (when applicable)
- 1–2 runnable examples (basic + slightly advanced)
- Notes, edge cases, and gotchas
- Optional: See also (related APIs/components)

Keep it skimmable. Prefer concrete language. Avoid fluff.

## Critical Formatting Rules (Dart/Flutter docs)

These conventions eliminate analyzer warnings and keep docs consistent:

- Use triple‐slash comments: `///`.
- Always wrap generic types in inline code backticks to avoid HTML interpretation.
  - Correct: `List<int>`, `ValueChanged<T?>`, `Map<FormKey, FutureOr<ValidationResult?>>`
  - Incorrect: List<int>, ValueChanged<T?>, Map<FormKey, FutureOr<ValidationResult?>>
- When linking symbols, use square‐bracket links without generics: `[AnimatedBuilder]`, `[SelectController]`.
  - For generic variants, use inline code: `SelectController<T>` not `[SelectController<T>]`.
- Use fenced code blocks for examples: three backticks with `dart`.
- Avoid raw HTML or angle brackets in prose. Prefer Markdown and code spans.
- Prefer American English; use present tense and active voice.

Analyzer tip: The warning `unintended_html_in_doc_comment` is caused by unescaped angle brackets. Wrapping generic types in backticks fixes it.

## Standard Sections and Order

Put these sections in this order when they apply:

1. Short summary line
2. Overview/Details paragraph(s)
3. Parameters:
   - Use a bulleted list with this exact pattern:
     - `- [paramName] (`Type`, qualifiers): Description`
     - Include default values, optionality, and constraints.
4. Returns: Describe the return type/semantics (for functions/methods)
5. Errors/Assertions: Note thrown errors or assertions
6. Example(s): Fenced code blocks with `dart`
7. Notes/Edge cases: Any behavioral caveats
8. See also: Links to related APIs using bracket links (no generics in the link), and inline code for generics

Example parameter bullet (pay attention to code spans):

```
/// Parameters:
/// - [onChanged] (`ValueChanged<T>?`, optional): Called when the value changes.
/// - [controller] (`ComponentController<T>?`, optional): External state source.
/// - [items] (`List<Widget>`, required): Widgets to display.
```

## Templates (copy/paste)

### Class (Component) template

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

### Constructor (default) template

```
/// Creates a [MyComponent].
///
/// Describe constructor‐specific behavior or constraints.
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

### Named constructor template

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

### Method / Function template

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

### Typedef template

```
/// A callback that does X with Y and returns Z.
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [value] (`T`): Current value.
/// - [child] (`Widget?`): Optional child.
typedef MyBuilder<T> = Widget Function(BuildContext context, T value, Widget? child);
```

## Examples: guidance

- Use fenced code with `dart`.
- Keep examples minimal and runnable in a snippet context.
- Prefer const constructors where appropriate.
- Show defaults implicitly; mention them in the params list.
- Avoid private APIs or test‑only utilities.
- Show one basic and one slightly advanced example if useful.

## Linking and cross‑references

- Link classes/methods with square brackets: `[AnimatedValueBuilder]`, `[Button.primary]`.
- Do not include generics in link text; use inline code instead: `AnimatedValueBuilder<T>`.
- Use “See also” for related APIs and concepts.

## Common component patterns in this repo

- Controlled components: usually accept either `controller` or `initialValue` with `onChanged`.
  - Document that if a controller is provided, it’s the source of truth.
- Theming: many examples use `ComponentTheme<SomeTheme>` — always wrap generics in backticks: `ComponentTheme<TrackerTheme>`.
- Animation builders: builder types are generic; write them as inline code: `AnimatedChildBuilder<T>`.
- Collections and predicates: `List<T>`, `Iterable<T>`, `Predicate<T>` — always inline code.

## Edge cases and gotchas

- Do not write `[SelectController<T>]` — write `[SelectController]` and put the generic form in code: `SelectController<T>`.
- Angle brackets inside links trigger the analyzer warning; code spans are safe.
- Keep doc comments close to the declaration they describe.

## Quality checks (quick pass)

- Run the analyzer and ensure PASS:
  - `dart analyze`
- Zero occurrences of `unintended_html_in_doc_comment`.
- No trailing spaces; use consistent sentence casing.

## Auto‑fix support (optional)

If you see angle‑bracket warnings after writing docs, you can auto‑wrap generics in this repo:

- Preview (no changes):
  - Windows: `./fix_doc_generics.bat --dry-run`
- Apply:
  - Windows: `./fix_doc_generics.bat`

This script scans `lib/**/*.dart` doc comments and wraps generic types in backticks, skipping fenced code blocks and existing backticked spans.

## Quick “Do / Don’t”

- Do: `- [onChanged] (`ValueChanged<T>?`, optional): Called when value changes`
- Don’t: `- [onChanged] (ValueChanged<T>?, optional): Called when value changes`
- Do: use fenced `dart` code blocks for examples
- Don’t: inline long examples or use HTML tags

---

Following this guide will keep our docs consistent, discoverable, and warning‑free. If you’re unsure, mirror the style from `animation.dart`, `select.dart`, `button.dart`, and other recently updated files.
