---
title: "Class: FileIconProvider"
description: "Reference for FileIconProvider"
---

```dart
class FileIconProvider extends StatelessWidget {
  final FileIconBuilder? builder;
  final Map<String, Widget>? icons;
  final Widget child;
  const FileIconProvider.builder({super.key, FileIconBuilder this.builder = _buildFileIcon, required this.child});
  const FileIconProvider({super.key, required this.icons, required this.child});
  Widget build(BuildContext context);
  static Widget buildIcon(BuildContext context, String extension);
}
```
