# FileIconProvider

Provides customizable file icons in the widget tree.

## Usage

### Basic Example
```dart
FileIconProvider.builder(
  builder: (extension) {
    if (extension == 'txt') return Icon(Icons.text_snippet);
    return Icon(Icons.insert_drive_file);
  },
  child: MyFileList(),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `builder` | `FileIconBuilder?` | Builder function for creating file icons. |
| `icons` | `Map<String, Widget>?` | Map of file extensions to icon widgets. |
| `child` | `Widget` | The child widget. |
