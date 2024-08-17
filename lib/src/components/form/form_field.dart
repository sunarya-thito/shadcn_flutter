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
  final Widget Function(
      BuildContext context, T? value, ValueChanged<T?> onChanged) editorBuilder;
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;
  final Widget? dialogTitle;

  const ObjectFormField({
    Key? key,
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
  }) : super(key: key);

  @override
  State<ObjectFormField<T>> createState() => _ObjectFormFieldState<T>();
}

class _ObjectFormFieldState<T> extends State<ObjectFormField<T>>
    with FormValueSupplier {
  late T? value;
  final PopoverController _popoverController = PopoverController();

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      value,
      (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      value = widget.value;
      reportNewFormValue(value, (value) {
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

  @override
  Widget build(BuildContext context) {
    if (widget.mode == PromptMode.dialog) {
      return OutlineButton(
        trailing: widget.trailing?.iconMutedForeground().iconSmall(),
        leading: widget.leading?.iconMutedForeground().iconSmall(),
        onPressed: widget.onChanged == null
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return _ObjectFormFieldDialog<T>(
                      dialogTitle: widget.dialogTitle,
                      value: value,
                      editorBuilder: widget.editorBuilder,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      this.value = value as T?;
                    });
                    widget.onChanged?.call(value as T?);
                    this.context.reportNewFormValue(value as T?);
                  }
                });
              },
        child: value == null
            ? widget.placeholder.muted()
            : widget.builder(context, value as T),
      );
    }
    return OutlineButton(
      trailing: widget.trailing?.iconMutedForeground().iconSmall(),
      leading: widget.leading?.iconMutedForeground().iconSmall(),
      onPressed: () {
        _popoverController.show(
          context: context,
          alignment: widget.popoverAlignment ?? Alignment.topLeft,
          anchorAlignment:
              widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
          builder: (context) {
            return Padding(
              padding: widget.popoverPadding ??
                  const EdgeInsets.symmetric(vertical: 8),
              child: SurfaceCard(
                child: widget.editorBuilder(
                  context,
                  value,
                  (value) {
                    setState(() {
                      this.value = value;
                    });
                    widget.onChanged?.call(value);
                    this.context.reportNewFormValue(value);
                  },
                ),
              ),
            );
          },
        );
      },
      child: value == null
          ? widget.placeholder.muted()
          : widget.builder(context, value as T),
    );
  }
}

class _ObjectFormFieldDialog<T> extends StatefulWidget {
  final T? value;
  final Widget Function(
      BuildContext context, T? value, ValueChanged<T?> onChanged) editorBuilder;
  final Widget? dialogTitle;

  const _ObjectFormFieldDialog({
    Key? key,
    required this.value,
    required this.editorBuilder,
    this.dialogTitle,
  }) : super(key: key);

  @override
  State<_ObjectFormFieldDialog<T>> createState() =>
      _ObjectFormFieldDialogState<T>();
}

class _ObjectFormFieldDialogState<T> extends State<_ObjectFormFieldDialog<T>> {
  late T? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return AlertDialog(
      title: widget.dialogTitle,
      content: widget.editorBuilder(
        context,
        value,
        (value) {
          setState(() {
            this.value = value;
          });
        },
      ),
      actions: [
        SecondaryButton(
            child: Text(localizations.buttonCancel),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        PrimaryButton(
            child: Text(localizations.buttonSave),
            onPressed: () {
              Navigator.of(context).pop(value);
            }),
      ],
    );
  }
}
