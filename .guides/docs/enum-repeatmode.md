---
title: "Enum: RepeatMode"
description: "Defines how a repeated animation should behave when it reaches completion."
---

```dart
/// Defines how a repeated animation should behave when it reaches completion.
///
/// Used by [RepeatedAnimationBuilder] to control animation looping behavior.
/// Each mode provides different patterns of repetition suitable for various
/// visual effects and UI animations.
enum RepeatMode {
  /// Restarts the animation from the beginning each time it completes.
  ///
  /// The animation goes from start → end, then immediately jumps back to start
  /// and repeats. This creates a consistent forward motion with instant resets.
  repeat,
  /// Plays the animation in reverse each cycle.
  ///
  /// The animation goes from end → start repeatedly. This is useful when you
  /// want the reverse of the normal animation behavior as the primary motion.
  reverse,
  /// Alternates between forward and reverse directions.
  ///
  /// The animation goes start → end → start → end, creating a smooth back-and-forth
  /// motion without any jarring transitions. Also known as "yoyo" animation.
  pingPong,
  /// Same as pingPong, but starts with reverse direction.
  ///
  /// The animation goes end → start → end → start, beginning with the reverse
  /// motion first. Useful when the initial state should be the "end" value.
  pingPongReverse,
}
```
