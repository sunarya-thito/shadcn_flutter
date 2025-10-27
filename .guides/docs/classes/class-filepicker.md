---
title: "Class: FilePicker"
description: "A file picker widget for selecting and managing file uploads."
---

```dart
/// A file picker widget for selecting and managing file uploads.
///
/// **Work in Progress** - This component is under active development and
/// may have incomplete functionality or undergo API changes.
///
/// Provides a comprehensive interface for file selection with drag-and-drop
/// support, file management capabilities, and customizable presentation.
/// Displays selected files as a list of manageable items with options
/// for adding, removing, and organizing uploaded files.
///
/// Supports hot drop functionality for drag-and-drop file uploads and
/// provides visual feedback during file operations. The picker can be
/// customized with titles, subtitles, and custom file item presentations.
///
/// Example:
/// ```dart
/// FilePicker(
///   title: Text('Upload Documents'),
///   subtitle: Text('Drag files here or click to browse'),
///   hotDropEnabled: true,
///   onAdd: () => _selectFiles(),
///   children: selectedFiles.map((file) => 
///     FileItem(file: file, onRemove: () => _removeFile(file))
///   ).toList(),
/// )
/// ```
class FilePicker extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final bool hotDropEnabled;
  final bool hotDropping;
  final List<Widget> children;
  final VoidCallback? onAdd;
  const FilePicker({super.key, this.title, this.subtitle, this.hotDropEnabled = false, this.hotDropping = false, this.onAdd, required this.children});
  Widget build(BuildContext context);
}
```
