import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Defines how a form field editor is presented to the user.
///
/// [PromptMode] determines whether the field editor appears in a modal
/// dialog or a popover overlay.
enum PromptMode {
  /// Display the editor in a modal dialog.
  dialog,

  /// Display the editor in a popover overlay.
  popover,
}

/// A form field widget for complex object values.
///
/// [ObjectFormField] provides a button-like trigger that opens an editor
/// (in a dialog or popover) for selecting/editing complex values. The field
/// displays the selected value using a custom builder.
///
/// Useful for date pickers, color pickers, file selectors, and other
/// complex input scenarios where a simple text field isn't sufficient.
///
/// Example:
/// ```dart
/// ObjectFormField<DateTime>(
///   value: selectedDate,
///   placeholder: Text('Select date'),
///   builder: (context, date) => Text(formatDate(date)),
///   editorBuilder: (context, handler) => CalendarWidget(),
///   mode: PromptMode.dialog,
/// )
/// ```
class ObjectFormField<T> extends StatefulWidget {
  /// The current value of the field.
  final T? value;

  /// Called when the value changes.
  final ValueChanged<T?>? onChanged;

  /// Widget displayed when no value is selected.
  final Widget placeholder;

  /// Builds the display for the selected value.
  final Widget Function(BuildContext context, T value) builder;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Optional trailing widget (e.g., dropdown arrow).
  final Widget? trailing;

  /// How the editor is presented (dialog or popover).
  final PromptMode mode;

  /// Builds the editor widget.
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
      editorBuilder;

  /// Popover alignment relative to the trigger.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title for the dialog mode.
  final Widget? dialogTitle;

  /// Button size for the trigger.
  final ButtonSize? size;

  /// Button density for the trigger.
  final ButtonDensity? density;

  /// Button shape for the trigger.
  final ButtonShape? shape;

  /// Custom dialog action buttons.
  final List<Widget> Function(
      BuildContext context, ObjectFormHandler<T> handler)? dialogActions;

  /// Whether the field is enabled.
  final bool? enabled;

  /// Whether to show the field decoration.
  final bool decorate;

  /// Creates an [ObjectFormField].
  const ObjectFormField({
    super.key,
    required this.value,
    this.onChanged,
    required this.placeholder,
    required this.builder,
    this.leading,
    this.trailing,
    this.mode = PromptMode.dialog,
    required this.editorBuilder,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.size,
    this.density,
    this.shape,
    this.dialogActions,
    this.enabled,
    this.decorate = true,
  });

  @override
  State<ObjectFormField<T>> createState() => ObjectFormFieldState<T>();
}

/// Abstract interface for controlling an object form field's state.
///
/// [ObjectFormHandler] provides methods to interact with an object form field,
/// including getting/setting values and controlling the editor visibility.
abstract class ObjectFormHandler<T> {
  /// Gets the current value.
  T? get value;

  /// Sets the current value.
  set value(T? value);

  /// Opens the editor with an optional initial value.
  void prompt([T? value]);

  /// Closes the editor.
  Future<void> close();

  /// Finds the [ObjectFormHandler] in the widget tree.
  static ObjectFormHandler<T> of<T>(BuildContext context) {
    return Data.of<ObjectFormHandler<T>>(context);
  }

  /// Finds the [ObjectFormHandler] in the widget tree (alternative method).
  static ObjectFormHandler<T> find<T>(BuildContext context) {
    return Data.find<ObjectFormHandler<T>>(context);
  }
}

/// State class for [ObjectFormField] managing form value and user interactions.
///
/// Handles value updates, popover/dialog display, and integrates with the
/// form validation system. This state also determines whether the field is
/// enabled based on the presence of an `onChanged` callback.
class ObjectFormFieldState<T> extends State<ObjectFormField<T>>
    with FormValueSupplier<T, ObjectFormField<T>> {
  final PopoverController _popoverController = PopoverController();

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  /// Gets the current form value.
  ///
  /// Returns: The current value of type `T?`.
  T? get value => formValue;

  /// Sets a new form value and notifies listeners.
  ///
  /// Parameters:
  /// - [value] (`T?`, required): The new value to set.
  set value(T? value) {
    widget.onChanged?.call(value);
    formValue = value;
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  /// Whether this field is enabled.
  ///
  /// Returns true if explicitly enabled or if an `onChanged` callback exists.
  bool get enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  void _showDialog([T? value]) {
    value ??= formValue;
    showDialog(
      context: context,
      builder: (context) {
        return _ObjectFormFieldDialog<T>(
          dialogTitle: widget.dialogTitle,
          value: value,
          editorBuilder: widget.editorBuilder,
          dialogActions: widget.dialogActions,
          prompt: prompt,
          decorate: widget.decorate,
        );
      },
    ).then((value) {
      if (mounted && value is ObjectFormFieldDialogResult<T>) {
        this.value = value.value;
      }
    });
  }

  void _showPopover([T? value]) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    value ??= formValue;
    _popoverController.show(
      context: context,
      alignment: widget.popoverAlignment ?? Alignment.topLeft,
      anchorAlignment: widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
      overlayBarrier: OverlayBarrier(
        borderRadius: BorderRadius.circular(theme.radiusLg),
      ),
      modal: true,
      offset: Offset(0, 8 * scaling),
      builder: (context) {
        return _ObjectFormFieldPopup<T>(
          value: value,
          editorBuilder: widget.editorBuilder,
          popoverPadding: widget.popoverPadding,
          prompt: prompt,
          decorate: widget.decorate,
          onChanged: (value) {
            if (mounted) {
              this.value = value;
            }
          },
        );
      },
    );
  }

  /// Prompts the user to select or edit a value via dialog or popover.
  ///
  /// Displays the appropriate UI based on the configured [PromptMode].
  ///
  /// Parameters:
  /// - [value] (`T?`, optional): An initial value to display in the prompt.
  ///
  /// Example:
  /// ```dart
  /// fieldState.prompt(initialValue);
  /// ```
  void prompt([T? value]) {
    if (widget.mode == PromptMode.dialog) {
      _showDialog(value);
    } else {
      _showPopover(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? ButtonSize.normal;
    final density = widget.density ?? ButtonDensity.normal;
    final shape = widget.shape ?? ButtonShape.rectangle;
    return OutlineButton(
      trailing: widget.trailing?.iconMutedForeground().iconSmall(),
      leading: widget.leading?.iconMutedForeground().iconSmall(),
      size: size,
      density: density,
      shape: shape,
      onPressed: widget.onChanged == null ? null : prompt,
      enabled: enabled,
      child: value == null
          ? widget.placeholder.muted()
          : widget.builder(context, value as T),
    );
  }
}

class _ObjectFormFieldDialog<T> extends StatefulWidget {
  final T? value;
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
      editorBuilder;
  final Widget? dialogTitle;
  final List<Widget> Function(
      BuildContext context, ObjectFormHandler<T> handler)? dialogActions;
  final ValueChanged<T?> prompt;
  final bool decorate;

  const _ObjectFormFieldDialog({
    super.key,
    required this.value,
    required this.editorBuilder,
    this.dialogTitle,
    this.dialogActions,
    required this.prompt,
    this.decorate = true,
  });

  @override
  State<_ObjectFormFieldDialog<T>> createState() =>
      _ObjectFormFieldDialogState<T>();
}

/// Holds the result value from an object form field dialog.
///
/// Used to pass the selected or edited value back from a dialog prompt.
///
/// Example:
/// ```dart
/// final result = ObjectFormFieldDialogResult<DateTime>(DateTime.now());
/// Navigator.of(context).pop(result);
/// ```
class ObjectFormFieldDialogResult<T> {
  /// The value selected or edited by the user.
  final T? value;

  /// Creates an [ObjectFormFieldDialogResult].
  ///
  /// Parameters:
  /// - [value] (`T?`, required): The result value.
  ObjectFormFieldDialogResult(this.value);
}

class _ObjectFormFieldDialogState<T> extends State<_ObjectFormFieldDialog<T>>
    implements ObjectFormHandler<T> {
  late T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  T? get value => _value;

  @override
  set value(T? value) {
    if (mounted) {
      setState(() {
        _value = value;
      });
    } else {
      _value = value;
    }
  }

  @override
  void prompt([T? value]) {
    widget.prompt.call(value);
  }

  @override
  Future<void> close() {
    final modalRoute = ModalRoute.of(context);
    Navigator.of(context).pop();
    return modalRoute?.completed ?? Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.decorate) {
      return widget.editorBuilder(context, this);
    }
    final localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    return Data<ObjectFormHandler<T>>.inherit(
      data: this,
      child: AlertDialog(
        title: widget.dialogTitle,
        content: Padding(
          padding: EdgeInsets.only(top: 8 * theme.scaling),
          child: widget.editorBuilder(
            context,
            this,
          ),
        ),
        actions: [
          if (widget.dialogActions != null)
            ...widget.dialogActions!(context, this),
          SecondaryButton(
              child: Text(localizations.buttonCancel),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          PrimaryButton(
              child: Text(localizations.buttonSave),
              onPressed: () {
                Navigator.of(context).pop(ObjectFormFieldDialogResult(_value));
              }),
        ],
      ),
    );
  }
}

class _ObjectFormFieldPopup<T> extends StatefulWidget {
  final T? value;
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
      editorBuilder;
  final EdgeInsetsGeometry? popoverPadding;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?> prompt;
  final bool decorate;

  const _ObjectFormFieldPopup({
    super.key,
    required this.value,
    required this.editorBuilder,
    required this.prompt,
    this.popoverPadding,
    this.onChanged,
    this.decorate = true,
  });

  @override
  State<_ObjectFormFieldPopup<T>> createState() =>
      _ObjectFormFieldPopupState<T>();
}

class _ObjectFormFieldPopupState<T> extends State<_ObjectFormFieldPopup<T>>
    implements ObjectFormHandler<T> {
  late T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  T? get value => _value;

  @override
  set value(T? value) {
    if (mounted) {
      setState(() {
        _value = value;
      });
    } else {
      _value = value;
    }
    widget.onChanged?.call(value);
  }

  @override
  void prompt([T? value]) {
    widget.prompt.call(value);
  }

  @override
  Future<void> close() {
    return closeOverlay(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.decorate) {
      return widget.editorBuilder(context, this);
    }
    final theme = Theme.of(context);
    return Data<ObjectFormHandler<T>>.inherit(
      data: this,
      child: SurfaceCard(
        padding: widget.popoverPadding ??
            (const EdgeInsets.symmetric(vertical: 16, horizontal: 16) *
                theme.scaling),
        child: widget.editorBuilder(
          context,
          this,
        ),
      ),
    );
  }
}
