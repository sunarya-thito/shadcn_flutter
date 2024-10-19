import 'package:shadcn_flutter/shadcn_flutter.dart';

enum PromptMode {
  dialog,
  popover,
}

class ObjectFormField<T> extends StatefulWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Widget placeholder;
  final Widget Function(BuildContext context, T value) builder;
  final Widget? leading;
  final Widget? trailing;
  final PromptMode mode;
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
      editorBuilder;
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;
  final Widget? dialogTitle;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final List<Widget> Function(
      BuildContext context, ObjectFormHandler<T> handler)? dialogActions;

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
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.dialogActions,
  });

  @override
  State<ObjectFormField<T>> createState() => ObjectFormFieldState<T>();
}

abstract class ObjectFormHandler<T> {
  T? get value;
  set value(T? value);
  void prompt([T? value]);
  Future<void> close();

  static ObjectFormHandler<T> of<T>(BuildContext context) {
    return Data.of<ObjectFormHandler<T>>(context);
  }

  static ObjectFormHandler<T> find<T>(BuildContext context) {
    return Data.find<ObjectFormHandler<T>>(context);
  }
}

class ObjectFormFieldState<T> extends State<ObjectFormField<T>>
    with FormValueSupplier {
  late T? _value;
  final PopoverController _popoverController = PopoverController();

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      _value,
      (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }

  T get value => _value as T;

  set value(T? value) {
    setState(() {
      this._value = value;
    });
    widget.onChanged?.call(value);
    context.reportNewFormValue(value);
  }

  @override
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
      reportNewFormValue(_value, (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      });
    }
  }

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  void _showDialog([T? value]) {
    value ??= _value;
    showDialog(
      context: context,
      builder: (context) {
        return _ObjectFormFieldDialog<T>(
          dialogTitle: widget.dialogTitle,
          value: value,
          editorBuilder: widget.editorBuilder,
          dialogActions: widget.dialogActions,
          prompt: prompt,
        );
      },
    ).then((value) {
      if (mounted && value is _ObjectFormFieldDialogResult<T>) {
        setState(() {
          this._value = value.value;
        });
        widget.onChanged?.call(value.value);
        context.reportNewFormValue(value);
      }
    });
  }

  void _showPopover([T? value]) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    value ??= _value;
    _popoverController.show(
      context: context,
      alignment: widget.popoverAlignment ?? Alignment.topLeft,
      anchorAlignment: widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
      overlayBarrier: OverlayBarrier(
        padding: const EdgeInsets.symmetric(vertical: 8) * scaling,
        borderRadius: BorderRadius.circular(theme.radiusLg),
      ),
      builder: (context) {
        return _ObjectFormFieldPopup<T>(
          value: value,
          editorBuilder: widget.editorBuilder,
          popoverPadding: widget.popoverPadding,
          prompt: prompt,
          onChanged: (value) {
            if (value != _value && mounted) {
              setState(() {
                this._value = value;
              });
              widget.onChanged?.call(value);
              this.context.reportNewFormValue(value);
            }
          },
        );
      },
    );
  }

  void prompt([T? value]) {
    if (widget.mode == PromptMode.dialog) {
      _showDialog(value);
    } else {
      _showPopover(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      trailing: widget.trailing?.iconMutedForeground().iconSmall(),
      leading: widget.leading?.iconMutedForeground().iconSmall(),
      size: widget.size,
      density: widget.density,
      shape: widget.shape,
      onPressed: widget.onChanged == null ? null : prompt,
      child: _value == null
          ? widget.placeholder.muted()
          : widget.builder(context, _value as T),
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

  const _ObjectFormFieldDialog({
    super.key,
    required this.value,
    required this.editorBuilder,
    this.dialogTitle,
    this.dialogActions,
    required this.prompt,
  });

  @override
  State<_ObjectFormFieldDialog<T>> createState() =>
      _ObjectFormFieldDialogState<T>();
}

class _ObjectFormFieldDialogResult<T> {
  final T? value;

  _ObjectFormFieldDialogResult(this.value);
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
        this._value = value;
      });
    } else {
      this._value = value;
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
                Navigator.of(context).pop(_ObjectFormFieldDialogResult(_value));
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
  final EdgeInsets? popoverPadding;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?> prompt;

  const _ObjectFormFieldPopup({
    super.key,
    required this.value,
    required this.editorBuilder,
    required this.prompt,
    this.popoverPadding,
    this.onChanged,
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
        this._value = value;
      });
    } else {
      this._value = value;
    }
    widget.onChanged?.call(value);
  }

  @override
  void prompt([T? value]) {
    widget.prompt.call(value);
  }

  @override
  Future<void> close() {
    return closePopover(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Data<ObjectFormHandler<T>>.inherit(
      data: this,
      child: Padding(
        padding: widget.popoverPadding ??
            (const EdgeInsets.symmetric(vertical: 8) * theme.scaling),
        child: SurfaceCard(
          child: widget.editorBuilder(
            context,
            this,
          ),
        ),
      ),
    );
  }
}
