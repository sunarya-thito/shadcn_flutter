---
title: "Class: ShadcnPageTransition"
description: "Applies the shadcn page transition: a fade combined with a short vertical  slide.   Shared by [ShadcnPageRoute] and [ShadcnPage] so a route and a declarative  page look identical. Deliberately built from a single [SlideTransition] so  pages add exactly one [Transform] to the tree, the same as the Material  route this replaced."
---

```dart
/// Applies the shadcn page transition: a fade combined with a short vertical
/// slide.
///
/// Shared by [ShadcnPageRoute] and [ShadcnPage] so a route and a declarative
/// page look identical. Deliberately built from a single [SlideTransition] so
/// pages add exactly one [Transform] to the tree, the same as the Material
/// route this replaced.
class ShadcnPageTransition extends StatelessWidget {
  /// Drives the incoming page.
  final Animation<double> animation;
  /// The page content.
  final Widget child;
  /// Creates a shadcn page transition.
  const ShadcnPageTransition({super.key, required this.animation, required this.child});
  Widget build(BuildContext context);
}
```
