---
title: "Class: AvatarGroupClipper"
description: "Custom clipper for creating overlapping avatar group effects."
---

```dart
/// Custom clipper for creating overlapping avatar group effects.
///
/// Clips avatars to create a stacked appearance where each avatar partially
/// overlaps the previous one, accounting for border radius and alignment.
class AvatarGroupClipper extends CustomClipper<Path> {
  /// The border radius for rounded corners on avatars.
  final double borderRadius;
  /// The alignment of avatars within the group.
  final Alignment alignment;
  /// The size of the previous avatar in the stack.
  final double previousAvatarSize;
  /// The gap between overlapping avatars.
  final double gap;
  /// Creates an avatar group clipper with the specified parameters.
  const AvatarGroupClipper({required this.borderRadius, required this.alignment, required this.previousAvatarSize, required this.gap});
  Path getClip(Size size);
  bool shouldReclip(covariant AvatarGroupClipper oldClipper);
}
```
