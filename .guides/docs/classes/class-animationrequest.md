---
title: "Class: AnimationRequest"
description: "Represents a request to animate to a specific target value."
---

```dart
/// Represents a request to animate to a specific target value.
///
/// This class encapsulates the parameters needed for a single animation step,
/// including the target value, duration, and easing curve.
///
/// ## Overview
///
/// Use [AnimationRequest] with [AnimationQueueController] to queue multiple
/// animation steps that will be executed sequentially or as replacements.
///
/// ## Example
///
/// ```dart
/// final request = AnimationRequest(
///   1.0,
///   Duration(milliseconds: 300),
///   Curves.easeOut,
/// );
/// controller.push(request);
/// ```
class AnimationRequest {
  /// The target value to animate to (typically 0.0 to 1.0).
  final double target;
  /// The duration of the animation.
  final Duration duration;
  /// The easing curve to apply during the animation.
  final Curve curve;
  /// Creates an animation request with the specified parameters.
  ///
  /// ## Parameters
  ///
  /// * [target] - The destination value for the animation.
  /// * [duration] - How long the animation should take.
  /// * [curve] - The easing curve to use.
  AnimationRequest(this.target, this.duration, this.curve);
}
```
