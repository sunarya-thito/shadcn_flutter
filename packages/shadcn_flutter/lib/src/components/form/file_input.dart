import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget _buildFileIcon(String extension) {
  switch (extension) {
    case 'pdf':
      return const Icon(BootstrapIcons.filetypePdf);
    case 'doc':
    case 'docx':
      return const Icon(BootstrapIcons.fileWord);
    case 'xls':
    case 'xlsx':
      return const Icon(BootstrapIcons.fileExcel);
    case 'ppt':
    case 'pptx':
      return const Icon(BootstrapIcons.filePpt);
    case 'zip':
    case 'rar':
      return const Icon(BootstrapIcons.fileZip);
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
      return const Icon(BootstrapIcons.fileImage);
    case 'mp3':
    case 'wav':
      return const Icon(BootstrapIcons.fileMusic);
    case 'mp4':
    case 'avi':
    case 'mkv':
      return const Icon(BootstrapIcons.filePlay);
    default:
      return const Icon(BootstrapIcons.file);
  }
}

/// A function that builds a file icon widget based on the file extension.
///
/// Parameters:
/// - [extension]: The file extension (without the dot).
///
/// Returns: A widget representing the file type icon.
typedef FileIconBuilder = Widget Function(String extension);

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
  const FileIconProvider.builder({
    super.key,
    FileIconBuilder this.builder = _buildFileIcon,
    required this.child,
  }) : icons = null;

  /// Creates a [FileIconProvider] using a static icon map.
  const FileIconProvider({
    super.key,
    required this.icons,
    required this.child,
  }) : builder = null;

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: FileIconProviderData._(
        builder: builder,
        icons: icons,
      ),
      child: child,
    );
  }

  /// Builds a file icon for the given extension using the configured provider.
  ///
  /// Parameters:
  /// - [context]: The build context to find the provider.
  /// - [extension]: The file extension (without the dot).
  ///
  /// Returns: The appropriate icon widget for the file type.
  static Widget buildIcon(BuildContext context, String extension) {
    final data = Data.of<FileIconProviderData>(context);
    return data.buildIcon(extension);
  }
}

/// Internal data class for [FileIconProvider].
///
/// Stores the configuration for file icon provision and provides
/// a method to build icons based on file extensions.
class FileIconProviderData {
  /// Optional builder function for icons.
  final FileIconBuilder? builder;

  /// Optional map of extension to icon widgets.
  final Map<String, Widget>? icons;

  /// Creates internal data for file icon provision.
  const FileIconProviderData._({
    this.builder,
    this.icons,
  });

  /// Builds an icon for the given file extension.
  ///
  /// Uses the builder if provided, otherwise checks the icons map,
  /// and falls back to the default icon builder.
  Widget buildIcon(String extension) {
    if (builder != null) return builder!(extension);
    final icon = icons?[extension];
    if (icon != null) return icon;
    return _buildFileIcon(extension);
  }
}

//
// class SingleFileInput extends StatelessWidget {
//   final XFile? file;
//   final ValueChanged<XFile?>? onChanged;
//   final bool acceptDrop;
//   final bool enabled;
//
//   const SingleFileInput({
//     super.key,
//     this.file,
//     this.onChanged,
//     this.acceptDrop = false,
//     this.enabled = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
