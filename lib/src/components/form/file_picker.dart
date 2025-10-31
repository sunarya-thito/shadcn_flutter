import 'package:shadcn_flutter/shadcn_flutter.dart';

// const fileByteUnits = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
// const fileBitUnits = ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
// String formatFileSize(int bytes, List<String> units) {
//   if (bytes <= 0) return '0 ${units[0]}';
//   final
// }

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
  const FilePicker({
    super.key,
    this.title,
    this.subtitle,
    this.hotDropEnabled = false,
    this.hotDropping = false,
    this.onAdd,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

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
  const FileItem({
    super.key,
    this.uploadProgress,
    this.onRemove,
    this.onRetry,
    this.onDownload,
    this.thumbnail,
    this.onPreview,
    required this.fileName,
    this.fileSize,
    this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
