---
title: "Class: FileIconProvider"
description: "Provides customizable file icons in the widget tree."
---

```dart
/// Provides customizable file icons in the widget tree.
///
/// [FileIconProvider] allows applications to define custom file icons based on
/// file extensions. Icons can be provided either through a builder function or
/// a static map of extensions to widgets.
///
/// Example using builder:
/// ```dart
/// FileIconProvider.builder(
///   builder: (extension) {
///     if (extension == 'txt') return Icon(Icons.text_snippet);
///     return Icon(Icons.insert_drive_file);
///   },
///   child: MyFileList(),
/// )
/// ```
///
/// Example using icon map:
/// ```dart
/// FileIconProvider(
///   icons: {
///     'pdf': Icon(Icons.picture_as_pdf),
///     'jpg': Icon(Icons.image),
///   },
///   child: MyFileList(),
/// )
/// ```
class FileIconProvider extends StatelessWidget {
  /// Builder function for creating file icons.
  final FileIconBuilder? builder;
  /// Map of file extensions to icon widgets.
  final Map<String, Widget>? icons;
  /// The child widget.
  final Widget child;
  /// Creates a [FileIconProvider] using a builder function.
  const FileIconProvider.builder({super.key, FileIconBuilder this.builder = _buildFileIcon, required this.child});
  /// Creates a [FileIconProvider] using a static icon map.
  const FileIconProvider({super.key, required this.icons, required this.child});
  Widget build(BuildContext context);
  /// Builds a file icon for the given extension using the configured provider.
  ///
  /// Parameters:
  /// - [context]: The build context to find the provider.
  /// - [extension]: The file extension (without the dot).
  ///
  /// Returns: The appropriate icon widget for the file type.
  static Widget buildIcon(BuildContext context, String extension);
}
```
