---
title: "Class: ContextAnchor"
description: "An [Anchor] resolved from a plain [BuildContext].   If [context] is null (`const ContextAnchor()`), it's resolved by the  consumer (e.g. [PopoverConfiguration.show]) to whatever [BuildContext]  the `show()` call itself received."
---

```dart
/// An [Anchor] resolved from a plain [BuildContext].
///
/// If [context] is null (`const ContextAnchor()`), it's resolved by the
/// consumer (e.g. [PopoverConfiguration.show]) to whatever [BuildContext]
/// the `show()` call itself received.
class ContextAnchor extends Anchor {
  /// The context to anchor to, or null to use the consumer's own context.
  final BuildContext? context;
  /// Creates a [ContextAnchor].
  const ContextAnchor([this.context]);
  AnchorSubscription subscribe();
  Anchor resolve(BuildContext context);
}
```
