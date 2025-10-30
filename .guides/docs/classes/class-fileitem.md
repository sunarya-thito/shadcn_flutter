---
title: "Class: FileItem"
description: "A widget representing a single file item in a file picker or upload list."
---

```dart
/// A widget representing a single file item in a file picker or upload list.
///
/// [FileItem] displays information about a selected or uploaded file including
/// name, size, type, and optional thumbnail. It provides interactive controls
/// for file management such as remove, retry, download, and preview actions.
///
/// Supports displaying upload progress for files currently being uploaded and
/// provides visual feedback through thumbnails and status indicators.
///
/// Example:
/// ```dart
/// FileItem(
///   fileName: Text('document.pdf'),
///   fileSize: Text('1.2 MB'),
///   fileType: Text('PDF'),
///   uploadProgress: 0.75, // 75% uploaded
///   onRemove: () => removeFile(),
///   thumbnail: Icon(Icons.picture_as_pdf),
/// )
/// ```
class FileItem extends StatelessWidget {
  /// Upload progress from 0.0 to 1.0, or null if not uploading.
  final double? uploadProgress;
  /// Called when the remove button is pressed.
  final VoidCallback? onRemove;
  /// Called when the retry button is pressed (for failed uploads).
  final VoidCallback? onRetry;
  /// Called when the download button is pressed.
  final VoidCallback? onDownload;
  /// Optional thumbnail widget for the file.
  final Widget? thumbnail;
  /// Called when the preview button is pressed.
  final VoidCallback? onPreview;
  /// Widget displaying the file name.
  final Widget fileName;
  /// Optional widget displaying the file size.
  final Widget? fileSize;
  /// Optional widget displaying the file type/format.
  final Widget? fileType;
  /// Creates a [FileItem].
  const FileItem({super.key, this.uploadProgress, this.onRemove, this.onRetry, this.onDownload, this.thumbnail, this.onPreview, required this.fileName, this.fileSize, this.fileType});
  Widget build(BuildContext context);
}
```
