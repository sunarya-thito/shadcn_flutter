# FilePicker

A file picker widget for selecting and managing file uploads.

## Usage

### File Picker Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FilePickerExample1 extends StatefulWidget {
  const FilePickerExample1({super.key});

  @override
  State<FilePickerExample1> createState() => _FilePickerExample1State();
}

class _FilePickerExample1State extends State<FilePickerExample1> {
  // final List<XFile> _files = [];
  @override
  Widget build(BuildContext context) {
    // Placeholder for a file picker demo. The `_files` list would store the
    // selected files after invoking a picker (e.g., pickFiles()). Left empty
    // intentionally in this example to show the scaffold for state.
    return Container();
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `title` | `Widget?` | Title widget displayed above the file picker. |
| `subtitle` | `Widget?` | Subtitle widget displayed below the title. |
| `hotDropEnabled` | `bool` | Whether drag-and-drop functionality is enabled. |
| `hotDropping` | `bool` | Whether a drag-and-drop operation is currently in progress. |
| `children` | `List<Widget>` | List of file item widgets to display. |
| `onAdd` | `VoidCallback?` | Callback when the add file button is pressed. |
