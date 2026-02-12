---
title: "Class: InputAboveBelowFeature"
description: "Adds a custom widget above or below the text input area.   Use this feature to place helper content inside the input decoration,  directly above or below the editable text.   Example:  ```dart  TextField(    features: [      InputAboveBelowFeature(        child: Text('Billing email').small().muted(),        position: InputFeaturePosition.above,      ),    ],  )  ```"
---

```dart
/// Adds a custom widget above or below the text input area.
///
/// Use this feature to place helper content inside the input decoration,
/// directly above or below the editable text.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputAboveBelowFeature(
///       child: Text('Billing email').small().muted(),
///       position: InputFeaturePosition.above,
///     ),
///   ],
/// )
/// ```
class InputAboveBelowFeature extends InputFeature {
  /// Widget shown above or below the editable text.
  final Widget? child;
  /// Position of the [child] relative to the editable text.
  final InputFeaturePosition position;
  /// Creates an [InputAboveBelowFeature].
  ///
  /// Parameters:
  /// - [child] (`Widget?`, optional): Widget displayed above or below the input text.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.below`): Placement.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAboveBelowFeature({super.visibility, super.skipFocusTraversal, this.child, this.position = InputFeaturePosition.below});
  /// Creates an [InputAboveBelowFeature] displayed above the input text.
  ///
  /// Parameters:
  /// - [child] (`Widget?`, optional): Widget displayed above the input text.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAboveBelowFeature.above(this.child, {super.visibility, super.skipFocusTraversal});
  /// Creates an [InputAboveBelowFeature] displayed below the input text.
  ///
  /// Parameters:
  /// - [child] (`Widget?`, optional): Widget displayed below the input text.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAboveBelowFeature.below(this.child, {super.visibility, super.skipFocusTraversal});
  InputFeatureState createState();
}
```
