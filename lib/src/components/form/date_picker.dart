
import '../../../shadcn_flutter.dart';

/// Theme configuration for [DatePicker] widget styling and behavior.
///
/// Defines the visual properties and default behaviors for date picker components
/// including presentation modes, calendar views, and popover positioning. Applied
/// globally through [ComponentTheme] or per-instance for customization.
///
/// Supports comprehensive customization of date picker appearance, initial views,
/// and interaction modes to match application design requirements.
class DatePickerTheme {
  /// Default interaction mode for date picker triggers.
  ///
  /// Determines whether date selection opens a popover or modal dialog.
  /// When null, uses framework default prompt mode behavior.
  final PromptMode? mode;

  /// Initial calendar view to display when date picker opens.
  ///
  /// Specifies the default time period view (month, year, decade, etc.)
  /// shown when the calendar interface first appears. When null, uses
  /// framework default initial view.
  final CalendarView? initialView;

  /// Initial calendar view type for date picker interface.
  ///
  /// Determines the layout style and interaction pattern of the calendar
  /// (grid, list, compact, etc.). When null, uses framework default view type.
  final CalendarViewType? initialViewType;

  /// Alignment point on the popover for anchor attachment.
  ///
  /// Determines where the date picker popover positions itself relative
  /// to the anchor widget. When null, uses framework default alignment.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment point on the anchor widget for popover positioning.
  ///
  /// Specifies which part of the trigger widget the popover should align to.
  /// When null, uses framework default anchor alignment.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding applied to the date picker popover content.
  ///
  /// Controls spacing around the calendar interface within the popover
  /// container. When null, uses framework default padding.
  final EdgeInsetsGeometry? popoverPadding;

  /// Creates a [DatePickerTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific date picker instances.
  const DatePickerTheme({
    this.mode,
    this.initialView,
    this.initialViewType,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
  });

  DatePickerTheme copyWith({
    ValueGetter<PromptMode?>? mode,
    ValueGetter<CalendarView?>? initialView,
    ValueGetter<CalendarViewType?>? initialViewType,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment,
    ValueGetter<EdgeInsetsGeometry?>? popoverPadding,
  }) {
    return DatePickerTheme(
      mode: mode == null ? this.mode : mode(),
      initialView: initialView == null ? this.initialView : initialView(),
      initialViewType:
          initialViewType == null ? this.initialViewType : initialViewType(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      popoverAnchorAlignment: popoverAnchorAlignment == null
          ? this.popoverAnchorAlignment
          : popoverAnchorAlignment(),
      popoverPadding:
          popoverPadding == null ? this.popoverPadding : popoverPadding(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DatePickerTheme &&
        other.mode == mode &&
        other.initialView == initialView &&
        other.initialViewType == initialViewType &&
        other.popoverAlignment == popoverAlignment &&
        other.popoverAnchorAlignment == popoverAnchorAlignment &&
        other.popoverPadding == popoverPadding;
  }

  @override
  int get hashCode => Object.hash(
        mode,
        initialView,
        initialViewType,
        popoverAlignment,
        popoverAnchorAlignment,
        popoverPadding,
      );
}

class DatePickerController extends ValueNotifier<DateTime?>
    with ComponentController<DateTime?> {
  DatePickerController(super.value);
}

class ControlledDatePicker extends StatelessWidget
    with ControlledComponent<DateTime?> {
  @override
  final DateTime? initialValue;
  @override
  final ValueChanged<DateTime?>? onChanged;
  @override
  final bool enabled;
  @override
  final DatePickerController? controller;

  final Widget? placeholder;
  final PromptMode? mode;
  final CalendarView? initialView;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final CalendarViewType? initialViewType;
  final DateStateBuilder? stateBuilder;

  const ControlledDatePicker({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.mode,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return DatePicker(
          enabled: data.enabled,
          value: data.value,
          onChanged: data.onChanged,
          placeholder: placeholder,
          mode: mode,
          initialView: initialView,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          popoverPadding: popoverPadding,
          dialogTitle: dialogTitle,
          initialViewType: initialViewType,
          stateBuilder: stateBuilder,
        );
      },
    );
  }
}

class DatePicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final Widget? placeholder;
  final PromptMode? mode;
  final CalendarView? initialView;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final CalendarViewType? initialViewType;
  final DateStateBuilder? stateBuilder;
  final bool? enabled;

  const DatePicker({
    super.key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.mode,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    final compTheme = ComponentTheme.maybeOf<DatePickerTheme>(context);
    final resolvedMode = styleValue(
      widgetValue: mode,
      themeValue: compTheme?.mode,
      defaultValue: PromptMode.dialog,
    );
    final resolvedAlignment = styleValue(
      widgetValue: popoverAlignment,
      themeValue: compTheme?.popoverAlignment,
      defaultValue: Alignment.topLeft,
    );
    final resolvedAnchorAlignment = styleValue(
      widgetValue: popoverAnchorAlignment,
      themeValue: compTheme?.popoverAnchorAlignment,
      defaultValue: Alignment.bottomLeft,
    );
    final resolvedPadding = styleValue(
      widgetValue: popoverPadding,
      themeValue: compTheme?.popoverPadding,
      defaultValue: null,
    );
    final resolvedInitialView = styleValue(
      widgetValue: initialView,
      themeValue: compTheme?.initialView,
      defaultValue: CalendarView.now(),
    );
    final resolvedInitialViewType = styleValue(
      widgetValue: initialViewType,
      themeValue: compTheme?.initialViewType,
      defaultValue: CalendarViewType.date,
    );
    return ObjectFormField(
      dialogTitle: dialogTitle,
      enabled: enabled,
      popoverAlignment: resolvedAlignment,
      popoverAnchorAlignment: resolvedAnchorAlignment,
      popoverPadding: resolvedPadding,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder ?? Text(localizations.placeholderDatePicker),
      trailing: const Icon(LucideIcons.calendarDays),
      builder: (context, value) {
        return Text(localizations.formatDateTime(value, showTime: false));
      },
      mode: resolvedMode,
      editorBuilder: (context, handler) {
        return DatePickerDialog(
          initialView: resolvedInitialView,
          initialViewType: resolvedInitialViewType,
          selectionMode: CalendarSelectionMode.single,
          initialValue: handler.value == null
              ? null
              : CalendarValue.single(handler.value!),
          onChanged: (value) {
            handler.value =
                value == null ? null : (value as SingleCalendarValue).date;
          },
          stateBuilder: stateBuilder,
        );
      },
    );
  }
}

class DateTimeRange {
  final DateTime start;
  final DateTime end;

  const DateTimeRange(this.start, this.end);

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
    ValueGetter<DateTime>? start,
    ValueGetter<DateTime>? end,
  }) {
    return DateTimeRange(
      start == null ? this.start : start(),
      end == null ? this.end : end(),
    );
  }
}

class DateRangePicker extends StatelessWidget {
  final DateTimeRange? value;
  final ValueChanged<DateTimeRange?>? onChanged;
  final Widget? placeholder;
  final PromptMode mode;
  final CalendarView? initialView;
  final CalendarViewType? initialViewType;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final DateStateBuilder? stateBuilder;

  const DateRangePicker({
    super.key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.mode = PromptMode.dialog,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
  });

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
      trailing: const Icon(LucideIcons.calendarRange),
      builder: (context, value) {
        return Text(
          '${localizations.formatDateTime(value.start, showTime: false)} - ${localizations.formatDateTime(value.end, showTime: false)}',
        );
      },
      editorBuilder: (context, handler) {
        DateTimeRange? value = handler.value;
        return LayoutBuilder(
          builder: (context, constraints) {
            return DatePickerDialog(
              initialView: initialView,
              initialViewType: initialViewType ?? CalendarViewType.date,
              selectionMode: CalendarSelectionMode.range,
              viewMode: constraints.biggest.width < 500
                  ? CalendarSelectionMode.single
                  : CalendarSelectionMode.range,
              initialValue: value == null
                  ? null
                  : CalendarValue.range(value.start, value.end),
              onChanged: (value) {
                if (value == null) {
                  handler.value = null;
                } else {
                  final range = value.toRange();
                  handler.value = DateTimeRange(range.start, range.end);
                }
              },
              stateBuilder: stateBuilder,
            );
          },
        );
      },
    );
  }
}
