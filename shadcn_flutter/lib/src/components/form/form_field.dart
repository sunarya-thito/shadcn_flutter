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
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    if (widget.mode == PromptMode.dialog) {
      return OutlineButton(
        trailing: widget.trailing?.iconMuted().iconSmall(),
        leading: widget.leading?.iconMuted().iconSmall(),
        onPressed: widget.onChanged == null
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: AlertDialog(
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
                                Navigator.of(context).pop();
                                widget.onChanged!(value);
                                this.context.reportNewFormValue(value);
                              }),
                        ],
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
    return OutlineButton(
      trailing: widget.trailing?.iconMuted().iconSmall(),
      leading: widget.leading?.iconMuted().iconSmall(),
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
              child: Card(
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
