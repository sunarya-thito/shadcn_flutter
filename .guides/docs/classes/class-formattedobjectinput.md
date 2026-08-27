---
title: "Class: FormattedObjectInput"
description: "A formatted input widget that works with complex objects.   [FormattedObjectInput] extends formatted input functionality to handle  objects of type [T], converting between the object and its formatted  string representation. It can optionally display a popup for advanced editing.   Example:  ```dart  FormattedObjectInput<DateTime>(    converter: dateConverter,    parts: [      InputPart.editable(length: 2, width: 30), // Month      InputPart.static('/'),      InputPart.editable(length: 2, width: 30), // Day    ],    popupBuilder: (context, controller) => CalendarWidget(),  )  ```"
---

```dart
/// A formatted input widget that works with complex objects.
///
/// [FormattedObjectInput] extends formatted input functionality to handle
/// objects of type [T], converting between the object and its formatted
/// string representation. It can optionally display a popup for advanced editing.
///
/// Example:
/// ```dart
/// FormattedObjectInput<DateTime>(
///   converter: dateConverter,
///   parts: [
///     InputPart.editable(length: 2, width: 30), // Month
///     InputPart.static('/'),
///     InputPart.editable(length: 2, width: 30), // Day
///   ],
///   popupBuilder: (context, controller) => CalendarWidget(),
/// )
/// ```
class FormattedObjectInput<T> extends StatefulWidget with ControlledComponent<T?> {
  /// The initial value of the input.
  final T? initialValue;
  /// Called when the value changes.
  final ValueChanged<T?>? onChanged;
  /// Called when the individual parts change.
  final ValueChanged<List<String>>? onPartsChanged;
  /// Builder for creating a custom popup widget.
  final FormattedInputPopupBuilder<T>? popupBuilder;
  /// Whether the input is enabled.
  final bool enabled;
  /// Optional controller for external control.
  final ComponentController<T?>? controller;
  /// Converter between the object type and string parts.
  final BiDirectionalConvert<T?, List<String?>> converter;
  /// The input parts that make up the formatted input.
  final List<InputPart> parts;
  /// Overrides the [OverlayConfiguration] used to present the popup. When
  /// null, a default [PopoverConfiguration] is used (`AlignmentDirectional.topStart`
  /// / `AlignmentDirectional.bottomStart`).
  final OverlayConfiguration? overlayConfiguration;
  /// Whether the popup may adapt to a different presentation on mobile
  /// platforms (see [showOverlay]'s `adaptive` parameter).
  final bool? adaptiveOverlay;
  /// Icon displayed in the popover trigger.
  final Widget? popoverIcon;
  /// Creates a [FormattedObjectInput].
  const FormattedObjectInput({super.key, this.initialValue, this.onChanged, this.popupBuilder, this.enabled = true, this.controller, required this.converter, required this.parts, this.overlayConfiguration, this.adaptiveOverlay, this.popoverIcon, this.onPartsChanged});
  State<FormattedObjectInput<T>> createState();
}
```
