# SizeUnitLocale

Configuration for file size unit formatting.

## Usage

### Basic Example
```dart
SizeUnitLocale(
  null, // TODO: Provide base
  null, // TODO: Provide units
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `base` | `int` | Base for unit conversion (typically 1024 for binary units). |
| `units` | `List<String>` | List of unit labels (e.g., ['B', 'KB', 'MB', 'GB']). |
| `separator` | `String` | Separator for digit grouping (e.g., ',' for 1,000,000). |
| `fileBytes` | `SizeUnitLocale` | Standard file size units in bytes (B, KB, MB, GB, etc.). |
| `fileBits` | `SizeUnitLocale` | Binary file size units (Bi, KiB, MiB, GiB, etc.). |
