---
title: "Class: ObjectFormField"
description: "Reference for ObjectFormField"
---

```dart
class ObjectFormField<T> extends StatefulWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget placeholder;
  final Widget Function(BuildContext context, T value) builder;
  final Widget? leading;
  final Widget? trailing;
  final PromptMode mode;
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler) editorBuilder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final ButtonSize? size;
  final ButtonDensity? density;
  final ButtonShape? shape;
  final List<Widget> Function(BuildContext context, ObjectFormHandler<T> handler)? dialogActions;
  final bool? enabled;
  final bool decorate;
  const ObjectFormField({super.key, required this.value, this.onChanged, required this.placeholder, required this.builder, this.leading, this.trailing, this.mode = PromptMode.dialog, required this.editorBuilder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.size, this.density, this.shape, this.dialogActions, this.enabled, this.decorate = true});
  State<ObjectFormField<T>> createState();
}
```
