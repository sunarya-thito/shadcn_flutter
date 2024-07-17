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

class _ObjectFormFieldState<T> extends State<ObjectFormField<T>> {
  late T? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      value = widget.value;
    }
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
    return Popover(
      builder: (context, control) {
        return OutlineButton(
          trailing: widget.trailing?.iconMuted().iconSmall(),
          leading: widget.leading?.iconMuted().iconSmall(),
          onPressed: () {
            control.show();
          },
          child: value == null
              ? widget.placeholder.muted()
              : widget.builder(context, value as T),
        );
      },
      popoverBuilder: (context) {
        return Padding(
          padding:
              widget.popoverPadding ?? const EdgeInsets.symmetric(vertical: 8),
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
        );
      },
      alignment: widget.popoverAlignment ?? Alignment.topLeft,
      anchorAlignment: widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
    );
  }
}

class DatePicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final Widget? placeholder;
  final PromptMode mode;
  final CalendarView? initialView;
  final bool Function(DateTime date)? isDateEnabled;
  final Widget Function(BuildContext context, DateTime date)? dateBuilder;
  final Widget Function(BuildContext context, int weekday)? weekDayBuilder;
  final bool directApply;
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;

  const DatePicker({
    Key? key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.mode = PromptMode.dialog,
    this.initialView,
    this.isDateEnabled,
    this.dateBuilder,
    this.weekDayBuilder,
    this.directApply = false,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return ObjectFormField(
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      popoverPadding: popoverPadding,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder ?? Text(localizations.placeholderDatePicker),
      trailing: const Icon(Icons.calendar_today),
      builder: (context, value) {
        return Text(localizations.formatDateTime(value, showTime: false));
      },
      mode: mode,
      editorBuilder: (context, value, onChanged) {
        return DatePickerDialog(
          initialView: initialView ?? CalendarView.now(),
          selectionMode: CalendarSelectionMode.single,
          initialValue: value == null ? null : CalendarValue.single(value),
          onChanged: (value) {
            onChanged(
                value == null ? null : (value as SingleCalendarValue).date);
          },
          isDateEnabled: isDateEnabled,
          dateBuilder: dateBuilder,
          weekDayBuilder: weekDayBuilder,
        );
      },
    );
  }
}

class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange(this.start, this.end);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return 'DateTimeRange{start: $start, end: $end}';
  }

  DateTimeRange copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return DateTimeRange(
      start ?? this.start,
      end ?? this.end,
    );
  }
}

class DateRangePicker extends StatelessWidget {
  final DateTimeRange? value;
  final ValueChanged<DateTimeRange?>? onChanged;
  final Widget? placeholder;
  final PromptMode mode;
  final CalendarView? initialView;
  final bool Function(DateTime date)? isDateEnabled;
  final Widget Function(BuildContext context, DateTime date)? dateBuilder;
  final Widget Function(BuildContext context, int weekday)? weekDayBuilder;
  final bool directApply;
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;

  const DateRangePicker({
    Key? key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.mode = PromptMode.dialog,
    this.initialView,
    this.isDateEnabled,
    this.dateBuilder,
    this.weekDayBuilder,
    this.directApply = false,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return ObjectFormField(
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      popoverPadding: popoverPadding,
      value: value,
      mode: mode,
      onChanged: onChanged,
      placeholder: placeholder ?? Text(localizations.placeholderDatePicker),
      trailing: const Icon(Icons.calendar_month),
      builder: (context, value) {
        return Text(
            '${localizations.formatDateTime(value.start, showTime: false)} - ${localizations.formatDateTime(value.end, showTime: false)}');
      },
      editorBuilder: (context, value, onChanged) {
        return DatePickerDialog(
          initialView: initialView ?? CalendarView.now(),
          selectionMode: CalendarSelectionMode.range,
          initialValue: value == null
              ? null
              : CalendarValue.range(value.start, value.end),
          onChanged: (value) {
            if (value == null) {
              onChanged(null);
            } else {
              final range = value.toRange();
              onChanged(DateTimeRange(range.start, range.end));
            }
          },
          isDateEnabled: isDateEnabled,
          dateBuilder: dateBuilder,
          weekDayBuilder: weekDayBuilder,
        );
      },
    );
  }
}
