import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum CalendarViewType {
  date,
  month,
  year,
}

enum DateState {
  disabled,
  enabled,
}

typedef DateStateBuilder = DateState Function(DateTime date);

class DatePickerDialog extends StatefulWidget {
  final CalendarViewType initialViewType;
  final CalendarView? initialView;
  final CalendarSelectionMode selectionMode;
  final CalendarSelectionMode? viewMode;
  final CalendarValue? initialValue;
  final ValueChanged<CalendarValue?>? onChanged;
  final DateStateBuilder? stateBuilder;

  const DatePickerDialog({
    super.key,
    required this.initialViewType,
    this.initialView,
    required this.selectionMode,
    this.viewMode,
    this.initialValue,
    this.onChanged,
    this.stateBuilder,
  });

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late CalendarView _view;
  late CalendarView _alternateView;
  late CalendarValue? _value;
  late CalendarViewType _viewType;
  late int _yearSelectStart;
  bool _alternate = false;

  @override
  void initState() {
    super.initState();
    _view =
        widget.initialView ?? widget.initialValue?.view ?? CalendarView.now();
    _alternateView = _view.next;
    _value = widget.initialValue;
    _viewType = widget.initialViewType;
    // _yearSelectStart = round year every 16 years so that it can fit 4x4 grid
    _yearSelectStart = (_view.year ~/ 16) * 16;
  }

  String getHeaderText(ShadcnLocalizations localizations, CalendarView view,
      CalendarViewType viewType) {
    if (viewType == CalendarViewType.date) {
      return '${localizations.getMonth(view.month)} ${view.year}';
    }
    if (viewType == CalendarViewType.month) {
      return '${view.year}';
    }
    return localizations.datePickerSelectYear;
  }

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    final viewMode = widget.viewMode ?? widget.selectionMode;
    if (widget.selectionMode == CalendarSelectionMode.range) {
      return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlineButton(
                        density: ButtonDensity.icon,
                        onPressed: () {
                          setState(() {
                            switch (_viewType) {
                              case CalendarViewType.date:
                                _view = _view.previous;
                                _alternateView = _alternateView.previous;
                                break;
                              case CalendarViewType.month:
                                _view = _view.previousYear;
                                break;
                              case CalendarViewType.year:
                                _yearSelectStart -= 16;
                                break;
                            }
                          });
                        },
                        child: const Icon(LucideIcons.arrowLeft).iconXSmall(),
                      ),
                      SizedBox(
                        width: theme.scaling * 16,
                      ),
                      Expanded(
                        child: GhostButton(
                          enabled: _viewType != CalendarViewType.year,
                          onPressed: () {
                            _alternate = false;
                            switch (_viewType) {
                              case CalendarViewType.date:
                                setState(() {
                                  _viewType = CalendarViewType.month;
                                });
                                break;
                              case CalendarViewType.month:
                                setState(() {
                                  _viewType = CalendarViewType.year;
                                });
                                break;
                              default:
                                break;
                            }
                          },
                          child: Text(getHeaderText(
                                  localizations, _view, _viewType))
                              .foreground()
                              .small()
                              .medium()
                              .center(),
                        ).sized(height: theme.scaling * 32),
                      ),
                      if (_viewType == CalendarViewType.date &&
                          viewMode == CalendarSelectionMode.range)
                        SizedBox(
                          width: theme.scaling * 32,
                        ),
                      SizedBox(
                        width: theme.scaling * 16,
                      ),
                      if (_viewType != CalendarViewType.date ||
                          viewMode != CalendarSelectionMode.range)
                        OutlineButton(
                          density: ButtonDensity.icon,
                          onPressed: () {
                            setState(() {
                              switch (_viewType) {
                                case CalendarViewType.date:
                                  _view = _view.next;
                                  break;
                                case CalendarViewType.month:
                                  _view = _view.nextYear;
                                  break;
                                case CalendarViewType.year:
                                  _yearSelectStart += 16;
                                  break;
                              }
                            });
                          },
                          child:
                              const Icon(LucideIcons.arrowRight).iconXSmall(),
                        ),
                    ],
                  ),
                ),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  Gap(theme.scaling * 16),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: theme.scaling * (32 + 16),
                        ),
                        Expanded(
                          child: GhostButton(
                            onPressed: () {
                              _alternate = true;
                              switch (_viewType) {
                                case CalendarViewType.date:
                                  setState(() {
                                    _viewType = CalendarViewType.month;
                                  });
                                  break;
                                case CalendarViewType.month:
                                  setState(() {
                                    _viewType = CalendarViewType.year;
                                  });
                                  break;
                                default:
                                  break;
                              }
                            },
                            child: Text(getHeaderText(
                                    localizations, _alternateView, _viewType))
                                .foreground()
                                .small()
                                .medium()
                                .center(),
                          ).sized(height: theme.scaling * 32),
                        ),
                        SizedBox(
                          width: theme.scaling * 16,
                        ),
                        OutlineButton(
                          density: ButtonDensity.icon,
                          onPressed: () {
                            setState(() {
                              switch (_viewType) {
                                case CalendarViewType.date:
                                  _view = _view.next;
                                  _alternateView = _alternateView.next;
                                  break;
                                case CalendarViewType.month:
                                  _view = _view.nextYear;
                                  break;
                                case CalendarViewType.year:
                                  _yearSelectStart += 16;
                                  break;
                              }
                            });
                          },
                          child:
                              const Icon(LucideIcons.arrowRight).iconXSmall(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Gap(theme.scaling * 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: viewMode == CalendarSelectionMode.range
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                buildView(
                  context,
                  _yearSelectStart,
                  _view,
                  _viewType,
                  widget.selectionMode,
                  (value) {
                    setState(() {
                      if (!_alternate) {
                        _view = value;
                        _alternateView = value.next;
                      } else {
                        _view = value.previous;
                        _alternateView = value;
                      }
                      switch (_viewType) {
                        case CalendarViewType.date:
                          break;
                        case CalendarViewType.month:
                          _viewType = CalendarViewType.date;
                          break;
                        case CalendarViewType.year:
                          _viewType = CalendarViewType.month;
                          break;
                      }
                    });
                  },
                ),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  Gap(theme.scaling * 16),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  buildView(
                    context,
                    _yearSelectStart,
                    _alternateView,
                    _viewType,
                    widget.selectionMode,
                    (value) {},
                  ),
              ],
            ),
          ],
        ),
      );
    }
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {
                  setState(() {
                    switch (_viewType) {
                      case CalendarViewType.date:
                        _view = _view.previous;
                        break;
                      case CalendarViewType.month:
                        _view = _view.previousYear;
                        break;
                      case CalendarViewType.year:
                        _yearSelectStart -= 16;
                        break;
                    }
                  });
                },
                child: const Icon(LucideIcons.arrowLeft).iconXSmall(),
              ),
              SizedBox(
                width: theme.scaling * 16,
              ),
              Expanded(
                child: GhostButton(
                  enabled: _viewType != CalendarViewType.year,
                  onPressed: () {
                    switch (_viewType) {
                      case CalendarViewType.date:
                        setState(() {
                          _viewType = CalendarViewType.month;
                        });
                        break;
                      case CalendarViewType.month:
                        setState(() {
                          _viewType = CalendarViewType.year;
                        });
                        break;
                      default:
                        break;
                    }
                  },
                  child: Text(getHeaderText(localizations, _view, _viewType))
                      .foreground()
                      .small()
                      .medium()
                      .center(),
                ).sized(height: theme.scaling * 32),
              ),
              SizedBox(
                width: theme.scaling * 16,
              ),
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {
                  setState(() {
                    switch (_viewType) {
                      case CalendarViewType.date:
                        _view = _view.next;
                        break;
                      case CalendarViewType.month:
                        _view = _view.nextYear;
                        break;
                      case CalendarViewType.year:
                        _yearSelectStart += 16;
                        break;
                    }
                  });
                },
                child: const Icon(LucideIcons.arrowRight).iconXSmall(),
              ),
            ],
          ),
          Gap(theme.scaling * 16),
          buildView(
            context,
            _yearSelectStart,
            _view,
            _viewType,
            widget.selectionMode,
            (value) {
              setState(() {
                _view = value;
                switch (_viewType) {
                  case CalendarViewType.date:
                    break;
                  case CalendarViewType.month:
                    _viewType = CalendarViewType.date;
                    break;
                  case CalendarViewType.year:
                    _viewType = CalendarViewType.month;
                    break;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildView(
      BuildContext context,
      int yearSelectStart,
      CalendarView view,
      CalendarViewType viewType,
      CalendarSelectionMode selectionMode,
      ValueChanged<CalendarView> onViewChanged) {
    if (viewType == CalendarViewType.year) {
      return YearCalendar(
        value: view.year,
        yearSelectStart: yearSelectStart,
        calendarValue: _value,
        stateBuilder: widget.stateBuilder,
        onChanged: (value) {
          setState(() {
            onViewChanged(view.copyWith(year: value));
          });
        },
      );
    }
    if (viewType == CalendarViewType.month) {
      return MonthCalendar(
        value: view,
        onChanged: onViewChanged,
        stateBuilder: widget.stateBuilder,
        calendarValue: _value,
      );
    }
    return Calendar(
      value: _value,
      view: view,
      stateBuilder: widget.stateBuilder,
      onChanged: (value) {
        setState(() {
          _value = value;
          widget.onChanged?.call(value);
        });
      },
      selectionMode: selectionMode,
    );
  }
}

abstract class CalendarValue {
  CalendarValueLookup lookup(int year, [int? month = 1, int? day = 1]);
  const CalendarValue();
  static SingleCalendarValue single(DateTime date) {
    return SingleCalendarValue(date);
  }

  static RangeCalendarValue range(DateTime start, DateTime end) {
    return RangeCalendarValue(start, end);
  }

  static MultiCalendarValue multi(List<DateTime> dates) {
    return MultiCalendarValue(dates);
  }

  SingleCalendarValue toSingle();
  RangeCalendarValue toRange();
  MultiCalendarValue toMulti();

  CalendarView get view;
}

DateTime _convertNecessarry(DateTime from, int year, [int? month, int? date]) {
  if (month == null) {
    return DateTime(from.year);
  }
  if (date == null) {
    return DateTime(from.year, from.month);
  }
  return DateTime(from.year, from.month, from.day);
}

class SingleCalendarValue extends CalendarValue {
  final DateTime date;

  SingleCalendarValue(this.date);

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime current = _convertNecessarry(date, year, month, day);
    if (current.isAtSameMomentAs(DateTime(year, month ?? 1, day ?? 1))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

  @override
  CalendarView get view => date.toCalendarView();

  @override
  String toString() {
    return 'SingleCalendarValue($date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleCalendarValue && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;

  @override
  SingleCalendarValue toSingle() {
    return this;
  }

  @override
  RangeCalendarValue toRange() {
    return CalendarValue.range(date, date);
  }

  @override
  MultiCalendarValue toMulti() {
    return CalendarValue.multi([date]);
  }
}

class RangeCalendarValue extends CalendarValue {
  final DateTime start;
  final DateTime end;

  RangeCalendarValue(DateTime start, DateTime end)
      : start = start.isBefore(end) ? start : end,
        end = start.isBefore(end) ? end : start;

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime start = _convertNecessarry(this.start, year, month, day);
    DateTime end = _convertNecessarry(this.end, year, month, day);
    DateTime current = DateTime(year, month ?? 1, day ?? 1);
    if (current.isAtSameMomentAs(start) && current.isAtSameMomentAs(end)) {
      return CalendarValueLookup.selected;
    }
    if (current.isAtSameMomentAs(start)) {
      return CalendarValueLookup.start;
    }
    if (current.isAtSameMomentAs(end)) {
      return CalendarValueLookup.end;
    }
    if (current.isAfter(start) && current.isBefore(end)) {
      return CalendarValueLookup.inRange;
    }
    return CalendarValueLookup.none;
  }

  @override
  CalendarView get view => start.toCalendarView();

  @override
  String toString() {
    return 'RangedCalendarValue($start, $end)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RangeCalendarValue &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  SingleCalendarValue toSingle() {
    return CalendarValue.single(start);
  }

  @override
  RangeCalendarValue toRange() {
    return this;
  }

  @override
  MultiCalendarValue toMulti() {
    List<DateTime> dates = [];
    for (DateTime date = start;
        date.isBefore(end);
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }
    dates.add(end);
    return CalendarValue.multi(dates);
  }
}

class MultiCalendarValue extends CalendarValue {
  final List<DateTime> dates;

  MultiCalendarValue(this.dates);

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime current = DateTime(year, month ?? 1, day ?? 1);
    if (dates.any((element) => _convertNecessarry(element, year, month, day)
        .isAtSameMomentAs(current))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

  @override
  CalendarView get view =>
      dates.firstOrNull?.toCalendarView() ?? CalendarView.now();

  @override
  String toString() {
    return 'MultiCalendarValue($dates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MultiCalendarValue && listEquals(other.dates, dates);
  }

  @override
  int get hashCode => dates.hashCode;

  @override
  SingleCalendarValue toSingle() {
    return CalendarValue.single(dates.first);
  }

  @override
  RangeCalendarValue toRange() {
    assert(dates.isNotEmpty, 'Cannot convert empty list to range');
    DateTime min = dates
        .reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime max = dates
        .reduce((value, element) => value.isAfter(element) ? value : element);
    return CalendarValue.range(min, max);
  }

  @override
  MultiCalendarValue toMulti() {
    return this;
  }
}

enum CalendarValueLookup { none, selected, start, end, inRange }

class CalendarView {
  final int year;
  final int month;

  CalendarView(this.year, this.month) {
    assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');
  }
  factory CalendarView.now() {
    DateTime now = DateTime.now();
    return CalendarView(now.year, now.month);
  }
  factory CalendarView.fromDateTime(DateTime dateTime) {
    return CalendarView(dateTime.year, dateTime.month);
  }

  CalendarView get next {
    if (month == 12) {
      return CalendarView(year + 1, 1);
    }
    return CalendarView(year, month + 1);
  }

  CalendarView get previous {
    if (month == 1) {
      return CalendarView(year - 1, 12);
    }
    return CalendarView(year, month - 1);
  }

  CalendarView get nextYear {
    return CalendarView(year + 1, month);
  }

  CalendarView get previousYear {
    return CalendarView(year - 1, month);
  }

  @override
  String toString() {
    return 'CalendarView($year, $month)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarView && other.year == year && other.month == month;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode;

  CalendarView copyWith({
    int? year,
    int? month,
  }) {
    return CalendarView(
      year ?? this.year,
      month ?? this.month,
    );
  }
}

extension CalendarDateTime on DateTime {
  CalendarView toCalendarView() {
    return CalendarView.fromDateTime(this);
  }

  CalendarValue toCalendarValue() {
    return CalendarValue.single(this);
  }
}

enum CalendarSelectionMode {
  none,
  single,
  range,
  multi,
}

class Calendar extends StatefulWidget {
  final DateTime? now;
  final CalendarValue? value;
  final CalendarView view;
  final CalendarSelectionMode selectionMode;
  final ValueChanged<CalendarValue?>? onChanged;
  final bool Function(DateTime date)? isDateEnabled;
  final DateStateBuilder? stateBuilder;

  const Calendar({
    super.key,
    this.now,
    this.value,
    required this.view,
    required this.selectionMode,
    this.onChanged,
    this.isDateEnabled,
    this.stateBuilder,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarGridData _gridData;

  @override
  void initState() {
    super.initState();
    _gridData =
        CalendarGridData(month: widget.view.month, year: widget.view.year);
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view.year != widget.view.year ||
        oldWidget.view.month != widget.view.month) {
      _gridData =
          CalendarGridData(month: widget.view.month, year: widget.view.year);
    }
  }

  void _handleTap(DateTime date) {
    var calendarValue = widget.value;
    if (widget.selectionMode == CalendarSelectionMode.none) {
      return;
    }
    if (widget.selectionMode == CalendarSelectionMode.single) {
      if (calendarValue is SingleCalendarValue &&
          date.isAtSameMomentAs(calendarValue.date)) {
        widget.onChanged?.call(null);
        return;
      }
      widget.onChanged?.call(CalendarValue.single(date));
      return;
    }
    if (widget.selectionMode == CalendarSelectionMode.multi) {
      if (calendarValue == null) {
        widget.onChanged?.call(CalendarValue.single(date));
        return;
      }
      final lookup = calendarValue.lookup(date.year, date.month, date.day);
      if (lookup == CalendarValueLookup.none) {
        var multi = calendarValue.toMulti();
        (multi).dates.add(date);
        widget.onChanged?.call(multi);
        return;
      } else {
        var multi = calendarValue.toMulti();
        (multi).dates.remove(date);
        if (multi.dates.isEmpty) {
          widget.onChanged?.call(null);
          return;
        }
        widget.onChanged?.call(multi);
        return;
      }
    }
    if (widget.selectionMode == CalendarSelectionMode.range) {
      if (calendarValue == null) {
        widget.onChanged?.call(CalendarValue.single(date));
        return;
      }
      if (calendarValue is MultiCalendarValue) {
        calendarValue = calendarValue.toRange();
      }
      if (calendarValue is SingleCalendarValue) {
        DateTime selectedDate = calendarValue.date;
        if (date.isAtSameMomentAs(selectedDate)) {
          widget.onChanged?.call(null);
          return;
        }
        widget.onChanged?.call(CalendarValue.range(selectedDate, date));
        return;
      }
      if (calendarValue is RangeCalendarValue) {
        DateTime start = calendarValue.start;
        DateTime end = calendarValue.end;
        if (date.isBefore(start)) {
          widget.onChanged?.call(CalendarValue.range(date, end));
          return;
        }
        if (date.isAfter(end)) {
          widget.onChanged?.call(CalendarValue.range(start, date));
          return;
        }
        if (date.isAtSameMomentAs(start)) {
          widget.onChanged?.call(null);
          return;
        }
        if (date.isAtSameMomentAs(end)) {
          widget.onChanged?.call(CalendarValue.single(end));
          return;
        }
        widget.onChanged?.call(CalendarValue.range(start, date));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalendarGrid(
      data: _gridData,
      itemBuilder: (item) {
        DateTime date = item.date;
        CalendarValueLookup lookup =
            widget.value?.lookup(date.year, date.month, date.day) ??
                CalendarValueLookup.none;
        CalendarItemType type = CalendarItemType.none;
        switch (lookup) {
          case CalendarValueLookup.none:
            if (widget.now != null && widget.now!.isAtSameMomentAs(date)) {
              type = CalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = CalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = CalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = CalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = CalendarItemType.inRange;
            break;
        }
        Widget calendarItem = CalendarItem(
          type: type,
          indexAtRow: item.indexInRow,
          rowCount: 7,
          onTap: () {
            _handleTap(date);
          },
          state: widget.stateBuilder?.call(date) ?? DateState.enabled,
          child: Text('${date.day}'),
        );
        if (item.fromAnotherMonth) {
          return Opacity(
            opacity: 0.5,
            child: calendarItem,
          );
        }
        return calendarItem;
      },
    );
  }
}

class MonthCalendar extends StatelessWidget {
  final CalendarView value;
  final ValueChanged<CalendarView> onChanged;
  final DateTime? now;
  final CalendarValue? calendarValue;
  final DateStateBuilder? stateBuilder;

  const MonthCalendar({
    super.key,
    required this.value,
    required this.onChanged,
    this.now,
    this.calendarValue,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // same as Calendar, but instead of showing date
    // it shows month in a 4x3 grid
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    List<Widget> rows = [];
    List<Widget> months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime date = DateTime(value.year, i);
      CalendarItemType type = CalendarItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue!.lookup(date.year, date.month);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null &&
                DateTime(now!.year, now!.month).isAtSameMomentAs(date)) {
              type = CalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = CalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = CalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = CalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = CalendarItemType.inRange;
            break;
        }
      } else {
        if (now != null &&
            DateTime(now!.year, now!.month).isAtSameMomentAs(date)) {
          type = CalendarItemType.today;
        }
      }
      months.add(
        CalendarItem(
          key: ValueKey(date),
          type: type,
          indexAtRow: (i - 1) % 4,
          rowCount: 4,
          onTap: () {
            onChanged(value.copyWith(month: i));
          },
          width: theme.scaling * 56,
          state: stateBuilder?.call(date) ?? DateState.enabled,
          child: Text(localizations.getAbbreviatedMonth(i)),
        ),
      );
    }
    for (int i = 0; i < months.length; i += 4) {
      rows.add(Gap(theme.scaling * 8));
      rows.add(Row(
        children: months.sublist(i, i + 4),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

class YearCalendar extends StatelessWidget {
  final int yearSelectStart;
  final int value;
  final ValueChanged<int> onChanged;
  final DateTime? now;
  final CalendarValue? calendarValue;
  final DateStateBuilder? stateBuilder;

  const YearCalendar({
    super.key,
    required this.yearSelectStart,
    required this.value,
    required this.onChanged,
    this.now,
    this.calendarValue,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // same as Calendar, but instead of showing date
    // it shows year in a 4x4 grid
    List<Widget> rows = [];
    List<Widget> years = [];
    for (int i = yearSelectStart; i < yearSelectStart + 16; i++) {
      DateTime date = DateTime(i);
      CalendarItemType type = CalendarItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue!.lookup(date.year);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null && now!.year == date.year) {
              type = CalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = CalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = CalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = CalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = CalendarItemType.inRange;
            break;
        }
      } else {
        if (now != null && now!.year == date.year) {
          type = CalendarItemType.today;
        }
      }
      years.add(
        CalendarItem(
          key: ValueKey(date),
          type: type,
          indexAtRow: (i - yearSelectStart) % 4,
          rowCount: 4,
          onTap: () {
            onChanged(i);
          },
          width: theme.scaling * 56,
          state: stateBuilder?.call(date) ?? DateState.enabled,
          child: Text('$i'),
        ),
      );
    }
    for (int i = 0; i < years.length; i += 4) {
      rows.add(Gap(theme.scaling * 8));
      rows.add(Row(
        children: years.sublist(i, i + 4),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

enum CalendarItemType {
  none,
  today,
  selected,
  // when its the date in the range
  inRange,
  startRange, // same as startRangeSelected, but used for other months
  endRange, // same as endRangeSelected, but used for other months
  startRangeSelected,
  endRangeSelected,
  startRangeSelectedShort,
  endRangeSelectedShort, // usually when the range are just 2 days
  inRangeSelectedShort,
}

class CalendarItem extends StatelessWidget {
  final Widget child;
  final CalendarItemType type;
  final VoidCallback? onTap;
  final int indexAtRow;
  final int rowCount;
  final double? width;
  final double? height;
  final DateState state;

  const CalendarItem({
    super.key,
    required this.child,
    required this.type,
    required this.indexAtRow,
    required this.rowCount,
    this.onTap,
    this.width,
    this.height,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var type = this.type;
    if ((indexAtRow == 0 || indexAtRow == rowCount - 1) &&
        (type == CalendarItemType.startRangeSelected ||
            type == CalendarItemType.endRangeSelected ||
            type == CalendarItemType.startRangeSelectedShort ||
            type == CalendarItemType.endRangeSelectedShort)) {
      type = CalendarItemType.selected;
    }
    switch (type) {
      case CalendarItemType.none:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: GhostButton(
            density: ButtonDensity.compact,
            alignment: Alignment.center,
            enabled: state == DateState.enabled,
            onPressed: onTap,
            child: child,
          ),
        );
      case CalendarItemType.today:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: SecondaryButton(
            density: ButtonDensity.compact,
            alignment: Alignment.center,
            enabled: state == DateState.enabled,
            onPressed: onTap,
            child: child,
          ),
        );
      case CalendarItemType.selected:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: PrimaryButton(
            density: ButtonDensity.compact,
            alignment: Alignment.center,
            enabled: state == DateState.enabled,
            onPressed: onTap,
            child: child,
          ),
        );
      case CalendarItemType.inRange:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Button(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == DateState.enabled,
            style: const ButtonStyle(
              variance: ButtonVariance.secondary,
              density: ButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: indexAtRow == 0
                      ? BorderRadius.only(
                          topLeft: Radius.circular(theme.radiusMd),
                          bottomLeft: Radius.circular(theme.radiusMd),
                        )
                      : indexAtRow == rowCount - 1
                          ? BorderRadius.only(
                              topRight: Radius.circular(theme.radiusMd),
                              bottomRight: Radius.circular(theme.radiusMd),
                            )
                          : BorderRadius.zero,
                );
              },
            ),
            child: child,
          ),
        );
      case CalendarItemType.startRange:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Button(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == DateState.enabled,
            style: const ButtonStyle(
              variance: ButtonVariance.secondary,
              density: ButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case CalendarItemType.endRange:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Button(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == DateState.enabled,
            style: const ButtonStyle(
              variance: ButtonVariance.secondary,
              density: ButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case CalendarItemType.startRangeSelected:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: width ?? theme.scaling * 32,
                height: height ?? theme.scaling * 32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                ),
              ),
              PrimaryButton(
                density: ButtonDensity.compact,
                alignment: Alignment.center,
                enabled: state == DateState.enabled,
                onPressed: onTap,
                child: child,
              ),
            ],
          ),
        );
      case CalendarItemType.endRangeSelected:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: width ?? theme.scaling * 32,
                height: height ?? theme.scaling * 32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                ),
              ),
              PrimaryButton(
                density: ButtonDensity.compact,
                alignment: Alignment.center,
                enabled: state == DateState.enabled,
                onPressed: onTap,
                child: child,
              ),
            ],
          ),
        );
      case CalendarItemType.startRangeSelectedShort:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Button(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == DateState.enabled,
            style: const ButtonStyle(
              variance: ButtonVariance.primary,
              density: ButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case CalendarItemType.endRangeSelectedShort:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Button(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == DateState.enabled,
            style: const ButtonStyle(
              variance: ButtonVariance.primary,
              density: ButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case CalendarItemType.inRangeSelectedShort:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Button(
            alignment: Alignment.center,
            enabled: state == DateState.enabled,
            onPressed: onTap,
            style: const ButtonStyle(
              variance: ButtonVariance.primary,
              density: ButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.zero,
                );
              },
            ),
            child: child,
          ),
        );
    }
  }
}

class CalendarGridData {
  final int month;
  final int year;
  final List<CalendarGridItem> items;

  factory CalendarGridData({required int month, required int year}) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month == 12 ? 1 : month + 1, 0).day;

    int prevMonthDays = firstDayOfMonth.weekday;
    DateTime prevMonthLastDay =
        firstDayOfMonth.subtract(Duration(days: prevMonthDays));

    List<CalendarGridItem> items = [];

    int itemCount = 0;

    if (prevMonthDays < 7) {
      for (int i = 0; i < prevMonthDays; i++) {
        int currentItemIndex = itemCount++;
        items.add(CalendarGridItem(
          prevMonthLastDay.add(Duration(days: i)),
          currentItemIndex % 7,
          true,
          currentItemIndex ~/ 7,
        ));
      }
    }

    for (int i = 0; i < daysInMonth; i++) {
      int currentItemIndex = itemCount++;
      DateTime currentDay = DateTime(year, month, i + 1);
      items.add(CalendarGridItem(
        currentDay,
        currentItemIndex % 7,
        false,
        currentItemIndex ~/ 7,
      ));
    }

    int remainingDays = (7 - (items.length % 7)) % 7;
    DateTime nextMonthFirstDay = DateTime(year, month + 1, 1);

    if (remainingDays < 7) {
      for (int i = 0; i < remainingDays; i++) {
        int currentItemIndex = itemCount++;
        items.add(CalendarGridItem(
          nextMonthFirstDay.add(Duration(days: i)),
          currentItemIndex % 7,
          true,
          currentItemIndex ~/ 7,
        ));
      }
    }

    return CalendarGridData._(month, year, items);
  }

  CalendarGridData._(this.month, this.year, this.items);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarGridData &&
        other.month == month &&
        other.year == year &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hash(month, year, items);
}

class CalendarGridItem {
  final DateTime date;
  final int indexInRow;
  final int rowIndex;
  final bool fromAnotherMonth;

  CalendarGridItem(
      this.date, this.indexInRow, this.fromAnotherMonth, this.rowIndex);

  bool get isToday {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarGridItem &&
        other.date.isAtSameMomentAs(date) &&
        other.indexInRow == indexInRow &&
        other.fromAnotherMonth == fromAnotherMonth &&
        other.rowIndex == rowIndex;
  }

  @override
  int get hashCode => Object.hash(date, indexInRow, fromAnotherMonth, rowIndex);
}

class CalendarGrid extends StatelessWidget {
  final CalendarGridData data;
  final Widget Function(CalendarGridItem item) itemBuilder;

  const CalendarGrid({
    super.key,
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
    // return GridView.builder(
    //   shrinkWrap: true,
    //   itemCount: data.items.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 7,
    //     mainAxisSpacing: 0,
    //     crossAxisSpacing: 8 * theme.scaling,
    //   ),
    //   itemBuilder: (context, index) {
    //     return SizedBox(
    //       width: theme.scaling * 32,
    //       height: theme.scaling * 32,
    //       child: itemBuilder(data.items[index]),
    //     );
    //   },
    // );
    // do not use GridView because it doesn't support IntrinsicWidth
    List<Widget> rows = [];
    List<Widget> weekDays = [];
    for (int i = 0; i < 7; i++) {
      int weekday = ((i - 1) % 7) + 1;
      weekDays.add(
        Container(
          width: theme.scaling * 32,
          height: theme.scaling * 32,
          alignment: Alignment.center,
          child: Text(localizations.getAbbreviatedWeekday(weekday))
              .muted()
              .xSmall(),
        ),
      );
    }
    rows.add(Row(
      mainAxisSize: MainAxisSize.min,
      children: weekDays,
    ));
    for (int i = 0; i < data.items.length; i += 7) {
      rows.add(Row(
        children: data.items.sublist(i, i + 7).map((e) {
          return SizedBox(
            width: theme.scaling * 32,
            height: theme.scaling * 32,
            child: itemBuilder(e),
          );
        }).toList(),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: theme.scaling * 8,
      children: rows,
    );
  }
}
