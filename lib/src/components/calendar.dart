import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class CalendarValue {
  CalendarValueLookup lookup(DateTime date);
  const CalendarValue();
  factory CalendarValue.single(DateTime date) {
    return _SingleCalendarValue(date);
  }
  factory CalendarValue.range(DateTime start, DateTime end) {
    return _RangedCalendarValue(start, end);
  }
  factory CalendarValue.multi(List<DateTime> dates) {
    return _MultiCalendarValue(dates);
  }

  CalendarValue toSingle();
  CalendarValue toRange();
  CalendarValue toMulti();
}

class _SingleCalendarValue extends CalendarValue {
  final DateTime date;

  _SingleCalendarValue(this.date);

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

    return other is _SingleCalendarValue && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;

  @override
  CalendarValue toSingle() {
    return this;
  }

  @override
  CalendarValue toRange() {
    return CalendarValue.range(date, date);
  }

  @override
  CalendarValue toMulti() {
    return CalendarValue.multi([date]);
  }
}

class _RangedCalendarValue extends CalendarValue {
  final DateTime start;
  final DateTime end;

  _RangedCalendarValue(DateTime start, DateTime end)
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

    return other is _RangedCalendarValue &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  CalendarValue toSingle() {
    return CalendarValue.single(start);
  }

  @override
  CalendarValue toRange() {
    return this;
  }

  @override
  CalendarValue toMulti() {
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

class _MultiCalendarValue extends CalendarValue {
  final List<DateTime> dates;

  _MultiCalendarValue(this.dates);

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

    return other is _MultiCalendarValue && listEquals(other.dates, dates);
  }

  @override
  int get hashCode => dates.hashCode;

  @override
  CalendarValue toSingle() {
    return CalendarValue.single(dates.first);
  }

  @override
  CalendarValue toRange() {
    assert(dates.isNotEmpty, 'Cannot convert empty list to range');
    DateTime min = dates
        .reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime max = dates
        .reduce((value, element) => value.isAfter(element) ? value : element);
    return CalendarValue.range(min, max);
  }

  @override
  CalendarValue toMulti() {
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
      if (calendarValue is _SingleCalendarValue &&
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
        (multi as _MultiCalendarValue).dates.add(date);
        onChanged?.call(multi);
        return;
      } else {
        var multi = calendarValue.toMulti();
        (multi as _MultiCalendarValue).dates.remove(date);
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
      if (calendarValue is _MultiCalendarValue) {
        calendarValue = calendarValue.toRange();
      }
      if (calendarValue is _SingleCalendarValue) {
        DateTime selectedDate = calendarValue.date;
        if (_isSameDay(date, selectedDate)) {
          onChanged?.call(null);
          return;
        }
        onChanged?.call(CalendarValue.range(selectedDate, date));
        return;
      }
      if (calendarValue is _RangedCalendarValue) {
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
    final calendarValue = value;
    int weekDayStart = (DateTime(view.year, view.month).weekday + 1) % 7;
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
    // start from the first day of the week
    for (int i = 1; i < weekDayStart; i++) {
      int previousMonthDay = daysInMonth - (weekDayStart - i);
      var dateTime = DateTime(view.year, view.month - 1, previousMonthDay);
      int indexAtRow = i - 1;
      DateItemType type = DateItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue.lookup(dateTime);
        switch (lookup) {
          case CalendarValueLookup.none:
            break;
          case CalendarValueLookup.selected:
            type = DateItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = DateItemType.startRange;
            break;
          case CalendarValueLookup.end:
            type = DateItemType.endRange;
            break;
          case CalendarValueLookup.inRange:
            type = DateItemType.inRange;
            break;
        }
      }
      days.add(dateBuilder?.call(
            context,
            dateTime,
          ) ??
          Opacity(
            opacity: 0.5,
            child: DateItem(
              day: previousMonthDay,
              type: type,
              indexAtRow: indexAtRow,
              onTap: () {
                _handleTap(dateTime);
              },
            ),
          ));
    }
    // then the days of the month
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(view.year, view.month, i);
      DateItemType type = DateItemType.none;
      int indexAtRow = (weekDayStart + i - 2) % 7;
      if (calendarValue != null) {
        final lookup = calendarValue.lookup(date);
        switch (lookup) {
          case CalendarValueLookup.none:
            break;
          case CalendarValueLookup.selected:
            type = DateItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = DateItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = DateItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = DateItemType.inRange;
            break;
        }
      }
      days.add(dateBuilder?.call(context, date) ??
          DateItem(
            day: i,
            type: type,
            indexAtRow: indexAtRow,
            onTap: () {
              if (isDateEnabled?.call(date) ?? true) {
                _handleTap(date);
              }
            },
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
      DateItemType type = DateItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue.lookup(dateTime);
        switch (lookup) {
          case CalendarValueLookup.none:
            break;
          case CalendarValueLookup.selected:
            type = DateItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = DateItemType.startRange;
            break;
          case CalendarValueLookup.end:
            type = DateItemType.endRange;
            break;
          case CalendarValueLookup.inRange:
            type = DateItemType.inRange;
            break;
        }
      }
      days.add(dateBuilder?.call(context, dateTime) ??
          Opacity(
            opacity: 0.5,
            child: DateItem(
              day: nextMonthDay,
              type: type,
              indexAtRow: indexAtRow,
              onTap: () {
                _handleTap(dateTime);
              },
            ),
          ));
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

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool _isInRange(DateTime date, DateTime start, DateTime end) {
  return date.isAfter(start) && date.isBefore(end);
}

enum DateItemType {
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

class DateItem extends StatelessWidget {
  final int day;
  final DateItemType type;
  final VoidCallback? onTap;
  final int indexAtRow;

  const DateItem({
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
      case DateItemType.none:
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
      case DateItemType.today:
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
      case DateItemType.selected:
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
      case DateItemType.inRange:
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
      case DateItemType.startRange:
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
      case DateItemType.endRange:
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
      case DateItemType.startRangeSelected:
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
      case DateItemType.endRangeSelected:
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
      case DateItemType.startRangeSelectedShort:
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
      case DateItemType.endRangeSelectedShort:
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
      case DateItemType.inRangeSelectedShort:
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
