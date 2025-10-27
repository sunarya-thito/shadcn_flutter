---
title: "Class: FileItem"
description: "Reference for FileItem"
---

```dart
class FileItem extends StatelessWidget {
  final double? uploadProgress;
  final VoidCallback? onRemove;
  final VoidCallback? onRetry;
  final VoidCallback? onDownload;
  final Widget? thumbnail;
  final VoidCallback? onPreview;
  final Widget fileName;
  final Widget? fileSize;
  final Widget? fileType;
  const FileItem({super.key, this.uploadProgress, this.onRemove, this.onRetry, this.onDownload, this.thumbnail, this.onPreview, required this.fileName, this.fileSize, this.fileType});
  Widget build(BuildContext context);
}
```
