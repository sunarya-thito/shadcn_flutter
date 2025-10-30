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
  /// Title widget displayed above the file picker.
  final Widget? title;
  /// Subtitle widget displayed below the title.
  final Widget? subtitle;
  /// Whether drag-and-drop functionality is enabled.
  final bool hotDropEnabled;
  /// Whether a drag-and-drop operation is currently in progress.
  final bool hotDropping;
  /// List of file item widgets to display.
  final List<Widget> children;
  /// Callback when the add file button is pressed.
  final VoidCallback? onAdd;
  /// Creates a [FilePicker].
  ///
  /// Parameters:
  /// - [title] (`Widget?`, optional): Title displayed above picker.
  /// - [subtitle] (`Widget?`, optional): Subtitle below title.
  /// - [hotDropEnabled] (`bool`, default: `false`): Enable drag-and-drop.
  /// - [hotDropping] (`bool`, default: `false`): Currently dropping files.
  /// - [onAdd] (`VoidCallback?`, optional): Called when add button pressed.
  /// - [children] (`List<Widget>`, required): File item widgets.
  const FilePicker({super.key, this.title, this.subtitle, this.hotDropEnabled = false, this.hotDropping = false, this.onAdd, required this.children});
  Widget build(BuildContext context);
}
```
