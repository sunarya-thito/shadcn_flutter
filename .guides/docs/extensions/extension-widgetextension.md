---
title: "Extension: WidgetExtension"
description: "Reference for extension"
---

```dart
extension WidgetExtension on Widget {
  NeverWidgetBuilder get asBuilder;
  Widget sized({double? width, double? height});
  Widget constrained({double? minWidth, double? maxWidth, double? minHeight, double? maxHeight, double? width, double? height});
  Widget withPadding({double? top, double? bottom, double? left, double? right, double? horizontal, double? vertical, double? all, EdgeInsetsGeometry? padding});
  Widget withMargin({double? top, double? bottom, double? left, double? right, double? horizontal, double? vertical, double? all});
  Widget center({Key? key});
  Widget withAlign(AlignmentGeometry alignment);
  Widget positioned({Key? key, double? left, double? top, double? right, double? bottom});
  Widget expanded({int flex = 1});
  Widget withOpacity(double opacity);
  Widget clip({Clip clipBehavior = Clip.hardEdge});
  Widget clipRRect({BorderRadiusGeometry borderRadius = BorderRadius.zero, Clip clipBehavior = Clip.antiAlias});
  Widget clipOval({Clip clipBehavior = Clip.antiAlias});
  Widget clipPath({Clip clipBehavior = Clip.antiAlias, required CustomClipper<Path> clipper});
  Widget transform({Key? key, required Matrix4 transform});
  Widget intrinsicWidth({double? stepWidth, double? stepHeight});
  Widget intrinsicHeight();
  Widget intrinsic({double? stepWidth, double? stepHeight});
}
```
