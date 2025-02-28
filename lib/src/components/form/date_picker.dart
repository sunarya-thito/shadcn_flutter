import 'package:flutter/foundation.dart';

import '../../../shadcn_flutter.dart';

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
  final PromptMode mode;
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
    return ControlledComponentBuilder(
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
  final PromptMode mode;
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
    this.mode = PromptMode.dialog,
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
    return ObjectFormField(
      dialogTitle: dialogTitle,
      enabled: enabled,
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
      editorBuilder: (context, handler) {
        return DatePickerDialog(
          initialView: initialView ?? CalendarView.now(),
          initialViewType: initialViewType ?? CalendarViewType.date,
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

class _DateInputState extends State<DateInput> {
  static double _getPartWidth(DatePart part) {
    switch (part) {
      case DatePart.year:
        return 60;
      case DatePart.month:
        return 40;
      case DatePart.day:
        return 40;
    }
  }

  final Map<DatePart, int> _values = {};

  final _popoverController = PopoverController();
  FormattedInputController? _formattedInputController;
  List<DatePart>? _datePartOrders;

  @override
  void initState() {
    super.initState();
    var initialValue = widget.initialValue;
    if (initialValue != null) {
      _values[DatePart.year] = initialValue.year;
      _values[DatePart.month] = initialValue.month;
      _values[DatePart.day] = initialValue.day;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var localizations = ShadcnLocalizations.of(context);
    var newDatePartOrders =
        widget.datePartsOrder ?? localizations.datePartsOrder;
    if (!listEquals(newDatePartOrders, _datePartOrders)) {
      var oldValue = _formattedInputController?.value;
      _datePartOrders = newDatePartOrders;
      var newFormattedInputController =
          FormattedInputController(FormattedValue([
        for (int i = 0; i < newDatePartOrders.length; i++) ...[
          if (i > 0) widget.separator ?? const InputPart.static('/'),
          InputPart.editable(
            length: newDatePartOrders[i].length,
            width: _getPartWidth(newDatePartOrders[i]),
            inputFormatters: [
              TextInputFormatters.datePart(_values, newDatePartOrders[i]),
            ],
            placeholder: widget.placeholders?[newDatePartOrders[i]] ??
                Text(localizations.datePartPlaceholder(newDatePartOrders[i])),
          ).withValue(oldValue?.parts.optGet(i)?.value ??
              (_values[newDatePartOrders[i]]?.toString() ?? '')
                  .padLeft(newDatePartOrders[i].length, '0')),
        ]
      ]));
      _formattedInputController?.dispose();
      _formattedInputController = newFormattedInputController;
      _formattedInputController!.addListener(_onFormattedInputChanged);
    }
  }

  void _onFormattedInputChanged() {
    var formattedValue = _formattedInputController!.value;
    if (formattedValue == null) {
      return;
    }
    List<FormattedValuePart> parts = formattedValue.parts;
    if (parts.isEmpty) {
      return;
    }
    for (int i = 0; i < _datePartOrders!.length; i++) {
      var source = parts[i].value;
      if (source == null || source.isEmpty) {
        _values.remove(_datePartOrders![i]);
        return;
      }
      int? partValue = int.tryParse(source);
      if (partValue == null) {
        _values.remove(_datePartOrders![i]);
        return;
      }
      _values[_datePartOrders![i]] = partValue;
    }
  }

  void _openPopover() {
    var theme = Theme.of(context);
    int? year = _values[DatePart.year];
    int? month = _values[DatePart.month];
    int? day = _values[DatePart.day];
    CalendarValue? initialValue;
    if (year != null && month != null && day != null) {
      initialValue = CalendarValue.single(DateTime(year, month, day));
    }
    _popoverController.show(
      context: context,
      alignment: widget.popoverAlignment ?? Alignment.topLeft,
      anchorAlignment: widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
      offset: const Offset(0, 4) * theme.scaling,
      builder: (context) {
        return SurfaceCard(
          child: DatePickerDialog(
            initialView:
                widget.initialView ?? initialValue?.view ?? CalendarView.now(),
            initialViewType: widget.initialViewType ?? CalendarViewType.date,
            selectionMode: CalendarSelectionMode.single,
            initialValue: initialValue,
            onChanged: (value) {
              if (value == null) {
                return;
              }
              final date = (value as SingleCalendarValue).date;
              _values[DatePart.year] = date.year;
              _values[DatePart.month] = date.month;
              _values[DatePart.day] = date.day;
              List<FormattedValuePart> parts = [];
              var datePartsOrder = widget.datePartsOrder ??
                  ShadcnLocalizations.of(context).datePartsOrder;
              for (var i = 0; i < datePartsOrder.length; i++) {
                parts.add(_formattedInputController!.value!.parts[i].withValue(
                    _values[datePartsOrder[i]]
                        .toString()
                        .padLeft(datePartsOrder[i].length, '0')));
              }
              _formattedInputController!.value = FormattedValue(parts);
            },
            stateBuilder: widget.stateBuilder,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _formattedInputController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    final datePartsOrder =
        widget.datePartsOrder ?? localizations.datePartsOrder;
    return FormattedInput(
      controller: _formattedInputController,
      onChanged: (value) {
        if (value == null || value.values.isEmpty) {
          return;
        }
        for (int i = 0; i < datePartsOrder.length; i++) {
          var source = value[i]?.value;
          if (source == null || source.isEmpty) {
            _values.remove(datePartsOrder[i]);
            continue;
          }
          int? partValue = int.tryParse(source);
          if (partValue == null) {
            _values.remove(datePartsOrder[i]);
            continue;
          }
          _values[datePartsOrder[i]] = partValue;
        }
      },
      trailing: ListenableBuilder(
        listenable: _popoverController,
        builder: (context, child) {
          return WidgetStatesProvider(
            states: {
              if (_popoverController.hasOpenPopover) WidgetState.hovered,
            },
            child: child!,
          );
        },
        child: IconButton.text(
          icon: const Icon(Icons.calendar_month),
          onPressed: _openPopover,
        ),
      ),
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
      trailing: const Icon(Icons.calendar_month),
      builder: (context, value) {
        return Text(
            '${localizations.formatDateTime(value.start, showTime: false)} - ${localizations.formatDateTime(value.end, showTime: false)}');
      },
      editorBuilder: (context, handler) {
        DateTimeRange? value = handler.value;
        return LayoutBuilder(builder: (context, constraints) {
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
        });
      },
    );
  }
}
