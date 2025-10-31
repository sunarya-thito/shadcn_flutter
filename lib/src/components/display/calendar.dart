import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for calendar widgets.
///
/// Provides styling options for calendar components, including arrow icon colors
/// for navigation buttons and other visual elements.
class CalendarTheme {
  /// Color of navigation arrow icons.
  final Color? arrowIconColor;

  /// Creates a [CalendarTheme].
  ///
  /// Parameters:
  /// - [arrowIconColor] (`Color?`, optional): Color for navigation arrow icons.
  const CalendarTheme({this.arrowIconColor});

  /// Creates a copy of this theme with the given fields replaced.
  CalendarTheme copyWith({ValueGetter<Color?>? arrowIconColor}) {
    return CalendarTheme(
        arrowIconColor:
            arrowIconColor == null ? this.arrowIconColor : arrowIconColor());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarTheme && other.arrowIconColor == arrowIconColor;
  }

  @override
  int get hashCode => arrowIconColor.hashCode;
}

/// Defines the different view types available in calendar components.
///
/// Specifies what granularity of time selection is displayed.
enum CalendarViewType {
  /// Shows individual days in a month grid.
  date,

  /// Shows months in a year grid.
  month,

  /// Shows years in a decade grid.
  year,
}

/// Represents the interactive state of a date in the calendar.
///
/// Controls whether a specific date can be selected or interacted with.
enum DateState {
  /// Date cannot be selected or clicked.
  disabled,

  /// Date is fully interactive and selectable.
  enabled,
}

/// Callback function type for determining the state of calendar dates.
///
/// Takes a [DateTime] and returns a [DateState] to control whether
/// that date should be enabled or disabled for user interaction.
typedef DateStateBuilder = DateState Function(DateTime date);

/// Selection modes available for calendar components.
///
/// Determines how users can select dates in calendar widgets.
enum CalendarSelectionMode {
  /// No date selection allowed (display only).
  none,

  /// Only one date can be selected at a time.
  single,

  /// Two dates can be selected to form a date range.
  range,

  /// Multiple individual dates can be selected.
  multi,
}

/// A date picker dialog that provides comprehensive date selection capabilities.
///
/// Displays a modal dialog containing a calendar interface with support for
/// different view types (date, month, year), selection modes (single, range, multi),
/// and customizable date states. Includes navigation controls and responsive layouts.
///
/// Features:
/// - Multiple view types: date grid, month grid, year grid
/// - Various selection modes: single date, date range, multiple dates
/// - Navigation arrows with keyboard support
/// - Customizable date state validation
/// - Dual-calendar layout for range selection
/// - Theme integration and localization support
///
/// Example:
/// ```dart
/// DatePickerDialog(
///   initialViewType: CalendarViewType.date,
///   selectionMode: CalendarSelectionMode.single,
///   initialValue: CalendarValue.single(DateTime.now()),
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
class DatePickerDialog extends StatefulWidget {
  /// The initial view type to display (date, month, or year grid).
  final CalendarViewType initialViewType;

  /// The initial calendar view position (month/year to display).
  final CalendarView? initialView;

  /// The selection mode determining how dates can be selected.
  final CalendarSelectionMode selectionMode;

  /// Alternative view mode for display purposes.
  final CalendarSelectionMode? viewMode;

  /// The initially selected date value(s).
  final CalendarValue? initialValue;

  /// Callback invoked when the selected date(s) change.
  final ValueChanged<CalendarValue?>? onChanged;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Creates a [DatePickerDialog] with comprehensive date selection options.
  ///
  /// Configures the dialog's initial state, selection behavior, and callbacks
  /// for handling date changes and validation.
  ///
  /// Parameters:
  /// - [initialViewType] (CalendarViewType, required): Starting view (date/month/year)
  /// - [initialView] (CalendarView?, optional): Initial calendar view position
  /// - [selectionMode] (CalendarSelectionMode, required): How dates can be selected
  /// - [viewMode] (CalendarSelectionMode?, optional): Alternative view mode for display
  /// - [initialValue] (CalendarValue?, optional): Pre-selected date(s)
  /// - [onChanged] (`ValueChanged<CalendarValue>?`, optional): Called when selection changes
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// Example:
  /// ```dart
  /// DatePickerDialog(
  ///   initialViewType: CalendarViewType.date,
  ///   selectionMode: CalendarSelectionMode.range,
  ///   onChanged: (value) => handleDateChange(value),
  ///   stateBuilder: (date) => date.isBefore(DateTime.now())
  ///     ? DateState.disabled
  ///     : DateState.enabled,
  /// )
  /// ```
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
    final compTheme = ComponentTheme.maybeOf<CalendarTheme>(context);
    final arrowColor =
        styleValue(themeValue: compTheme?.arrowIconColor, defaultValue: null);
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
                        child: Icon(LucideIcons.arrowLeft, color: arrowColor)
                            .iconXSmall(),
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
                          child: Icon(LucideIcons.arrowRight, color: arrowColor)
                              .iconXSmall(),
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
                          child: Icon(LucideIcons.arrowRight, color: arrowColor)
                              .iconXSmall(),
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
                child:
                    Icon(LucideIcons.arrowLeft, color: arrowColor).iconXSmall(),
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
                child: Icon(LucideIcons.arrowRight, color: arrowColor)
                    .iconXSmall(),
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
            onViewChanged(view.copyWith(year: () => value));
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

/// Abstract base class representing calendar selection values.
///
/// Provides a unified interface for different types of calendar selections including
/// single dates, date ranges, and multiple date collections. Handles date lookup
/// operations and conversion between different selection types.
///
/// Subclasses include:
/// - [SingleCalendarValue]: Represents a single selected date
/// - [RangeCalendarValue]: Represents a date range with start and end
/// - [MultiCalendarValue]: Represents multiple individual selected dates
///
/// The class provides factory constructors for easy creation and conversion
/// methods to transform between different selection types as needed.
///
/// Example:
/// ```dart
/// // Create different value types
/// final single = CalendarValue.single(DateTime.now());
/// final range = CalendarValue.range(startDate, endDate);
/// final multi = CalendarValue.multi([date1, date2, date3]);
///
/// // Check if a date is selected
/// final lookup = value.lookup(2024, 3, 15);
/// final isSelected = lookup != CalendarValueLookup.none;
/// ```
abstract class CalendarValue {
  /// Looks up whether the specified date is part of this calendar value.
  ///
  /// Returns a [CalendarValueLookup] indicating the relationship of the
  /// queried date to this value (none, selected, start, end, or inRange).
  CalendarValueLookup lookup(int year, [int? month = 1, int? day = 1]);

  /// Creates a base calendar value.
  const CalendarValue();

  /// Factory constructor to create a single date value.
  static SingleCalendarValue single(DateTime date) {
    return SingleCalendarValue(date);
  }

  /// Factory constructor to create a date range value.
  static RangeCalendarValue range(DateTime start, DateTime end) {
    return RangeCalendarValue(start, end);
  }

  /// Factory constructor to create a multi-date value.
  static MultiCalendarValue multi(List<DateTime> dates) {
    return MultiCalendarValue(dates);
  }

  /// Converts this value to a single calendar value.
  SingleCalendarValue toSingle();

  /// Converts this value to a range calendar value.
  RangeCalendarValue toRange();

  /// Converts this value to a multi calendar value.
  MultiCalendarValue toMulti();

  /// Returns the calendar view associated with this value.
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

/// Calendar value representing a single selected date.
///
/// Encapsulates a single [DateTime] selection and provides lookup functionality
/// to determine if a given date matches the selected date. Used primarily
/// with [CalendarSelectionMode.single].
///
/// Example:
/// ```dart
/// final singleValue = SingleCalendarValue(DateTime(2024, 3, 15));
/// final lookup = singleValue.lookup(2024, 3, 15);
/// print(lookup == CalendarValueLookup.selected); // true
/// ```
class SingleCalendarValue extends CalendarValue {
  /// The selected date.
  final DateTime date;

  /// Creates a single calendar value with the specified date.
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

/// Calendar value representing a date range selection.
///
/// Encapsulates a date range with start and end dates. Provides lookup
/// functionality to determine if a date is the start, end, within the range,
/// or outside. Used with [CalendarSelectionMode.range].
///
/// The range is automatically normalized so start is always before or equal to end.
class RangeCalendarValue extends CalendarValue {
  /// The start date of the range (always <= end).
  final DateTime start;

  /// The end date of the range (always >= start).
  final DateTime end;

  /// Creates a range calendar value with the specified start and end dates.
  ///
  /// Automatically normalizes the range so [start] is before [end].
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

/// Calendar value representing multiple selected dates.
///
/// Encapsulates a list of individually selected dates. Provides lookup
/// functionality to determine if a date is among the selected dates.
/// Used with [CalendarSelectionMode.multi].
class MultiCalendarValue extends CalendarValue {
  /// The list of selected dates.
  final List<DateTime> dates;

  /// Creates a multi calendar value with the specified list of dates.
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

/// Result type for calendar value lookup operations.
///
/// Indicates the relationship between a queried date and the current calendar selection.
enum CalendarValueLookup {
  /// Date is not part of any selection.
  none,

  /// Date is directly selected (single mode or exact match).
  selected,

  /// Date is the start of a selected range.
  start,

  /// Date is the end of a selected range.
  end,

  /// Date falls within a selected range but is not start/end.
  inRange
}

/// Represents a specific month and year view in calendar navigation.
///
/// Provides immutable representation of a calendar's current viewing position
/// with navigation methods to move between months and years. Used to control
/// which month/year combination is displayed in calendar grids.
///
/// Key Features:
/// - **Navigation Methods**: [next], [previous], [nextYear], [previousYear]
/// - **Factory Constructors**: [now()], [fromDateTime()]
/// - **Validation**: Ensures month values stay within 1-12 range
/// - **Immutable**: All navigation returns new CalendarView instances
///
/// Example:
/// ```dart
/// // Create views for different dates
/// final current = CalendarView.now();
/// final specific = CalendarView(2024, 3); // March 2024
/// final fromDate = CalendarView.fromDateTime(someDateTime);
///
/// // Navigate between months
/// final nextMonth = current.next;
/// final prevMonth = current.previous;
/// final nextYear = current.nextYear;
/// ```
class CalendarView {
  /// The year component of this view.
  final int year;

  /// The month component of this view (1-12).
  final int month;

  /// Creates a [CalendarView] for the specified year and month.
  ///
  /// Parameters:
  /// - [year] (int): Four-digit year value
  /// - [month] (int): Month number (1-12, where 1 = January)
  ///
  /// Throws [AssertionError] if month is not between 1 and 12.
  ///
  /// Example:
  /// ```dart
  /// final view = CalendarView(2024, 3); // March 2024
  /// ```
  CalendarView(this.year, this.month) {
    assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');
  }

  /// Creates a [CalendarView] for the current month and year.
  ///
  /// Uses [DateTime.now()] to determine the current date and extracts
  /// the year and month components.
  ///
  /// Example:
  /// ```dart
  /// final currentView = CalendarView.now();
  /// ```
  factory CalendarView.now() {
    DateTime now = DateTime.now();
    return CalendarView(now.year, now.month);
  }

  /// Creates a [CalendarView] from an existing [DateTime].
  ///
  /// Extracts the year and month components from the provided [DateTime]
  /// and creates a corresponding calendar view.
  ///
  /// Parameters:
  /// - [dateTime] (DateTime): Date to extract year and month from
  ///
  /// Example:
  /// ```dart
  /// final birthday = DateTime(1995, 7, 15);
  /// final view = CalendarView.fromDateTime(birthday); // July 1995
  /// ```
  factory CalendarView.fromDateTime(DateTime dateTime) {
    return CalendarView(dateTime.year, dateTime.month);
  }

  /// Returns a view for the next month.
  ///
  /// Advances to the next month, rolling over to January of the next year
  /// if the current month is December.
  CalendarView get next {
    if (month == 12) {
      return CalendarView(year + 1, 1);
    }
    return CalendarView(year, month + 1);
  }

  /// Returns a view for the previous month.
  ///
  /// Moves back to the previous month, rolling back to December of the previous
  /// year if the current month is January.
  CalendarView get previous {
    if (month == 1) {
      return CalendarView(year - 1, 12);
    }
    return CalendarView(year, month - 1);
  }

  /// Returns a view for the next year with the same month.
  CalendarView get nextYear {
    return CalendarView(year + 1, month);
  }

  /// Returns a view for the previous year with the same month.
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

  /// Creates a copy of this view with the given fields replaced.
  CalendarView copyWith({
    ValueGetter<int>? year,
    ValueGetter<int>? month,
  }) {
    return CalendarView(
      year == null ? this.year : year(),
      month == null ? this.month : month(),
    );
  }
}

/// Extension methods on [DateTime] for calendar operations.
extension CalendarDateTime on DateTime {
  /// Converts this DateTime to a CalendarView.
  CalendarView toCalendarView() {
    return CalendarView.fromDateTime(this);
  }

  /// Converts this DateTime to a single CalendarValue.
  CalendarValue toCalendarValue() {
    return CalendarValue.single(this);
  }
}

/// A highly customizable calendar widget supporting multiple selection modes.
///
/// Displays a grid-based calendar interface allowing users to view and select dates
/// with comprehensive support for single selection, range selection, and multiple
/// date selection. Includes built-in date validation, state management, and theme integration.
///
/// Key Features:
/// - **Selection Modes**: Single date, date range, multiple dates, or display-only
/// - **Date Validation**: Custom date state builder for enabling/disabling dates
/// - **Interactive Grid**: Touch/click support with visual feedback
/// - **Theme Integration**: Follows shadcn_flutter design system
/// - **Accessibility**: Screen reader and keyboard navigation support
/// - **Customizable Appearance**: Themed colors, spacing, and visual states
///
/// The calendar automatically handles date logic, leap years, month boundaries,
/// and provides consistent visual feedback for different selection states.
///
/// Selection Behavior:
/// - **Single**: Click to select one date, click again to deselect
/// - **Range**: Click start date, then end date to form range
/// - **Multi**: Click multiple dates to build selection set
/// - **None**: Display-only mode with no interaction
///
/// Example:
/// ```dart
/// Calendar(
///   view: CalendarView.now(),
///   selectionMode: CalendarSelectionMode.range,
///   value: CalendarValue.range(startDate, endDate),
///   onChanged: (value) => setState(() => selectedDates = value),
///   stateBuilder: (date) => date.isBefore(DateTime.now())
///     ? DateState.disabled
///     : DateState.enabled,
/// )
/// ```
class Calendar extends StatefulWidget {
  /// The current date for highlighting purposes (defaults to DateTime.now()).
  final DateTime? now;

  /// The currently selected date value(s).
  final CalendarValue? value;

  /// The month and year view to display in the calendar.
  final CalendarView view;

  /// The selection mode determining how dates can be selected.
  final CalendarSelectionMode selectionMode;

  /// Callback invoked when the selected date(s) change.
  final ValueChanged<CalendarValue?>? onChanged;

  /// Legacy function to determine if a date should be enabled.
  final bool Function(DateTime date)? isDateEnabled;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Creates a [Calendar] widget with flexible date selection capabilities.
  ///
  /// Configures the calendar's view, selection behavior, and interaction handling
  /// with comprehensive options for customization and validation.
  ///
  /// Parameters:
  /// - [view] (CalendarView, required): Month/year to display in calendar grid
  /// - [selectionMode] (CalendarSelectionMode, required): How dates can be selected
  /// - [now] (DateTime?, optional): Current date for highlighting, defaults to DateTime.now()
  /// - [value] (CalendarValue?, optional): Currently selected date(s)
  /// - [onChanged] (`ValueChanged<CalendarValue>?`, optional): Called when selection changes
  /// - [isDateEnabled] (bool Function(DateTime)?, optional): Legacy date validation function
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// The [view] parameter determines which month and year are shown in the calendar grid.
  /// Use [CalendarView.now()] for current month or [CalendarView(year, month)] for specific dates.
  ///
  /// The [stateBuilder] takes precedence over [isDateEnabled] when both are provided.
  ///
  /// Example:
  /// ```dart
  /// Calendar(
  ///   view: CalendarView(2024, 3), // March 2024
  ///   selectionMode: CalendarSelectionMode.single,
  ///   onChanged: (value) => print('Selected: ${value?.toString()}'),
  ///   stateBuilder: (date) => date.weekday == DateTime.sunday
  ///     ? DateState.disabled
  ///     : DateState.enabled,
  /// )
  /// ```
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

/// A calendar widget that displays months in a year grid.
///
/// Shows a 4x3 grid of months for year selection. Used as part of the calendar
/// navigation when users want to select a different month.
class MonthCalendar extends StatelessWidget {
  /// The current calendar view (year to display).
  final CalendarView value;

  /// Callback invoked when a month is selected.
  final ValueChanged<CalendarView> onChanged;

  /// The current date for highlighting purposes.
  final DateTime? now;

  /// The currently selected calendar value.
  final CalendarValue? calendarValue;

  /// Builder function to determine the state of each month.
  final DateStateBuilder? stateBuilder;

  /// Creates a month selection calendar.
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
            onChanged(value.copyWith(month: () => i));
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

/// A calendar widget that displays years in a grid.
///
/// Shows a 4x4 grid of years for year selection. Used as part of the calendar
/// navigation when users want to select a different year.
class YearCalendar extends StatelessWidget {
  /// The starting year for the grid display.
  final int yearSelectStart;

  /// The currently selected year value.
  final int value;

  /// Callback invoked when a year is selected.
  final ValueChanged<int> onChanged;

  /// The current date for highlighting purposes.
  final DateTime? now;

  /// The currently selected calendar value.
  final CalendarValue? calendarValue;

  /// Builder function to determine the state of each year.
  final DateStateBuilder? stateBuilder;

  /// Creates a year selection calendar.
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

/// Visual states for individual calendar date items.
///
/// Defines the different visual appearances and behaviors that calendar date cells
/// can have based on their selection state and position within ranges.
enum CalendarItemType {
  /// Normal unselected date.
  none,

  /// Current date highlighted.
  today,

  /// Single selected date or exact range boundary.
  selected,

  /// Date within a selected range but not start/end.
  inRange,

  /// Range start boundary in other months (same as startRangeSelected).
  startRange,

  /// Range end boundary in other months (same as endRangeSelected).
  endRange,

  /// Range start boundary in current month.
  startRangeSelected,

  /// Range end boundary in current month.
  endRangeSelected,

  /// Range start boundary in short ranges.
  startRangeSelectedShort,

  /// Range end boundary in short ranges (typically 2-day ranges).
  endRangeSelectedShort,

  /// Middle dates in short ranges (typically 2-day ranges).
  inRangeSelectedShort,
}

/// Individual calendar date cell with interactive behavior and visual states.
///
/// Represents a single date item within a calendar grid, handling touch interactions,
/// visual state management, and theme integration. Supports different visual states
/// for selection, ranges, and special dates like today.
///
/// Key Features:
/// - **Visual States**: Multiple appearance modes based on selection status
/// - **Interactive**: Touch/click handling with callbacks
/// - **Responsive Sizing**: Configurable width/height with theme scaling
/// - **Accessibility**: Screen reader support and focus management
/// - **State Management**: Enabled/disabled states with visual feedback
/// - **Range Support**: Special styling for range start/end/middle positions
///
/// The item automatically applies appropriate button styling based on its [type]
/// and handles edge cases for range visualization at row boundaries.
///
/// Example:
/// ```dart
/// CalendarItem(
///   type: CalendarItemType.selected,
///   indexAtRow: 2,
///   rowCount: 7,
///   state: DateState.enabled,
///   onTap: () => handleDateTap(date),
///   child: Text('15'),
/// )
/// ```
class CalendarItem extends StatelessWidget {
  /// The widget to display as the date content.
  final Widget child;

  /// The visual state type for this calendar item.
  final CalendarItemType type;

  /// Callback invoked when the item is tapped.
  final VoidCallback? onTap;

  /// The position of this item in its row (0-indexed).
  final int indexAtRow;

  /// The total number of items per row.
  final int rowCount;

  /// Optional fixed width for the item.
  final double? width;

  /// Optional fixed height for the item.
  final double? height;

  /// The interaction state of this date (enabled/disabled).
  final DateState state;

  /// Creates a calendar item with the specified properties.
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

/// Data structure representing a complete calendar month grid.
///
/// Contains all the information needed to render a calendar grid including
/// dates from the current month and overflow dates from adjacent months
/// to fill complete weeks.
class CalendarGridData {
  /// The month number (1-12) this grid represents.
  final int month;

  /// The year this grid represents.
  final int year;

  /// The list of calendar grid items including current and adjacent month dates.
  final List<CalendarGridItem> items;

  /// Creates calendar grid data for the specified month and year.
  ///
  /// Automatically calculates and includes dates from previous and next months
  /// to fill complete weeks in the grid.
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

/// Individual item within a calendar grid representing a single date cell.
///
/// Contains metadata about a date's position and state within the calendar grid.
class CalendarGridItem {
  /// The date this grid item represents.
  final DateTime date;

  /// The index of this item within its row (0-6 for day of week).
  final int indexInRow;

  /// The row index in the calendar grid.
  final int rowIndex;

  /// Whether this date belongs to a different month than the grid's primary month.
  final bool fromAnotherMonth;

  /// Creates a calendar grid item.
  CalendarGridItem(
      this.date, this.indexInRow, this.fromAnotherMonth, this.rowIndex);

  /// Returns true if this item represents today's date.
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

/// Widget that renders a calendar grid using provided data.
///
/// Takes calendar grid data and an item builder to render the visual grid
/// of calendar dates. Handles layout and arrangement of dates in a weekly grid.
class CalendarGrid extends StatelessWidget {
  /// The grid data containing all calendar items to display.
  final CalendarGridData data;

  /// Builder function to create widgets for each grid item.
  final Widget Function(CalendarGridItem item) itemBuilder;

  /// Creates a calendar grid widget.
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
        mainAxisSize: MainAxisSize.min,
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
