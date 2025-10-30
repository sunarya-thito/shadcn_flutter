import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [TimePicker] widget appearance and behavior.
///
/// Defines default settings for time picker components including display
/// format, popover positioning, and dialog customization.
class TimePickerTheme {
  /// Mode for displaying the time picker (popover or dialog).
  final PromptMode? mode;

  /// Alignment of the popover relative to its anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment point on the anchor widget for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Whether to use 24-hour time format.
  final bool? use24HourFormat;

  /// Whether to show seconds picker.
  final bool? showSeconds;

  /// Custom title widget for the time picker dialog.
  final Widget? dialogTitle;

  /// Creates a [TimePickerTheme].
  const TimePickerTheme({
    this.mode,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.use24HourFormat,
    this.showSeconds,
    this.dialogTitle,
  });

  /// Creates a copy of this theme with the given fields replaced.
  TimePickerTheme copyWith({
    ValueGetter<PromptMode?>? mode,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment,
    ValueGetter<EdgeInsetsGeometry?>? popoverPadding,
    ValueGetter<bool?>? use24HourFormat,
    ValueGetter<bool?>? showSeconds,
    ValueGetter<Widget?>? dialogTitle,
  }) {
    return TimePickerTheme(
      mode: mode == null ? this.mode : mode(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      popoverAnchorAlignment: popoverAnchorAlignment == null
          ? this.popoverAnchorAlignment
          : popoverAnchorAlignment(),
      popoverPadding:
          popoverPadding == null ? this.popoverPadding : popoverPadding(),
      use24HourFormat:
          use24HourFormat == null ? this.use24HourFormat : use24HourFormat(),
      showSeconds: showSeconds == null ? this.showSeconds : showSeconds(),
      dialogTitle: dialogTitle == null ? this.dialogTitle : dialogTitle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimePickerTheme &&
        other.mode == mode &&
        other.popoverAlignment == popoverAlignment &&
        other.popoverAnchorAlignment == popoverAnchorAlignment &&
        other.popoverPadding == popoverPadding &&
        other.use24HourFormat == use24HourFormat &&
        other.showSeconds == showSeconds &&
        other.dialogTitle == dialogTitle;
  }

  @override
  int get hashCode => Object.hash(
        mode,
        popoverAlignment,
        popoverAnchorAlignment,
        popoverPadding,
        use24HourFormat,
        showSeconds,
        dialogTitle,
      );
}

/// A controller for managing [ControlledTimePicker] values programmatically.
///
/// This controller extends `ValueNotifier<TimeOfDay?>` to provide reactive
/// state management for time picker components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to time selection changes.
///
/// Example:
/// ```dart
/// final controller = TimePickerController(TimeOfDay(hour: 12, minute: 30));
/// controller.addListener(() {
///   print('Selected time: ${controller.value}');
/// });
/// ```
class TimePickerController extends ValueNotifier<TimeOfDay?>
    with ComponentController<TimeOfDay?> {
  /// Creates a [TimePickerController] with an optional initial value.
  ///
  /// Parameters:
  /// - [value] (TimeOfDay?, optional): Initial time value for the controller
  TimePickerController([super.value]);
}

/// A controlled time picker widget for selecting time values with external state management.
///
/// This widget provides a time selection interface that can be controlled either through
/// a [TimePickerController] or through direct property values. It supports multiple
/// presentation modes (dialog or popover), customizable time formats (12-hour/24-hour),
/// and optional seconds display.
///
/// The time picker integrates with the controlled component system, making it suitable
/// for form integration, validation, and programmatic control. It presents the selected
/// time in a readable format and opens an interactive time selection interface when activated.
///
/// Example:
/// ```dart
/// ControlledTimePicker(
///   initialValue: TimeOfDay(hour: 9, minute: 30),
///   use24HourFormat: true,
///   showSeconds: false,
///   placeholder: Text('Select meeting time'),
///   onChanged: (time) {
///     print('Selected time: ${time?.format(context)}');
///   },
/// );
/// ```
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

  /// The presentation mode for the time picker interface.
  ///
  /// Determines how the time selection interface is displayed to the user.
  /// Can be either dialog mode (modal popup) or popover mode (dropdown).
  final PromptMode mode;

  /// Widget displayed when no time is selected.
  ///
  /// This placeholder appears in the picker button when [initialValue] is null
  /// and no time has been selected yet. If null, a default placeholder is used.
  final Widget? placeholder;

  /// Alignment for the popover relative to its anchor widget.
  ///
  /// Used only when [mode] is [PromptMode.popover]. Controls where the popover
  /// appears relative to the picker button.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment of the anchor point on the picker button.
  ///
  /// Used only when [mode] is [PromptMode.popover]. Determines which point
  /// on the picker button the popover aligns to.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding for the popover content.
  ///
  /// Used only when [mode] is [PromptMode.popover]. Controls spacing inside
  /// the popover container around the time picker interface.
  final EdgeInsetsGeometry? popoverPadding;

  /// Whether to use 24-hour format for time display and input.
  ///
  /// When true, times are displayed in 24-hour format (00:00-23:59).
  /// When false or null, uses the system default format preference.
  final bool? use24HourFormat;

  /// Whether to include seconds in the time selection.
  ///
  /// When true, the time picker allows selection of seconds in addition
  /// to hours and minutes. When false, only hours and minutes are selectable.
  final bool showSeconds;

  /// Optional title widget for the dialog mode.
  ///
  /// Used only when [mode] is [PromptMode.dialog]. Displayed at the top
  /// of the modal time picker dialog.
  final Widget? dialogTitle;

  /// Creates a [ControlledTimePicker].
  ///
  /// Either [controller] or [initialValue] should be provided to establish
  /// the initial time state. The picker can be customized with various
  /// presentation options and time format preferences.
  ///
  /// Parameters:
  /// - [controller] (TimePickerController?, optional): External controller for programmatic control
  /// - [initialValue] (TimeOfDay?, optional): Initial time when no controller is provided
  /// - [onChanged] (`ValueChanged<TimeOfDay?>?`, optional): Callback for time selection changes
  /// - [enabled] (bool, default: true): Whether the picker accepts user interaction
  /// - [mode] (PromptMode, default: PromptMode.dialog): Presentation style (dialog or popover)
  /// - [placeholder] (Widget?, optional): Content displayed when no time is selected
  /// - [popoverAlignment] (AlignmentGeometry?, optional): Popover positioning relative to anchor
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): Anchor point on picker button
  /// - [popoverPadding] (EdgeInsetsGeometry?, optional): Internal popover content padding
  /// - [use24HourFormat] (bool?, optional): Whether to use 24-hour time format
  /// - [showSeconds] (bool, default: false): Whether to include seconds selection
  /// - [dialogTitle] (Widget?, optional): Title for dialog mode display
  ///
  /// Example:
  /// ```dart
  /// ControlledTimePicker(
  ///   initialValue: TimeOfDay(hour: 14, minute: 30),
  ///   mode: PromptMode.popover,
  ///   use24HourFormat: true,
  ///   onChanged: (time) => print('Selected: $time'),
  /// );
  /// ```
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

/// A time picker widget for selecting time values.
///
/// Provides time selection interface with hours, minutes, and optional
/// seconds in either popover or dialog mode.
class TimePicker extends StatelessWidget {
  /// The currently selected time value.
  final TimeOfDay? value;

  /// Callback invoked when the selected time changes.
  final ValueChanged<TimeOfDay?>? onChanged;

  /// The display mode for the time picker (popover or dialog).
  final PromptMode mode;

  /// Placeholder widget shown when no time is selected.
  final Widget? placeholder;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Whether to use 24-hour format.
  final bool? use24HourFormat;

  /// Whether to show seconds selection.
  final bool showSeconds;

  /// Title widget for the dialog mode.
  final Widget? dialogTitle;

  /// Whether the time picker is enabled.
  final bool? enabled;

  /// Creates a time picker.
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
    final compTheme = ComponentTheme.maybeOf<TimePickerTheme>(context);
    bool use24HourFormat = this.use24HourFormat ??
        compTheme?.use24HourFormat ??
        MediaQuery.of(context).alwaysUse24HourFormat;
    final bool showSeconds = compTheme?.showSeconds ?? this.showSeconds;
    return ObjectFormField(
      value: value,
      placeholder: placeholder ?? Text(localizations.placeholderTimePicker),
      onChanged: onChanged,
      builder: (context, value) {
        return Text(localizations.formatTimeOfDay(value,
            use24HourFormat: use24HourFormat, showSeconds: showSeconds));
      },
      enabled: enabled,
      mode: compTheme?.mode ?? mode,
      dialogTitle: dialogTitle ?? compTheme?.dialogTitle,
      popoverAlignment: popoverAlignment ?? compTheme?.popoverAlignment,
      popoverAnchorAlignment:
          popoverAnchorAlignment ?? compTheme?.popoverAnchorAlignment,
      popoverPadding: popoverPadding ?? compTheme?.popoverPadding,
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

/// Dialog widget for interactive time selection.
///
/// Displays input fields for hours, minutes, and optional seconds
/// with AM/PM toggle for 12-hour format.
class TimePickerDialog extends StatefulWidget {
  /// The initial time value.
  final TimeOfDay? initialValue;

  /// Callback invoked when the time changes.
  final ValueChanged<TimeOfDay?>? onChanged;

  /// Whether to use 24-hour format.
  final bool use24HourFormat;

  /// Whether to show seconds input.
  final bool showSeconds;

  /// Creates a time picker dialog.
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

/// Controller for managing [DurationPicker] values programmatically.
///
/// Extends `ValueNotifier<Duration?>` to provide reactive state management
/// for duration picker components. Integrates with the controlled component
/// system for external control and change notifications.
///
/// Example:
/// ```dart
/// final controller = DurationPickerController(Duration(hours: 2, minutes: 30));
/// controller.addListener(() {
///   print('Selected duration: ${controller.value}');
/// });
/// ```
class DurationPickerController extends ValueNotifier<Duration?>
    with ComponentController<Duration?> {
  /// Creates a [DurationPickerController] with an initial value.
  DurationPickerController(super.value);
}

/// Represents the parts of a duration that can be selected.
///
/// Used by [DurationPicker] to specify which time units are editable.
enum DurationPart {
  /// Day component of the duration.
  day,

  /// Hour component of the duration.
  hour,

  /// Minute component of the duration.
  minute,

  /// Second component of the duration.
  second,
}

/// Represents the parts of a time-of-day that can be selected.
///
/// Used by [TimePicker] to specify which time components are editable.
enum TimePart {
  /// Hour component (0-23 or 1-12 depending on format).
  hour,

  /// Minute component (0-59).
  minute,

  /// Second component (0-59).
  second,
}

/// Widget for picking duration values with day, hour, minute, and second components.
///
/// Provides an input interface for selecting time durations. Can be controlled
/// externally via [DurationPickerController] or used with callbacks.
///
/// Example:
/// ```dart
/// DurationPicker(
///   value: Duration(hours: 1, minutes: 30),
///   onChanged: (duration) {
///     print('Selected: $duration');
///   },
/// )
/// ```
class DurationPicker extends StatelessWidget {
  /// The currently selected duration value.
  final Duration? value;

  /// Callback invoked when the selected duration changes.
  final ValueChanged<Duration?>? onChanged;

  /// The display mode for the duration picker (popover or dialog).
  final PromptMode mode;

  /// Placeholder widget shown when no duration is selected.
  final Widget? placeholder;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title widget for the dialog mode.
  final Widget? dialogTitle;

  /// Whether the duration picker is enabled.
  final bool? enabled;

  /// Creates a duration picker.
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

/// Dialog widget for interactive duration selection.
///
/// Displays input fields for days, hours, minutes, and seconds
/// for selecting durations.
class DurationPickerDialog extends StatefulWidget {
  /// The initial duration value.
  final Duration? initialValue;

  /// Callback invoked when the duration changes.
  final ValueChanged<Duration?>? onChanged;

  /// Creates a duration picker dialog.
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

/// Represents a range of time with a start and end time.
///
/// Used to define time intervals or periods. Both [start] and [end]
/// are represented as [TimeOfDay] values.
///
/// Example:
/// ```dart
/// final workHours = TimeRange(
///   start: TimeOfDay(hour: 9, minute: 0),
///   end: TimeOfDay(hour: 17, minute: 0),
/// );
/// ```
class TimeRange {
  /// The start time of the range.
  final TimeOfDay start;

  /// The end time of the range.
  final TimeOfDay end;

  /// Creates a [TimeRange] with the specified start and end times.
  const TimeRange({
    required this.start,
    required this.end,
  });

  /// Creates a copy of this range with the given fields replaced.
  TimeRange copyWith({
    ValueGetter<TimeOfDay>? start,
    ValueGetter<TimeOfDay>? end,
  }) {
    return TimeRange(
      start: start == null ? this.start : start(),
      end: end == null ? this.end : end(),
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
