import '../../../shadcn_flutter.dart';

class DatePicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final Widget? placeholder;
  final PromptMode mode;
  final CalendarView? initialView;
  final bool Function(DateTime date)? isDateEnabled;
  final Widget Function(BuildContext context, DateTime date)? dateBuilder;
  final Widget Function(BuildContext context, int weekday)? weekDayBuilder;
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;
  final Widget? dialogTitle;

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
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return ObjectFormField(
      dialogTitle: dialogTitle,
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
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;
  final Widget? dialogTitle;

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
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
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
      dialogTitle: dialogTitle,
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
