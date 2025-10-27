---
title: "Class: FormattedObjectInput"
description: "Reference for FormattedObjectInput"
---

```dart
class FormattedObjectInput<T> extends StatefulWidget with ControlledComponent<T?> {
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<List<String>>? onPartsChanged;
  final FormattedInputPopupBuilder<T>? popupBuilder;
  final bool enabled;
  final ComponentController<T?>? controller;
  final BiDirectionalConvert<T?, List<String?>> converter;
  final List<InputPart> parts;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final Offset? popoverOffset;
  final Widget? popoverIcon;
  const FormattedObjectInput({super.key, this.initialValue, this.onChanged, this.popupBuilder, this.enabled = true, this.controller, required this.converter, required this.parts, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverOffset, this.popoverIcon, this.onPartsChanged});
  State<FormattedObjectInput<T>> createState();
}
```
