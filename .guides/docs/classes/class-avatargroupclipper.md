---
title: "Class: AvatarGroupClipper"
description: "Reference for AvatarGroupClipper"
---

```dart
class AvatarGroupClipper extends CustomClipper<Path> {
  final double borderRadius;
  final Alignment alignment;
  final double previousAvatarSize;
  final double gap;
  const AvatarGroupClipper({required this.borderRadius, required this.alignment, required this.previousAvatarSize, required this.gap});
  Path getClip(Size size);
  bool shouldReclip(covariant AvatarGroupClipper oldClipper);
}
```
