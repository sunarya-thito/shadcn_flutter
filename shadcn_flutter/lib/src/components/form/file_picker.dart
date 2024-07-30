import 'package:shadcn_flutter/shadcn_flutter.dart';

// const fileByteUnits = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
// const fileBitUnits = ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
// String formatFileSize(int bytes, List<String> units) {
//   if (bytes <= 0) return '0 ${units[0]}';
//   final
// }

class FilePicker extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final bool hotDropEnabled;
  final bool hotDropping;
  final List<Widget> children;
  final VoidCallback? onAdd;

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
