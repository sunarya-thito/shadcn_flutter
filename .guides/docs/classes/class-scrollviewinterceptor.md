---
title: "Class: ScrollViewInterceptor"
description: "Widget that intercepts scroll events to simulate middle-button drag scrolling."
---

```dart
/// Widget that intercepts scroll events to simulate middle-button drag scrolling.
///
/// Helps simulate middle-hold scroll on web and desktop platforms by intercepting
/// pointer events and converting drag gestures into scroll events.
class ScrollViewInterceptor extends StatefulWidget {
  /// The child widget to wrap with scroll interception functionality.
  final Widget child;
  /// Whether scroll interception is enabled.
  final bool enabled;
  /// Creates a scroll view interceptor.
  const ScrollViewInterceptor({super.key, required this.child, this.enabled = true});
  State<ScrollViewInterceptor> createState();
}
```
