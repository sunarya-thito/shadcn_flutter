---
title: "Class: SizeUnitLocale"
description: "Configuration for file size unit formatting."
---

```dart
/// Configuration for file size unit formatting.
///
/// Defines the base (1024 for binary) and unit labels for formatting
/// file sizes and data volumes.
class SizeUnitLocale {
  /// Base for unit conversion (typically 1024 for binary units).
  final int base;
  /// List of unit labels (e.g., ['B', 'KB', 'MB', 'GB']).
  final List<String> units;
  /// Separator for digit grouping (e.g., ',' for 1,000,000).
  final String separator;
  /// Creates a [SizeUnitLocale].
  ///
  /// Parameters:
  /// - [base] (`int`, required): Base for unit conversion.
  /// - [units] (`List<String>`, required): Unit labels.
  /// - [separator] (`String`, default: ','): Digit separator.
  const SizeUnitLocale(this.base, this.units, {this.separator = ','});
  /// Standard file size units in bytes (B, KB, MB, GB, etc.).
  static const SizeUnitLocale fileBytes = _fileByteUnits;
  /// Binary file size units (Bi, KiB, MiB, GiB, etc.).
  static const SizeUnitLocale fileBits = _fileBitUnits;
  /// Gets the appropriate unit label for a value.
  ///
  /// Parameters:
  /// - [value] (`int`, required): The value to get unit for.
  ///
  /// Returns: `String` — the unit label.
  String getUnit(int value);
}
```
