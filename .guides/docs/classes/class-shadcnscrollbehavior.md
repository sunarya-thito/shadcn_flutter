---
title: "Class: ShadcnScrollBehavior"
description: "Default scroll behavior for shadcn_flutter applications."
---

```dart
/// Default scroll behavior for shadcn_flutter applications.
///
/// Provides bouncing physics and platform-appropriate scrollbars.
class ShadcnScrollBehavior extends ScrollBehavior {
  /// Creates a shadcn scroll behavior.
  const ShadcnScrollBehavior();
  ScrollPhysics getScrollPhysics(BuildContext context);
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details);
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details);
}
```
