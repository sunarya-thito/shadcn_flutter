import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimePickerController extends ValueNotifier<TimeOfDay?>
    with ComponentController<TimeOfDay?> {
  TimePickerController([super.value]);
}

class ControlledTimePicker extends StatelessWidget
    with ControlledComponent<TimeOfDay?> {
  @override
  final TimeOfDay? initialValue;
  @override
  final ValueChanged<TimeOfDay?>? onChanged;
  @override
  final bool enabled;
  @override
  final TimePickerController? controller;

  final PromptMode mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final bool? use24HourFormat;
  final bool showSeconds;
  final Widget? dialogTitle;

  const ControlledTimePicker({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.mode = PromptMode.dialog,
    this.placeholder,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.use24HourFormat,
    this.showSeconds = false,
    this.dialogTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return TimePicker(
          value: data.value,
          onChanged: data.onChanged,
          mode: mode,
          placeholder: placeholder,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          popoverPadding: popoverPadding,
          use24HourFormat: use24HourFormat,
          showSeconds: showSeconds,
          dialogTitle: dialogTitle,
          enabled: data.enabled,
        );
      },
    );
  }
}

class TimePicker extends StatelessWidget {
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?>? onChanged;
  final PromptMode mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final bool? use24HourFormat;
  final bool showSeconds;
  final Widget? dialogTitle;
  final bool? enabled;

  const TimePicker({
    super.key,
    required this.value,
    this.onChanged,
    this.mode = PromptMode.dialog,
    this.placeholder,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.use24HourFormat,
    this.showSeconds = false,
    this.dialogTitle,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    bool use24HourFormat =
        this.use24HourFormat ?? MediaQuery.of(context).alwaysUse24HourFormat;
    return ObjectFormField(
      value: value,
      placeholder: placeholder ?? Text(localizations.placeholderTimePicker),
      onChanged: onChanged,
      builder: (context, value) {
        return Text(localizations.formatTimeOfDay(value,
            use24HourFormat: use24HourFormat, showSeconds: showSeconds));
      },
      enabled: enabled,
      mode: mode,
      dialogTitle: dialogTitle,
      trailing: const Icon(Icons.access_time),
      editorBuilder: (context, handler) {
        return TimePickerDialog(
          initialValue: handler.value,
          onChanged: (value) {
            handler.value = value;
          },
          use24HourFormat: use24HourFormat,
          showSeconds: showSeconds,
        );
      },
    );
  }
}

class TimePickerDialog extends StatefulWidget {
  final TimeOfDay? initialValue;
  final ValueChanged<TimeOfDay?>? onChanged;
  final bool use24HourFormat;
  final bool showSeconds;

  const TimePickerDialog({
    super.key,
    this.initialValue,
    this.onChanged,
    required this.use24HourFormat,
    this.showSeconds = false,
  });

  @override
  State<TimePickerDialog> createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  late TextEditingController _hourController;
  late TextEditingController _minuteController;
  late TextEditingController _secondController;
  late bool _pm;
  String _formatDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  Widget _buildInput(
      BuildContext context, TextEditingController controller, String label) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 72 * theme.scaling, minHeight: 72 * theme.scaling),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              style: theme.typography.x4Large,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                const _TimeFormatter(),
              ],
            ),
          ),
          Positioned(
            bottom: (-24) * theme.scaling,
            child: Text(label).muted(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return const Text(':').x5Large().withPadding(horizontal: 8 * scaling);
  }

  void _onChanged() {
    int hour = int.tryParse(_hourController.text) ?? 0;
    int minute = int.tryParse(_minuteController.text) ?? 0;
    int second = int.tryParse(_secondController.text) ?? 0;
    if (widget.use24HourFormat) {
      hour = hour.clamp(0, 23);
      minute = minute.clamp(0, 59);
      second = second.clamp(0, 59);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onChanged
            ?.call(TimeOfDay(hour: hour, minute: minute, second: second));
      });
    } else {
      if (_pm && hour < 12) {
        hour += 12;
      } else if (!_pm && hour == 12) {
        hour = 0;
      }
      hour = hour.clamp(0, 23);
      minute = minute.clamp(0, 59);
      second = second.clamp(0, 59);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) return;
        widget.onChanged
            ?.call(TimeOfDay(hour: hour, minute: minute, second: second));
      });
    }
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pm = (widget.initialValue?.hour ?? 0) >= 12;
    int initialHour = widget.initialValue?.hour ?? 0;
    int initialMinute = widget.initialValue?.minute ?? 0;
    int initialSecond = widget.initialValue?.second ?? 0;
    if (!widget.use24HourFormat && initialHour > 12 && initialHour <= 23) {
      initialHour -= 12;
      _pm = true;
    }
    _hourController = TextEditingController(
      text: _formatDigits(initialHour),
    );
    _minuteController = TextEditingController(
      text: _formatDigits(initialMinute),
    );
    _secondController = TextEditingController(
      text: _formatDigits(initialSecond),
    );
    _hourController.addListener(_onChanged);
    _minuteController.addListener(_onChanged);
    _secondController.addListener(_onChanged);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final localizations = ShadcnLocalizations.of(context);
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(bottom: (16 + 12) * scaling),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: _buildInput(
                  context,
                  _hourController,
                  localizations.timeHour,
                ),
              ),
              _buildSeparator(context),
              Expanded(
                child: _buildInput(
                  context,
                  _minuteController,
                  localizations.timeMinute,
                ),
              ),
              if (widget.showSeconds) ...[
                _buildSeparator(context),
                Expanded(
                  child: _buildInput(
                    context,
                    _secondController,
                    localizations.timeSecond,
                  ),
                ),
              ],
              if (!widget.use24HourFormat) ...[
                Gap(8 * scaling),
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Toggle(
                          value: !_pm,
                          onChanged: (value) {
                            setState(() {
                              _pm = !value;
                              _onChanged();
                            });
                          },
                          child: Text(localizations.timeAM),
                        ),
                      ),
                      Expanded(
                        child: Toggle(
                          value: _pm,
                          onChanged: (value) {
                            setState(() {
                              _pm = value;
                              _onChanged();
                            });
                          },
                          child: Text(localizations.timePM),
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeFormatter extends TextInputFormatter {
  const _TimeFormatter();
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // make sure new value has leading zero
    var newText = newValue.text;
    int substringCount = 0;
    if (newText.length > 2) {
      substringCount = newText.length - 2;
      newText = newText.substring(substringCount);
    }
    int padLength = 2 - newText.length;
    var baseOffset2 = newValue.selection.baseOffset;
    var extentOffset2 = newValue.selection.extentOffset;
    if (padLength > 0) {
      newText = newText.padLeft(2, '0');
      baseOffset2 = baseOffset2 + padLength;
      extentOffset2 = extentOffset2 + padLength;
    }
    return newValue.copyWith(
      text: newText,
      composing: newValue.composing.isValid
          ? TextRange(
              start: newValue.composing.start.clamp(0, 2),
              end: newValue.composing.end.clamp(0, 2),
            )
          : newValue.composing,
      selection: TextSelection(
        baseOffset: baseOffset2.clamp(0, 2),
        extentOffset: extentOffset2.clamp(0, 2),
      ),
    );
  }
}

class DurationPickerController extends ValueNotifier<Duration?>
    with ComponentController<Duration?> {
  DurationPickerController(super.value);
}

enum DurationPart {
  day,
  hour,
  minute,
  second,
}

enum TimePart {
  hour,
  minute,
  second,
}

class DurationPicker extends StatelessWidget {
  final Duration? value;
  final ValueChanged<Duration?>? onChanged;
  final PromptMode mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final bool? enabled;

  const DurationPicker({
    super.key,
    required this.value,
    this.onChanged,
    this.mode = PromptMode.dialog,
    this.placeholder,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return ObjectFormField(
      value: value,
      placeholder: placeholder ?? Text(localizations.placeholderDurationPicker),
      onChanged: onChanged,
      builder: (context, value) {
        return Text(localizations.formatDuration(value));
      },
      enabled: enabled,
      mode: mode,
      dialogTitle: dialogTitle,
      trailing: const Icon(Icons.access_time),
      editorBuilder: (context, handler) {
        return DurationPickerDialog(
          initialValue: handler.value,
          onChanged: (value) {
            handler.value = value;
          },
        );
      },
    );
  }
}

class DurationPickerDialog extends StatefulWidget {
  final Duration? initialValue;
  final ValueChanged<Duration?>? onChanged;

  const DurationPickerDialog({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  late TextEditingController _dayController;
  late TextEditingController _hourController;
  late TextEditingController _minuteController;
  late TextEditingController _secondController;

  String _formatDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  Widget _buildInput(
      BuildContext context, TextEditingController controller, String label) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 72 * theme.scaling, minHeight: 72 * theme.scaling),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: TextField(
              textAlign: TextAlign.center,
              controller: controller,
              style: theme.typography.x4Large,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                const _TimeFormatter(),
              ],
            ),
          ),
          Positioned(
            bottom: (-24) * theme.scaling,
            child: Text(label).muted(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return const Text(':').x5Large().withPadding(horizontal: 8 * scaling);
  }

  void _onChanged() {
    int day = int.tryParse(_dayController.text) ?? 0;
    int hour = int.tryParse(_hourController.text) ?? 0;
    int minute = int.tryParse(_minuteController.text) ?? 0;
    int second = int.tryParse(_secondController.text) ?? 0;
    day = day.clamp(0, 999);
    hour = hour.clamp(0, 23);
    minute = minute.clamp(0, 59);
    second = second.clamp(0, 59);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onChanged?.call(Duration(
        days: day,
        hours: hour,
        minutes: minute,
        seconds: second,
      ));
    });
  }

  @override
  void dispose() {
    _dayController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    int initialDay = widget.initialValue?.inDays ?? 0;
    int initialHour = widget.initialValue?.inHours ?? 0;
    int initialMinute = widget.initialValue?.inMinutes ?? 0;
    int initialSecond = widget.initialValue?.inSeconds ?? 0;
    _dayController = TextEditingController(
      text: _formatDigits(initialDay),
    );
    _hourController = TextEditingController(
      text: _formatDigits(initialHour % Duration.hoursPerDay),
    );
    _minuteController = TextEditingController(
      text: _formatDigits(initialMinute % Duration.minutesPerHour),
    );
    _secondController = TextEditingController(
      text: _formatDigits(initialSecond % Duration.secondsPerMinute),
    );
    _dayController.addListener(_onChanged);
    _hourController.addListener(_onChanged);
    _minuteController.addListener(_onChanged);
    _secondController.addListener(_onChanged);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final localizations = ShadcnLocalizations.of(context);
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(bottom: (16 + 12) * scaling),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: _buildInput(
                  context,
                  _dayController,
                  localizations.durationDay,
                ),
              ),
              _buildSeparator(context),
              Expanded(
                child: _buildInput(
                  context,
                  _hourController,
                  localizations.durationHour,
                ),
              ),
              _buildSeparator(context),
              Expanded(
                child: _buildInput(
                  context,
                  _minuteController,
                  localizations.durationMinute,
                ),
              ),
              _buildSeparator(context),
              Expanded(
                child: _buildInput(
                  context,
                  _secondController,
                  localizations.durationSecond,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;

  const TimeRange({
    required this.start,
    required this.end,
  });

  TimeRange copyWith({
    TimeOfDay? start,
    TimeOfDay? end,
  }) {
    return TimeRange(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeRange &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return 'TimeRange{start: $start, end: $end}';
  }
}
