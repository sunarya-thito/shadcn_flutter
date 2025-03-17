import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DateInput extends StatefulWidget with ControlledComponent<DateTime?> {
  @override
  final DateTime? initialValue;
  @override
  final ValueChanged<DateTime?>? onChanged;
  @override
  final bool enabled;
  @override
  final DatePickerController? controller;

  final Widget? placeholder;
  final PromptMode mode;
  final CalendarView? initialView;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final CalendarViewType? initialViewType;
  final DateStateBuilder? stateBuilder;
  final List<DatePart>? datePartsOrder;
  final InputPart? separator;
  final Map<DatePart, Widget>? placeholders;

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

class NullableDate {
  final int? year;
  final int? month;
  final int? day;
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

  NullableDate copyWith({
    int? year,
    int? month,
    int? day,
  }) {
    return NullableDate(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
    );
  }

  DateTime get date {
    return DateTime(year ?? 0, month ?? 0, day ?? 0);
  }

  DateTime? get nullableDate {
    if (year == null || month == null || day == null) {
      return null;
    }
    return date;
  }

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

class NullableTimeOfDay {
  final int? hour;
  final int? minute;
  final int? second;

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

  NullableTimeOfDay copyWith({
    int? hour,
    int? minute,
    int? second,
  }) {
    return NullableTimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  TimeOfDay? get toTimeOfDay {
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour!, minute: minute!);
  }

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

  Map<TimePart, int> toMap() {
    return {
      if (hour != null) TimePart.hour: hour!,
      if (minute != null) TimePart.minute: minute!,
      if (second != null) TimePart.second: second!,
    };
  }
}

class TimeInput extends StatefulWidget with ControlledComponent<TimeOfDay?> {
  @override
  final TimeOfDay? initialValue;
  @override
  final ValueChanged<TimeOfDay?>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<TimeOfDay?>? controller;

  final Widget? placeholder;
  final bool showSeconds;
  final InputPart? separator;
  final Map<TimePart, Widget>? placeholders;

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

class DurationInput extends StatefulWidget with ControlledComponent<Duration?> {
  @override
  final Duration? initialValue;
  @override
  final ValueChanged<Duration?>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<Duration?>? controller;

  final Widget? placeholder;
  final bool showSeconds;
  final InputPart? separator;
  final Map<TimePart, Widget>? placeholders;

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
