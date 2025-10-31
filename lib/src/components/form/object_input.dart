import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Reactive date input field with integrated date picker and text editing.
///
/// A high-level date input widget that combines text field functionality with
/// date picker integration. Provides automatic state management through the
/// controlled component pattern with support for both dialog and popover modes.
///
/// ## Features
///
/// - **Dual input modes**: Text field editing with date picker integration
/// - **Multiple presentation modes**: Dialog or popover-based date selection
/// - **Flexible date formatting**: Customizable date part ordering and separators
/// - **Calendar integration**: Rich calendar interface with multiple view types
/// - **Form integration**: Automatic validation and form field registration
/// - **Accessibility**: Full screen reader and keyboard navigation support
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = DatePickerController(DateTime.now());
///
/// DateInput(
///   controller: controller,
///   mode: PromptMode.popover,
///   placeholder: Text('Select date'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// DateTime? selectedDate;
///
/// DateInput(
///   initialValue: selectedDate,
///   onChanged: (date) => setState(() => selectedDate = date),
///   mode: PromptMode.dialog,
///   dialogTitle: Text('Choose Date'),
/// )
/// ```
class DateInput extends StatefulWidget with ControlledComponent<DateTime?> {
  @override
  final DateTime? initialValue;
  @override
  final ValueChanged<DateTime?>? onChanged;
  @override
  final bool enabled;
  @override
  final DatePickerController? controller;

  /// Placeholder widget shown when no date is selected.
  final Widget? placeholder;

  /// Presentation mode for date picker (dialog or popover).
  final PromptMode mode;

  /// Initial calendar view to display.
  final CalendarView? initialView;

  /// Alignment of popover relative to anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment of anchor for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title widget for dialog mode.
  final Widget? dialogTitle;

  /// Initial view type (date, month, or year).
  final CalendarViewType? initialViewType;

  /// Callback to determine date state (enabled/disabled).
  final DateStateBuilder? stateBuilder;

  /// Order of date components in the input display.
  final List<DatePart>? datePartsOrder;

  /// Separator widget between date parts.
  final InputPart? separator;

  /// Custom placeholders for individual date parts.
  final Map<DatePart, Widget>? placeholders;

  /// Creates a [DateInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with flexible date picker integration options.
  ///
  /// Parameters:
  /// - [controller] (DatePickerController?, optional): external state controller
  /// - [initialValue] (DateTime?, optional): starting date when no controller
  /// - [onChanged] (`ValueChanged<DateTime?>?`, optional): date change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no date selected
  /// - [mode] (PromptMode, default: dialog): date picker presentation mode
  /// - [initialView] (CalendarView?, optional): starting calendar view
  /// - [popoverAlignment] (AlignmentGeometry?, optional): popover alignment
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): anchor alignment
  /// - [popoverPadding] (EdgeInsetsGeometry?, optional): popover padding
  /// - [dialogTitle] (Widget?, optional): title for dialog mode
  /// - [initialViewType] (CalendarViewType?, optional): calendar view type
  /// - [stateBuilder] (DateStateBuilder?, optional): custom date state builder
  /// - [datePartsOrder] (`List<DatePart>?`, optional): order of date components
  /// - [separator] (InputPart?, optional): separator between date parts
  /// - [placeholders] (`Map<DatePart, Widget>?`, optional): placeholders for date parts
  ///
  /// Example:
  /// ```dart
  /// DateInput(
  ///   controller: controller,
  ///   mode: PromptMode.popover,
  ///   placeholder: Text('Select date'),
  ///   datePartsOrder: [DatePart.month, DatePart.day, DatePart.year],
  /// )
  /// ```
  const DateInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.mode = PromptMode.dialog,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
    this.datePartsOrder,
    this.separator,
    this.placeholders,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

/// Represents a date with nullable components (year, month, day).
///
/// Useful for date input scenarios where individual date parts may be
/// missing or incomplete. Can convert to [DateTime] when all parts are present.
///
/// Example:
/// ```dart
/// final date = NullableDate(year: 2024, month: 1, day: 15);
/// print(date.nullableDate); // DateTime(2024, 1, 15)
/// ```
class NullableDate {
  /// The year component (nullable).
  final int? year;

  /// The month component (nullable).
  final int? month;

  /// The day component (nullable).
  final int? day;

  /// Creates a [NullableDate].
  ///
  /// Parameters:
  /// - [year] (`int?`, optional): Year value.
  /// - [month] (`int?`, optional): Month value (1-12).
  /// - [day] (`int?`, optional): Day value (1-31).
  NullableDate({this.year, this.month, this.day});

  @override
  String toString() {
    return 'NullableDate{year: $year, month: $month, day: $day}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NullableDate &&
        other.year == year &&
        other.month == month &&
        other.day == day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  /// Creates a copy with specified parts replaced.
  ///
  /// Parameters:
  /// - [year] (`ValueGetter<int?>?`, optional): New year value.
  /// - [month] (`ValueGetter<int?>?`, optional): New month value.
  /// - [day] (`ValueGetter<int?>?`, optional): New day value.
  ///
  /// Returns: A new [NullableDate] with updated parts.
  NullableDate copyWith({
    ValueGetter<int?>? year,
    ValueGetter<int?>? month,
    ValueGetter<int?>? day,
  }) {
    return NullableDate(
      year: year == null ? this.year : year(),
      month: month == null ? this.month : month(),
      day: day == null ? this.day : day(),
    );
  }

  /// Converts to [DateTime], using 0 for missing parts.
  ///
  /// Returns: A [DateTime] instance (may be invalid if parts are null/0).
  DateTime get date {
    return DateTime(year ?? 0, month ?? 0, day ?? 0);
  }

  /// Converts to [DateTime] only if all parts are present.
  ///
  /// Returns: A [DateTime] if complete, otherwise null.
  DateTime? get nullableDate {
    if (year == null || month == null || day == null) {
      return null;
    }
    return date;
  }

  /// Retrieves the value of a specific date part.
  ///
  /// Parameters:
  /// - [part] (`DatePart`, required): The date part to retrieve.
  ///
  /// Returns: The value of the specified part, or null if not set.
  int? operator [](DatePart part) {
    switch (part) {
      case DatePart.year:
        return year;
      case DatePart.month:
        return month;
      case DatePart.day:
        return day;
    }
  }

  /// Converts to a map of date parts.
  ///
  /// Returns: A `Map<DatePart, int>` with non-null parts.
  Map<DatePart, int> toMap() {
    return {
      if (year != null) DatePart.year: year!,
      if (month != null) DatePart.month: month!,
      if (day != null) DatePart.day: day!,
    };
  }
}

class _DateInputState extends State<DateInput> {
  late ComponentController<NullableDate> _controller;

  NullableDate _convertToDateTime(List<String?> values) {
    Map<DatePart, String?> parts = {};
    var datePartsOrder =
        widget.datePartsOrder ?? ShadcnLocalizations.of(context).datePartsOrder;
    for (int i = 0; i < values.length; i++) {
      parts[datePartsOrder[i]] = values[i];
    }
    String? yearString = parts[DatePart.year];
    String? monthString = parts[DatePart.month];
    String? dayString = parts[DatePart.day];
    int? year = yearString == null || yearString.isEmpty
        ? null
        : int.tryParse(yearString);
    int? month = monthString == null || monthString.isEmpty
        ? null
        : int.tryParse(monthString);
    int? day =
        dayString == null || dayString.isEmpty ? null : int.tryParse(dayString);
    return NullableDate(year: year, month: month, day: day);
  }

  List<String?> _convertFromDateTime(NullableDate? value) {
    var datePartsOrder =
        widget.datePartsOrder ?? ShadcnLocalizations.of(context).datePartsOrder;
    if (value == null) {
      return datePartsOrder.map((part) => null).toList();
    }
    var validDateTime = value.nullableDate;
    if (validDateTime == null) {
      return datePartsOrder.map((part) => null).toList();
    }
    return datePartsOrder.map((part) {
      switch (part) {
        case DatePart.year:
          return validDateTime.year.toString();
        case DatePart.month:
          return validDateTime.month.toString();
        case DatePart.day:
          return validDateTime.day.toString();
      }
    }).toList();
  }

  double _getWidth(DatePart part) {
    switch (part) {
      case DatePart.year:
        return 60;
      case DatePart.month:
        return 40;
      case DatePart.day:
        return 40;
    }
  }

  Widget _getPlaceholder(DatePart part) {
    var localizations = ShadcnLocalizations.of(context);
    return Text(localizations.getDatePartAbbreviation(part));
  }

  int _getLength(DatePart part) {
    switch (part) {
      case DatePart.year:
        return 4;
      case DatePart.month:
        return 2;
      case DatePart.day:
        return 2;
    }
  }

  NullableDate _convertToNullableDate(DateTime? value) {
    if (value == null) {
      return NullableDate();
    }
    return NullableDate(year: value.year, month: value.month, day: value.day);
  }

  DateTime? _convertFromNullableDate(NullableDate value) {
    return value.nullableDate;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? ComponentValueController<NullableDate>(
            _convertToNullableDate(widget.initialValue))
        : ConvertedController<DateTime?, NullableDate>(
            widget.controller!,
            BiDirectionalConvert(
                _convertToNullableDate, _convertFromNullableDate),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var datePartsOrder =
        widget.datePartsOrder ?? ShadcnLocalizations.of(context).datePartsOrder;
    return FormattedObjectInput<NullableDate>(
      popupBuilder: (context, controller) {
        return SurfaceCard(
          child: DatePickerDialog(
            initialViewType: widget.initialViewType ?? CalendarViewType.date,
            selectionMode: CalendarSelectionMode.single,
            initialValue: controller.value == null
                ? null
                : CalendarValue.single(controller.value!.date),
            initialView: widget.initialView ?? CalendarView.now(),
            stateBuilder: widget.stateBuilder,
            onChanged: (value) {
              var date = value?.toSingle().date;
              controller.value = NullableDate(
                year: date?.year,
                month: date?.month,
                day: date?.day,
              );
            },
          ),
        );
      },
      popoverIcon: const Icon(LucideIcons.calendarDays),
      converter: BiDirectionalConvert(_convertFromDateTime, _convertToDateTime),
      controller: _controller,
      initialValue: _convertToNullableDate(widget.initialValue),
      onChanged: (value) {
        widget.onChanged
            ?.call(value == null ? null : _convertFromNullableDate(value));
      },
      parts: datePartsOrder
          .map(
            (part) {
              return InputPart.editable(
                  length: _getLength(part),
                  width: _getWidth(part),
                  placeholder:
                      widget.placeholders?[part] ?? _getPlaceholder(part),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ]);
            },
          )
          .joinSeparator(const InputPart.static('/'))
          .toList(),
    );
  }
}

/// Represents a time with nullable components (hour, minute, second).
///
/// Useful for time input scenarios where individual time parts may be
/// missing or incomplete. Can convert to [TimeOfDay] when hour and minute are present.
///
/// Example:
/// ```dart
/// final time = NullableTimeOfDay(hour: 14, minute: 30, second: 0);
/// print(time.toTimeOfDay); // TimeOfDay(hour: 14, minute: 30)
/// ```
class NullableTimeOfDay {
  /// The hour component (nullable, 0-23).
  final int? hour;

  /// The minute component (nullable, 0-59).
  final int? minute;

  /// The second component (nullable, 0-59).
  final int? second;

  /// Creates a [NullableTimeOfDay].
  ///
  /// Parameters:
  /// - [hour] (`int?`, optional): Hour value (0-23).
  /// - [minute] (`int?`, optional): Minute value (0-59).
  /// - [second] (`int?`, optional): Second value (0-59).
  NullableTimeOfDay({this.hour, this.minute, this.second});

  @override
  String toString() {
    return 'NullableTimeOfDay{hour: $hour, minute: $minute, second: $second}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NullableTimeOfDay &&
        other.hour == hour &&
        other.minute == minute &&
        other.second == second;
  }

  @override
  int get hashCode => Object.hash(hour, minute, second);

  /// Creates a copy with specified parts replaced.
  ///
  /// Parameters:
  /// - [hour] (`ValueGetter<int?>?`, optional): New hour value.
  /// - [minute] (`ValueGetter<int?>?`, optional): New minute value.
  /// - [second] (`ValueGetter<int?>?`, optional): New second value.
  ///
  /// Returns: A new [NullableTimeOfDay] with updated parts.
  NullableTimeOfDay copyWith({
    ValueGetter<int?>? hour,
    ValueGetter<int?>? minute,
    ValueGetter<int?>? second,
  }) {
    return NullableTimeOfDay(
      hour: hour == null ? this.hour : hour(),
      minute: minute == null ? this.minute : minute(),
      second: second == null ? this.second : second(),
    );
  }

  /// Converts to [TimeOfDay] if hour and minute are present.
  ///
  /// Returns: A [TimeOfDay] instance, or null if hour or minute is missing.
  TimeOfDay? get toTimeOfDay {
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour!, minute: minute!);
  }

  /// Creates a [NullableTimeOfDay] from a [TimeOfDay].
  ///
  /// Parameters:
  /// - [timeOfDay] (`TimeOfDay?`, optional): The time to convert.
  ///
  /// Returns: A [NullableTimeOfDay] instance, or null if input is null.
  static NullableTimeOfDay? fromTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return null;
    }
    return NullableTimeOfDay(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: timeOfDay.second,
    );
  }

  /// Retrieves the value of a specific time part.
  ///
  /// Parameters:
  /// - [part] (`TimePart`, required): The time part to retrieve.
  ///
  /// Returns: The value of the specified part, or null if not set.
  int? operator [](TimePart part) {
    switch (part) {
      case TimePart.hour:
        return hour;
      case TimePart.minute:
        return minute;
      case TimePart.second:
        return second;
    }
  }

  /// Converts to a map of time parts.
  ///
  /// Returns: A `Map<TimePart, int>` with non-null parts.
  Map<TimePart, int> toMap() {
    return {
      if (hour != null) TimePart.hour: hour!,
      if (minute != null) TimePart.minute: minute!,
      if (second != null) TimePart.second: second!,
    };
  }
}

/// Reactive time input field with formatted text editing and validation.
///
/// A high-level time input widget that provides structured time entry through
/// formatted text fields. Supports hours, minutes, and optional seconds with
/// automatic state management through the controlled component pattern.
///
/// ## Features
///
/// - **Structured time entry**: Separate fields for hours, minutes, and seconds
/// - **Format validation**: Automatic validation and formatting of time components
/// - **Flexible display**: Optional seconds display and customizable separators
/// - **Form integration**: Automatic validation and form field registration
/// - **Keyboard navigation**: Tab navigation between time components
/// - **Accessibility**: Full screen reader support and keyboard input
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = ComponentController<TimeOfDay?>(TimeOfDay.now());
///
/// TimeInput(
///   controller: controller,
///   showSeconds: true,
///   placeholder: Text('Enter time'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// TimeOfDay? selectedTime;
///
/// TimeInput(
///   initialValue: selectedTime,
///   onChanged: (time) => setState(() => selectedTime = time),
///   showSeconds: false,
///   separator: InputPart.text(':'),
/// )
/// ```
class TimeInput extends StatefulWidget with ControlledComponent<TimeOfDay?> {
  @override
  final TimeOfDay? initialValue;
  @override
  final ValueChanged<TimeOfDay?>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<TimeOfDay?>? controller;

  /// Placeholder widget shown when no time is selected.
  final Widget? placeholder;

  /// Whether to show seconds input field.
  final bool showSeconds;

  /// Separator widget between time parts.
  final InputPart? separator;

  /// Custom placeholders for individual time parts.
  final Map<TimePart, Widget>? placeholders;

  /// Creates a [TimeInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with structured time component entry.
  ///
  /// Parameters:
  /// - [controller] (`ComponentController<TimeOfDay?>?`, optional): external state controller
  /// - [initialValue] (TimeOfDay?, optional): starting time when no controller
  /// - [onChanged] (`ValueChanged<TimeOfDay?>?`, optional): time change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no time selected
  /// - [showSeconds] (bool, default: false): whether to include seconds input
  /// - [separator] (InputPart?, optional): separator between time components
  /// - [placeholders] (`Map<TimePart, Widget>?`, optional): placeholders for time parts
  ///
  /// Example:
  /// ```dart
  /// TimeInput(
  ///   controller: controller,
  ///   showSeconds: true,
  ///   separator: InputPart.text(':'),
  ///   placeholders: {
  ///     TimePart.hour: Text('HH'),
  ///     TimePart.minute: Text('MM'),
  ///     TimePart.second: Text('SS'),
  ///   },
  /// )
  /// ```
  const TimeInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.showSeconds = false,
    this.separator,
    this.placeholders,
  });

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  late ComponentController<NullableTimeOfDay> _controller;

  NullableTimeOfDay _convertToTimeOfDay(List<String?> values) {
    int? hour = values[0] == null || values[0]!.isEmpty
        ? null
        : int.tryParse(values[0]!);
    int? minute = values[1] == null || values[1]!.isEmpty
        ? null
        : int.tryParse(values[1]!);
    int? second = widget.showSeconds && values.length > 2
        ? (values[2] == null || values[2]!.isEmpty
            ? null
            : int.tryParse(values[2]!))
        : null;
    return NullableTimeOfDay(hour: hour, minute: minute, second: second);
  }

  List<String?> _convertFromTimeOfDay(NullableTimeOfDay? value) {
    if (value == null) {
      return [null, null, if (widget.showSeconds) null];
    }
    return [
      value.hour?.toString(),
      value.minute?.toString(),
      if (widget.showSeconds) value.second?.toString(),
    ];
  }

  double _getWidth(TimePart part) {
    return 40;
  }

  Widget _getPlaceholder(TimePart part) {
    var localizations = ShadcnLocalizations.of(context);
    return Text(localizations.getTimePartAbbreviation(part));
  }

  int _getLength(TimePart part) {
    return 2;
  }

  NullableTimeOfDay _convertToNullableTimeOfDay(TimeOfDay? value) {
    if (value == null) {
      return NullableTimeOfDay();
    }
    return NullableTimeOfDay(
      hour: value.hour,
      minute: value.minute,
      second: widget.showSeconds ? value.second : null,
    );
  }

  TimeOfDay? _convertFromNullableTimeOfDay(NullableTimeOfDay value) {
    return value.toTimeOfDay;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? ComponentValueController<NullableTimeOfDay>(
            _convertToNullableTimeOfDay(widget.initialValue))
        : ConvertedController<TimeOfDay?, NullableTimeOfDay>(
            widget.controller!,
            BiDirectionalConvert(
                _convertToNullableTimeOfDay, _convertFromNullableTimeOfDay),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormattedObjectInput<NullableTimeOfDay>(
      converter:
          BiDirectionalConvert(_convertFromTimeOfDay, _convertToTimeOfDay),
      controller: _controller,
      initialValue: _convertToNullableTimeOfDay(widget.initialValue),
      onChanged: (value) {
        widget.onChanged
            ?.call(value == null ? null : _convertFromNullableTimeOfDay(value));
      },
      parts: [
        InputPart.editable(
          length: _getLength(TimePart.hour),
          width: _getWidth(TimePart.hour),
          placeholder: widget.placeholders?[TimePart.hour] ??
              _getPlaceholder(TimePart.hour),
        ),
        widget.separator ?? const InputPart.static(':'),
        InputPart.editable(
          length: _getLength(TimePart.minute),
          width: _getWidth(TimePart.minute),
          placeholder: widget.placeholders?[TimePart.minute] ??
              _getPlaceholder(TimePart.minute),
        ),
        if (widget.showSeconds) ...[
          widget.separator ?? const InputPart.static(':'),
          InputPart.editable(
            length: _getLength(TimePart.second),
            width: _getWidth(TimePart.second),
            placeholder: widget.placeholders?[TimePart.second] ??
                _getPlaceholder(TimePart.second),
          ),
        ],
      ],
    );
  }
}

/// Reactive duration input field with formatted text editing and validation.
///
/// A high-level duration input widget that provides structured duration entry through
/// formatted text fields. Supports hours, minutes, and optional seconds with
/// automatic state management through the controlled component pattern.
///
/// ## Features
///
/// - **Structured duration entry**: Separate fields for hours, minutes, and seconds
/// - **Format validation**: Automatic validation and formatting of duration components
/// - **Flexible display**: Optional seconds display and customizable separators
/// - **Large value support**: Handle durations spanning multiple hours or days
/// - **Form integration**: Automatic validation and form field registration
/// - **Keyboard navigation**: Tab navigation between duration components
/// - **Accessibility**: Full screen reader support and keyboard input
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = ComponentController<Duration?>(Duration(hours: 1, minutes: 30));
///
/// DurationInput(
///   controller: controller,
///   showSeconds: true,
///   placeholder: Text('Enter duration'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// Duration? selectedDuration;
///
/// DurationInput(
///   initialValue: selectedDuration,
///   onChanged: (duration) => setState(() => selectedDuration = duration),
///   showSeconds: false,
///   separator: InputPart.text(':'),
/// )
/// ```
class DurationInput extends StatefulWidget with ControlledComponent<Duration?> {
  @override
  final Duration? initialValue;
  @override
  final ValueChanged<Duration?>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<Duration?>? controller;

  /// Placeholder widget shown when no duration is selected.
  final Widget? placeholder;

  /// Whether to show seconds input field.
  final bool showSeconds;

  /// Separator widget between duration parts.
  final InputPart? separator;

  /// Custom placeholders for individual time parts.
  final Map<TimePart, Widget>? placeholders;

  /// Creates a [DurationInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with structured duration component entry.
  ///
  /// Parameters:
  /// - [controller] (`ComponentController<Duration?>?`, optional): external state controller
  /// - [initialValue] (Duration?, optional): starting duration when no controller
  /// - [onChanged] (`ValueChanged<Duration?>?`, optional): duration change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no duration selected
  /// - [showSeconds] (bool, default: false): whether to include seconds input
  /// - [separator] (InputPart?, optional): separator between duration components
  /// - [placeholders] (`Map<TimePart, Widget>?`, optional): placeholders for time parts
  ///
  /// Example:
  /// ```dart
  /// DurationInput(
  ///   controller: controller,
  ///   showSeconds: true,
  ///   separator: InputPart.text(':'),
  ///   placeholders: {
  ///     TimePart.hour: Text('HH'),
  ///     TimePart.minute: Text('MM'),
  ///     TimePart.second: Text('SS'),
  ///   },
  /// )
  /// ```
  const DurationInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.showSeconds = false,
    this.separator,
    this.placeholders,
  });

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  late ComponentController<NullableTimeOfDay> _controller;

  NullableTimeOfDay _convertToDuration(List<String?> values) {
    int? hours = values[0] == null || values[0]!.isEmpty
        ? null
        : int.tryParse(values[0]!);
    int? minutes = values[1] == null || values[1]!.isEmpty
        ? null
        : int.tryParse(values[1]!);
    int? seconds = widget.showSeconds && values.length > 2
        ? (values[2] == null || values[2]!.isEmpty
            ? null
            : int.tryParse(values[2]!))
        : null;
    return NullableTimeOfDay(hour: hours, minute: minutes, second: seconds);
  }

  List<String?> _convertFromDuration(NullableTimeOfDay? value) {
    if (value == null) {
      return [null, null, if (widget.showSeconds) null];
    }
    return [
      value.hour?.toString(),
      value.minute?.toString(),
      if (widget.showSeconds) value.second?.toString(),
    ];
  }

  double _getWidth(TimePart part) {
    return 40;
  }

  Widget _getPlaceholder(TimePart part) {
    var localizations = ShadcnLocalizations.of(context);
    return Text(localizations.getTimePartAbbreviation(part));
  }

  int _getLength(TimePart part) {
    return 2;
  }

  NullableTimeOfDay _convertToNullableTimeOfDay(Duration? value) {
    if (value == null) {
      return NullableTimeOfDay();
    }
    return NullableTimeOfDay(
      hour: value.inHours,
      minute: value.inMinutes % 60,
      second: widget.showSeconds ? value.inSeconds % 60 : null,
    );
  }

  Duration? _convertFromNullableTimeOfDay(NullableTimeOfDay value) {
    if (value.hour == null ||
        value.minute == null ||
        (widget.showSeconds && value.second == null)) {
      return null;
    }
    return Duration(
      hours: value.hour!,
      minutes: value.minute!,
      seconds: widget.showSeconds ? (value.second ?? 0) : 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? ComponentValueController<NullableTimeOfDay>(
            _convertToNullableTimeOfDay(widget.initialValue))
        : ConvertedController<Duration?, NullableTimeOfDay>(
            widget.controller!,
            BiDirectionalConvert(
                _convertToNullableTimeOfDay, _convertFromNullableTimeOfDay),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormattedObjectInput<NullableTimeOfDay>(
      converter: BiDirectionalConvert(_convertFromDuration, _convertToDuration),
      controller: _controller,
      initialValue: _convertToNullableTimeOfDay(widget.initialValue),
      onChanged: (value) {
        widget.onChanged
            ?.call(value == null ? null : _convertFromNullableTimeOfDay(value));
      },
      parts: [
        InputPart.editable(
          length: _getLength(TimePart.hour),
          width: _getWidth(TimePart.hour),
          placeholder: widget.placeholders?[TimePart.hour] ??
              _getPlaceholder(TimePart.hour),
        ),
        widget.separator ?? const InputPart.static(':'),
        InputPart.editable(
          length: _getLength(TimePart.minute),
          width: _getWidth(TimePart.minute),
          placeholder: widget.placeholders?[TimePart.minute] ??
              _getPlaceholder(TimePart.minute),
        ),
        if (widget.showSeconds) ...[
          widget.separator ?? const InputPart.static(':'),
          InputPart.editable(
            length: _getLength(TimePart.second),
            width: _getWidth(TimePart.second),
            placeholder: widget.placeholders?[TimePart.second] ??
                _getPlaceholder(TimePart.second),
          ),
        ],
      ],
    );
  }
}
