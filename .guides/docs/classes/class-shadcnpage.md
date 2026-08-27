---
title: "Class: ShadcnPage"
description: "A [Page] that creates a [ShadcnPageRoute].   This is shadcn_flutter's replacement for `MaterialPage`, for use with  declarative navigation APIs such as [Navigator.pages] or `go_router`.   Example:  ```dart  Navigator(    pages: [      ShadcnPage(key: ValueKey('home'), child: const HomePage()),      if (showSettings)        ShadcnPage(key: ValueKey('settings'), child: const SettingsPage()),    ],    onDidRemovePage: (page) => ...,  );  ```"
---

```dart
/// A [Page] that creates a [ShadcnPageRoute].
///
/// This is shadcn_flutter's replacement for `MaterialPage`, for use with
/// declarative navigation APIs such as [Navigator.pages] or `go_router`.
///
/// Example:
/// ```dart
/// Navigator(
///   pages: [
///     ShadcnPage(key: ValueKey('home'), child: const HomePage()),
///     if (showSettings)
///       ShadcnPage(key: ValueKey('settings'), child: const SettingsPage()),
///   ],
///   onDidRemovePage: (page) => ...,
/// );
/// ```
class ShadcnPage<T> extends Page<T> {
  /// The content to show for this page.
  final Widget child;
  /// Whether to keep the page's state alive while it is covered.
  final bool maintainState;
  /// Whether the page is presented as a modal dialog.
  final bool fullscreenDialog;
  /// How long the push and pop animation runs for.
  final Duration transitionDuration;
  /// Creates a page backed by a [ShadcnPageRoute].
  const ShadcnPage({required this.child, this.maintainState = true, this.fullscreenDialog = false, this.transitionDuration = kDefaultPageTransitionDuration, super.key, super.canPop, super.onPopInvoked, super.name, super.arguments, super.restorationId});
  Route<T> createRoute(BuildContext context);
}
```
