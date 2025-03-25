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

typedef FileIconBuilder = Widget Function(String extension);

class FileIconProvider extends StatelessWidget {
  final FileIconBuilder? builder;
  final Map<String, Widget>? icons;
  final Widget child;

  const FileIconProvider.builder({
    super.key,
    FileIconBuilder this.builder = _buildFileIcon,
    required this.child,
  })  : icons = null;

  const FileIconProvider({
    super.key,
    required this.icons,
    required this.child,
  })  : builder = null;

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

  static Widget buildIcon(BuildContext context, String extension) {
    final data = Data.of<FileIconProviderData>(context);
    return data.buildIcon(extension);
  }
}

class FileIconProviderData {
  final FileIconBuilder? builder;
  final Map<String, Widget>? icons;

  const FileIconProviderData._({
    this.builder,
    this.icons,
  });

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
