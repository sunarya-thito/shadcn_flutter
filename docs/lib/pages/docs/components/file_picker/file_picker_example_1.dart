import 'package:shadcn_flutter/shadcn_flutter.dart';

class FilePickerExample1 extends StatefulWidget {
  const FilePickerExample1({super.key});

  @override
  State<FilePickerExample1> createState() => _FilePickerExample1State();
}

class _FilePickerExample1State extends State<FilePickerExample1> {
  final List<XFile> _files = [];
  @override
  Widget build(BuildContext context) {
    return FilePicker(
      children: [
        for (final file in _files)
          FileItem(
            fileName: Text(file.name),
            fileSize: FutureBuilder(
              future: file.length(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                return Text(snapshot.requireData.toString());
              },
            ),
          )
      ],
    );
  }
}
