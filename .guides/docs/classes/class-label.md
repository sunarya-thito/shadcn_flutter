---
title: "Class: Label"
description: "A layout widget for labels with optional leading and trailing elements."
---

```dart
/// A layout widget for labels with optional leading and trailing elements.
///
/// Arranges a main label with optional leading and trailing widgets in a
/// horizontal layout with consistent spacing.
///
/// Example:
/// ```dart
/// Label(
///   leading: Icon(Icons.person),
///   child: Text('Name'),
///   trailing: Icon(Icons.edit),
/// )
/// ```
class Label extends StatelessWidget {
  /// Optional leading widget displayed before the label.
  final Widget? leading;
  /// The main label content.
  final Widget child;
  /// Optional trailing widget displayed after the label.
  final Widget? trailing;
  /// Creates a [Label].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Main label content.
  /// - [leading] (`Widget?`, optional): Leading widget.
  /// - [trailing] (`Widget?`, optional): Trailing widget.
  const Label({super.key, this.leading, required this.child, this.trailing});
  Widget build(BuildContext context);
}
```
