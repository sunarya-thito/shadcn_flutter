---
title: "Class: ImageTools"
description: "A widget providing image editing and manipulation tools."
---

```dart
/// A widget providing image editing and manipulation tools.
///
/// **Work in Progress** - This component is under active development and
/// currently throws [UnimplementedError] when built. The API and functionality
/// may change significantly in future releases.
///
/// Intended to provide comprehensive image editing capabilities including
/// cropping, rotation, scaling, filters, and other image transformations.
/// The tools work with [ImageProperties] to manage image state and
/// provide callbacks for property changes.
///
/// When completed, this component will offer an integrated image editing
/// interface suitable for profile pictures, content images, and other
/// image management scenarios within forms and content creation workflows.
///
/// Example (Future API):
/// ```dart
/// ImageTools(
///   image: Image.network('https://example.com/image.jpg'),
///   properties: currentImageProperties,
///   onPropertiesChanged: (newProperties) {
///     setState(() => currentImageProperties = newProperties);
///   },
/// )
/// ```
class ImageTools extends StatelessWidget {
  final Widget image;
  final ImageProperties properties;
  final ValueChanged<ImageProperties> onPropertiesChanged;
  const ImageTools({super.key, required this.image, required this.properties, required this.onPropertiesChanged});
  Widget build(BuildContext context);
}
```
