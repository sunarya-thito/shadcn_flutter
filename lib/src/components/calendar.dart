import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DatePickerDialog extends StatefulWidget {
  final CalendarView initialView;
  final CalendarSelectionMode selectionMode;
  final CalendarValue? initialValue;
  final ValueChanged<CalendarValue?>? onChanged;
  final bool Function(DateTime date)? isDateEnabled;
  final Widget? Function(BuildContext context, DateTime date)? dateBuilder;
  final Widget? Function(BuildContext context, int weekday)? weekDayBuilder;

  const DatePickerDialog({
    super.key,
    required this.initialView,
    required this.selectionMode,
    this.initialValue,
    this.onChanged,
    this.isDateEnabled,
    this.dateBuilder,
    this.weekDayBuilder,
  });

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late CalendarView _view;
  late CalendarValue? _value;

  @override
  void initState() {
    super.initState();
    _view = widget.initialView;
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    if (widget.selectionMode == CalendarSelectionMode.range) {
      return Card(
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        OutlineButton(
                          padding: Button.iconPadding,
                          onPressed: () {
                            setState(() {
                              _view = _view.previous;
                            });
                          },
                          child: Icon(Icons.arrow_back).iconXSmall(),
                        ),
                        Text('${localizations.getMonth(_view.month)} ${_view.year}')
                            .small()
                            .medium()
                            .center()
                            .expanded(),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        Text('${localizations.getMonth(_view.next.month)} ${_view.next.year}')
                            .small()
                            .medium()
                            .center()
                            .expanded(),
                        OutlineButton(
                          padding: Button.iconPadding,
                          onPressed: () {
                            setState(() {
                              _view = _view.next;
                            });
                          },
                          child: Icon(Icons.arrow_forward).iconXSmall(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              gap(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Calendar(
                    value: _value,
                    view: _view,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        widget.onChanged?.call(value);
                      });
                    },
                    selectionMode: CalendarSelectionMode.range,
                  ),
                  gap(16),
                  Calendar(
                    value: _value,
                    view: _view.next,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        widget.onChanged?.call(value);
                      });
                    },
                    selectionMode: CalendarSelectionMode.range,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                OutlineButton(
                  padding: Button.iconPadding,
                  onPressed: () {
                    setState(() {
                      _view = _view.previous;
                    });
                  },
                  child: Icon(Icons.arrow_back).iconXSmall(),
                ),
                Text('${localizations.getMonth(_view.month)} ${_view.year}')
                    .small()
                    .medium()
                    .center()
                    .expanded(),
                OutlineButton(
                  padding: Button.iconPadding,
                  onPressed: () {
                    setState(() {
                      _view = _view.next;
                    });
                  },
                  child: Icon(Icons.arrow_forward).iconXSmall(),
                ),
              ],
            ),
            gap(16),
            Calendar(
              value: _value,
              view: _view,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  widget.onChanged?.call(value);
                });
              },
              selectionMode: CalendarSelectionMode.single,
            ),
          ],
        ),
      ),
    );
  }
}

abstract class CalendarValue {
  CalendarValueLookup lookup(DateTime date);
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
}

class SingleCalendarValue extends CalendarValue {
  final DateTime date;

  SingleCalendarValue(this.date);

  @override
  CalendarValueLookup lookup(DateTime date) {
    if (_isSameDay(this.date, date)) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

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
  CalendarValueLookup lookup(DateTime date) {
    if (_isSameDay(start, date)) {
      return CalendarValueLookup.start;
    }
    if (_isSameDay(end, date)) {
      return CalendarValueLookup.end;
    }
    if (_isInRange(date, start, end)) {
      return CalendarValueLookup.inRange;
    }
    return CalendarValueLookup.none;
  }

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
  CalendarValueLookup lookup(DateTime date) {
    if (dates.any((d) => _isSameDay(d, date))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

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

class Calendar extends StatelessWidget {
  final DateTime? now;
  final CalendarValue? value;
  final CalendarView view;
  final CalendarSelectionMode selectionMode;
  final ValueChanged<CalendarValue?>? onChanged;
  final bool Function(DateTime date)? isDateEnabled;
  final Widget? Function(BuildContext context, DateTime date)? dateBuilder;
  final Widget? Function(BuildContext context, int weekday)? weekDayBuilder;

  const Calendar({
    super.key,
    this.now,
    this.value,
    required this.view,
    required this.selectionMode,
    this.onChanged,
    this.isDateEnabled,
    this.dateBuilder,
    this.weekDayBuilder,
  });

  void _handleTap(DateTime date) {
    var calendarValue = value;
    if (selectionMode == CalendarSelectionMode.none) {
      return;
    }
    if (selectionMode == CalendarSelectionMode.single) {
      if (calendarValue is SingleCalendarValue &&
          _isSameDay(date, calendarValue.date)) {
        onChanged?.call(null);
        return;
      }
      onChanged?.call(CalendarValue.single(date));
      return;
    }
    if (selectionMode == CalendarSelectionMode.multi) {
      if (calendarValue == null) {
        onChanged?.call(CalendarValue.single(date));
        return;
      }
      final lookup = calendarValue.lookup(date);
      if (lookup == CalendarValueLookup.none) {
        var multi = calendarValue.toMulti();
        (multi as MultiCalendarValue).dates.add(date);
        onChanged?.call(multi);
        return;
      } else {
        var multi = calendarValue.toMulti();
        (multi as MultiCalendarValue).dates.remove(date);
        if (multi.dates.isEmpty) {
          onChanged?.call(null);
          return;
        }
        onChanged?.call(multi);
        return;
      }
    }
    if (selectionMode == CalendarSelectionMode.range) {
      if (calendarValue == null) {
        onChanged?.call(CalendarValue.single(date));
        return;
      }
      if (calendarValue is MultiCalendarValue) {
        calendarValue = calendarValue.toRange();
      }
      if (calendarValue is SingleCalendarValue) {
        DateTime selectedDate = calendarValue.date;
        if (_isSameDay(date, selectedDate)) {
          onChanged?.call(null);
          return;
        }
        onChanged?.call(CalendarValue.range(selectedDate, date));
        return;
      }
      if (calendarValue is RangeCalendarValue) {
        DateTime start = calendarValue.start;
        DateTime end = calendarValue.end;
        if (date.isBefore(start)) {
          onChanged?.call(CalendarValue.range(date, end));
          return;
        }
        if (date.isAfter(end)) {
          onChanged?.call(CalendarValue.range(start, date));
          return;
        }
        if (_isSameDay(date, start)) {
          onChanged?.call(null);
          return;
        }
        if (_isSameDay(date, end)) {
          onChanged?.call(CalendarValue.single(end));
          return;
        }
        onChanged?.call(CalendarValue.range(start, date));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // since the calendar grid starts from sunday
    // theres a lot of stuff that needs to be tweaked
    // since dart DateTime starts from monday
    final calendarValue = value;
    int weekDayStart = (DateTime(view.year, view.month).weekday + 1);
    int daysInMonth = DateTime(view.year, view.month + 1, 0).day;
    ShadcnLocalizations localizations =
        Localizations.of(context, ShadcnLocalizations);
    List<Widget> rows = [];
    // Weekdays Row
    List<Widget> weekDays = [];
    for (int i = 0; i < 7; i++) {
      int weekday = ((i - 1) % 7) + 1;
      weekDays.add(
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: weekDayBuilder?.call(context, weekday) ??
              Text(localizations.getAbbreviatedWeekday(weekday))
                  .muted()
                  .xSmall(),
        ),
      );
    }
    rows.add(Row(
      children: weekDays,
    ));
    // Days
    List<Widget> days = [];
    // reduce the amount of unnecessary rows
    while (weekDayStart > 7) {
      weekDayStart -= 7;
    }
    // start from the first day of the week
    for (int i = 1; i < weekDayStart; i++) {
      int previousMonthDay = daysInMonth - (weekDayStart - i);
      var dateTime = DateTime(view.year, view.month - 1, previousMonthDay);
      int indexAtRow = i - 1;
      _DateItemType type = _DateItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue.lookup(dateTime);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null && _isSameDay(now!, dateTime)) {
              type = _DateItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = _DateItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = _DateItemType.startRange;
            break;
          case CalendarValueLookup.end:
            type = _DateItemType.endRange;
            break;
          case CalendarValueLookup.inRange:
            type = _DateItemType.inRange;
            break;
        }
      } else {
        if (now != null && _isSameDay(now!, dateTime)) {
          type = _DateItemType.today;
        }
      }
      days.add(Hero(
        tag: _HeroDateTime(dateTime),
        child: dateBuilder?.call(
              context,
              dateTime,
            ) ??
            Opacity(
              opacity: 0.5,
              child: _DateItem(
                key: ValueKey(dateTime),
                day: previousMonthDay,
                type: type,
                indexAtRow: indexAtRow,
                onTap: () {
                  _handleTap(dateTime);
                },
              ),
            ),
      ));
    }
    // then the days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(view.year, view.month, i);
      _DateItemType type = _DateItemType.none;
      int indexAtRow = (weekDayStart + i - 2) % 7;
      if (calendarValue != null) {
        final lookup = calendarValue.lookup(date);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null && _isSameDay(now!, date)) {
              type = _DateItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = _DateItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = _DateItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = _DateItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = _DateItemType.inRange;
            break;
        }
      } else {
        if (now != null && _isSameDay(now!, date)) {
          type = _DateItemType.today;
        }
      }
      days.add(Hero(
        tag: _HeroDateTime(date),
        child: dateBuilder?.call(context, date) ??
            _DateItem(
              key: ValueKey(date),
              day: i,
              type: type,
              indexAtRow: indexAtRow,
              onTap: () {
                if (isDateEnabled?.call(date) ?? true) {
                  _handleTap(date);
                }
              },
            ),
      ));
    }
    // actual needed rows
    int neededRows = (days.length / 7).ceil();
    // then fill the rest of the row with the next month
    int totalDaysGrid = 7 * neededRows; // 42
    var length = days.length;
    for (int i = length; i < totalDaysGrid; i++) {
      int nextMonthDay = i - length + 1;
      var dateTime = DateTime(view.year, view.month + 1, nextMonthDay);
      int indexAtRow = i % 7;
      _DateItemType type = _DateItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue.lookup(dateTime);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null && _isSameDay(now!, dateTime)) {
              type = _DateItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = _DateItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = _DateItemType.startRange;
            break;
          case CalendarValueLookup.end:
            type = _DateItemType.endRange;
            break;
          case CalendarValueLookup.inRange:
            type = _DateItemType.inRange;
            break;
        }
      } else {
        if (now != null && _isSameDay(now!, dateTime)) {
          type = _DateItemType.today;
        }
      }
      days.add(Hero(
          tag: _HeroDateTime(dateTime),
          child: dateBuilder?.call(context, dateTime) ??
              Opacity(
                opacity: 0.5,
                child: _DateItem(
                  day: nextMonthDay,
                  type: type,
                  indexAtRow: indexAtRow,
                  onTap: () {
                    _handleTap(dateTime);
                  },
                ),
              )));
    }
    // split the days into rows
    for (int i = 0; i < days.length; i += 7) {
      // there won't be any array out of bounds error
      // because we made sure that the total days is 42
      rows.add(gap(8));
      rows.add(Row(
        children: days.sublist(i, i + 7),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

class _HeroDateTime {
  final DateTime date;

  _HeroDateTime(this.date);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _HeroDateTime && _isSameDay(other.date, date);
  }

  @override
  int get hashCode {
    return date.year ^ date.month ^ date.day;
  }
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool _isInRange(DateTime date, DateTime start, DateTime end) {
  return date.isAfter(start) && date.isBefore(end);
}

enum _DateItemType {
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

class _DateItem extends StatelessWidget {
  final int day;
  final _DateItemType type;
  final VoidCallback? onTap;
  final int indexAtRow;

  const _DateItem({
    super.key,
    required this.day,
    required this.type,
    required this.indexAtRow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    switch (type) {
      case _DateItemType.none:
        return SizedBox(
          width: 32,
          height: 32,
          child: GhostButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.today:
        return SizedBox(
          width: 32,
          height: 32,
          child: SecondaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.selected:
        return SizedBox(
          width: 32,
          height: 32,
          child: PrimaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.inRange:
        return SizedBox(
          width: 32,
          height: 32,
          child: SecondaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            borderRadius: indexAtRow == 0
                ? BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  )
                : indexAtRow == 6
                    ? BorderRadius.only(
                        topRight: Radius.circular(theme.radiusMd),
                        bottomRight: Radius.circular(theme.radiusMd),
                      )
                    : BorderRadius.zero,
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.startRange:
        return SizedBox(
          width: 32,
          height: 32,
          child: SecondaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(theme.radiusMd),
              bottomLeft: Radius.circular(theme.radiusMd),
            ),
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.endRange:
        return SizedBox(
          width: 32,
          height: 32,
          child: SecondaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(theme.radiusMd),
              bottomRight: Radius.circular(theme.radiusMd),
            ),
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.startRangeSelected:
        return SizedBox(
          width: 32,
          height: 32,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                ),
              ),
              PrimaryButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: onTap,
                child: Text(
                  '$day',
                ),
              ),
            ],
          ),
        );
      case _DateItemType.endRangeSelected:
        return SizedBox(
          width: 32,
          height: 32,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                ),
              ),
              PrimaryButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: onTap,
                child: Text(
                  '$day',
                ),
              ),
            ],
          ),
        );
      case _DateItemType.startRangeSelectedShort:
        return SizedBox(
          width: 32,
          height: 32,
          child: PrimaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(theme.radiusMd),
              bottomLeft: Radius.circular(theme.radiusMd),
            ),
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.endRangeSelectedShort:
        return SizedBox(
          width: 32,
          height: 32,
          child: PrimaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(theme.radiusMd),
              bottomRight: Radius.circular(theme.radiusMd),
            ),
            child: Text(
              '$day',
            ),
          ),
        );
      case _DateItemType.inRangeSelectedShort:
        return SizedBox(
          width: 32,
          height: 32,
          child: PrimaryButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: onTap,
            borderRadius: BorderRadius.zero,
            child: Text(
              '$day',
            ),
          ),
        );
    }
  }
}
