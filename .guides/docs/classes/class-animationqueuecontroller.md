---
title: "Class: AnimationQueueController"
description: "A controller that manages a queue of animation requests."
---

```dart
/// A controller that manages a queue of animation requests.
///
/// This class extends [ChangeNotifier] and provides a way to queue multiple
/// animations that execute sequentially or replace the current queue. It
/// handles timing via [tick] calls and notifies listeners of value changes.
///
/// ## Overview
///
/// Use [AnimationQueueController] when you need to chain multiple animations
/// or dynamically add/remove animation steps. Call [tick] regularly (e.g., in
/// a ticker or animation frame callback) to progress the animations.
///
/// ## Example
///
/// ```dart
/// final controller = AnimationQueueController(0.0);
///
/// // Queue animations
/// controller.push(AnimationRequest(0.5, Duration(milliseconds: 200), Curves.easeIn));
/// controller.push(AnimationRequest(1.0, Duration(milliseconds: 300), Curves.easeOut));
///
/// // In ticker
/// controller.tick(deltaTime);
/// ```
class AnimationQueueController extends ChangeNotifier {
  /// Creates an animation queue controller with an optional initial value.
  ///
  /// ## Parameters
  ///
  /// * [_value] - The initial value. Defaults to `0.0`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final controller = AnimationQueueController(0.5);
  /// ```
  AnimationQueueController([this._value = 0.0]);
  /// Adds an animation request to the queue or replaces the current queue.
  ///
  /// ## Parameters
  ///
  /// * [request] - The animation request to add.
  /// * [queue] - If `true` (default), adds to the queue. If `false`, clears
  ///   the queue and current runner, making this the only animation.
  ///
  /// ## Side Effects
  ///
  /// Notifies listeners after modifying the queue.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Add to queue
  /// controller.push(request);
  ///
  /// // Replace queue
  /// controller.push(request, false);
  /// ```
  void push(AnimationRequest request, [bool queue = true]);
  /// Sets the current value immediately, clearing all queued animations.
  ///
  /// ## Parameters
  ///
  /// * [value] - The new value to set.
  ///
  /// ## Side Effects
  ///
  /// Clears the animation queue and runner, then notifies listeners.
  ///
  /// ## Example
  ///
  /// ```dart
  /// controller.value = 0.5; // Jumps to 0.5, cancels animations
  /// ```
  set value(double value);
  /// Gets the current animation value.
  ///
  /// ## Returns
  ///
  /// The current value, which may be actively animating.
  double get value;
  /// Checks if there are pending animations or an active runner.
  ///
  /// ## Returns
  ///
  /// `true` if animations should continue to be ticked, `false` otherwise.
  ///
  /// ## Example
  ///
  /// ```dart
  /// if (controller.shouldTick) {
  ///   controller.tick(deltaTime);
  /// }
  /// ```
  bool get shouldTick;
  /// Advances the animation by the given time delta.
  ///
  /// Call this method regularly (e.g., from a ticker) to progress animations.
  /// If the current animation completes, the next queued animation starts.
  ///
  /// ## Parameters
  ///
  /// * [delta] - The time elapsed since the last tick.
  ///
  /// ## Side Effects
  ///
  /// Updates [value] and notifies listeners as the animation progresses.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // In a ticker callback
  /// void _tick(Duration elapsed) {
  ///   final delta = elapsed - _lastElapsed;
  ///   controller.tick(delta);
  ///   _lastElapsed = elapsed;
  /// }
  /// ```
  void tick(Duration delta);
}
```
