import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';
import '../../resizer.dart';

/// Theme configuration for [Table] components.
///
/// [TableTheme] provides comprehensive styling options for table components
/// including borders, background colors, corner radius, and cell theming.
/// It integrates with the shadcn_flutter theming system to ensure consistent
/// table styling throughout an application.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<TableTheme>(
///   data: TableTheme(
///     border: Border.all(color: Colors.grey.shade300),
///     borderRadius: BorderRadius.circular(8.0),
///     backgroundColor: Colors.grey.shade50,
///     cellTheme: TableCellTheme(
///       padding: EdgeInsets.all(12.0),
///     ),
///   ),
///   child: MyTableWidget(),
/// );
/// ```
class TableTheme {
  /// Border configuration for the entire table.
  ///
  /// Type: `Border?`. Defines the outer border of the table container.
  /// If null, uses the default theme border or no border.
  final Border? border;

  /// Border radius for the table corners.
  ///
  /// Type: `BorderRadiusGeometry?`. Controls corner rounding of the table
  /// container. If null, uses the theme's default radius.
  final BorderRadiusGeometry? borderRadius;

  /// Background color for the table container.
  ///
  /// Type: `Color?`. Used as the background color behind all table content.
  /// If null, uses the theme's default background color.
  final Color? backgroundColor;

  /// Default theme for all table cells.
  ///
  /// Type: `TableCellTheme?`. Provides default styling for table cells
  /// including padding, borders, and text styles. Individual cells can
  /// override this theme.
  final TableCellTheme? cellTheme;

  /// Creates a [TableTheme].
  ///
  /// All parameters are optional and will fall back to theme defaults
  /// when not provided.
  ///
  /// Parameters:
  /// - [border] (Border?, optional): Table container border
  /// - [backgroundColor] (Color?, optional): Table background color
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Corner radius
  /// - [cellTheme] (TableCellTheme?, optional): Default cell styling
  ///
  /// Example:
  /// ```dart
  /// TableTheme(
  ///   border: Border.all(color: Colors.grey),
  ///   borderRadius: BorderRadius.circular(4.0),
  ///   backgroundColor: Colors.white,
  /// );
  /// ```
  const TableTheme({
    this.border,
    this.backgroundColor,
    this.borderRadius,
    this.cellTheme,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableTheme &&
        other.border == border &&
        other.backgroundColor == backgroundColor &&
        other.cellTheme == cellTheme;
  }

  @override
  int get hashCode {
    return Object.hash(border, backgroundColor, cellTheme);
  }

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Returns a new [TableTheme] instance with the same values as this theme,
  /// except for any parameters that are explicitly provided. Use [ValueGetter]
  /// functions to specify new values.
  ///
  /// Parameters are [ValueGetter] functions that return the new value when called.
  /// This allows for conditional value setting and proper null handling.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   backgroundColor: () => Colors.blue.shade50,
  ///   border: () => Border.all(color: Colors.blue),
  /// );
  /// ```
  TableTheme copyWith({
    ValueGetter<Border?>? border,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<TableCellTheme?>? cellTheme,
  }) {
    return TableTheme(
      border: border == null ? this.border : border(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      cellTheme: cellTheme == null ? this.cellTheme : cellTheme(),
    );
  }
}

/// Defines size constraints for table columns or rows.
///
/// Specifies minimum and maximum size limits that can be applied
/// to table dimensions. Used with [ResizableTable] to control
/// resize boundaries.
///
/// Example:
/// ```dart
/// ConstrainedTableSize(
///   min: 50.0,  // Minimum 50 pixels
///   max: 300.0, // Maximum 300 pixels
/// )
/// ```
class ConstrainedTableSize {
  /// Minimum allowed size. Defaults to negative infinity (no minimum).
  final double min;

  /// Maximum allowed size. Defaults to positive infinity (no maximum).
  final double max;

  /// Creates a [ConstrainedTableSize] with optional min and max values.
  const ConstrainedTableSize({
    this.min = double.negativeInfinity,
    this.max = double.infinity,
  });
}

/// Theme configuration for individual table cells.
///
/// [TableCellTheme] provides state-aware styling options for table cells
/// using [WidgetStateProperty] to handle different interactive states like
/// hover, selected, disabled, etc. This enables rich visual feedback for
/// table interactions.
///
/// ## State-Aware Properties
/// All properties use [WidgetStateProperty] to support different visual
/// states:
/// - [WidgetState.hovered]: Mouse hover state
/// - [WidgetState.selected]: Cell/row selection state
/// - [WidgetState.disabled]: Disabled interaction state
/// - [WidgetState.pressed]: Active press state
///
/// Example:
/// ```dart
/// TableCellTheme(
///   backgroundColor: WidgetStateProperty.resolveWith((states) {
///     if (states.contains(WidgetState.hovered)) {
///       return Colors.blue.shade50;
///     }
///     return null;
///   }),
///   textStyle: WidgetStateProperty.all(
///     TextStyle(fontWeight: FontWeight.w500),
///   ),
/// );
/// ```
class TableCellTheme {
  /// State-aware border configuration for table cells.
  ///
  /// Type: `WidgetStateProperty<Border?>?`. Defines cell borders that can
  /// change based on interactive states. Useful for highlighting selected
  /// or hovered cells.
  final WidgetStateProperty<Border?>? border;

  /// State-aware background color for table cells.
  ///
  /// Type: `WidgetStateProperty<Color?>?`. Controls cell background colors
  /// that can change based on hover, selection, or other states.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// State-aware text styling for table cell content.
  ///
  /// Type: `WidgetStateProperty<TextStyle?>?`. Controls text appearance
  /// including color, weight, size that can change based on cell states.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// Creates a [TableCellTheme].
  ///
  /// All parameters are optional and use [WidgetStateProperty] for
  /// state-aware styling.
  ///
  /// Parameters:
  /// - [border] (`WidgetStateProperty<Border?>?`, optional): State-aware borders
  /// - [backgroundColor] (`WidgetStateProperty<Color?>?`, optional): State-aware background
  /// - [textStyle] (`WidgetStateProperty<TextStyle?>?`, optional): State-aware text styling
  ///
  /// Example:
  /// ```dart
  /// TableCellTheme(
  ///   border: WidgetStateProperty.all(
  ///     Border.all(color: Colors.grey.shade300),
  ///   ),
  ///   backgroundColor: WidgetStateProperty.resolveWith((states) {
  ///     return states.contains(WidgetState.selected) ? Colors.blue.shade100 : null;
  ///   }),
  /// );
  /// ```
  const TableCellTheme({
    this.border,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableCellTheme &&
        other.border == border &&
        other.backgroundColor == backgroundColor &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode {
    return Object.hash(border, backgroundColor, textStyle);
  }

  /// Creates a copy of this cell theme with the given values replaced.
  ///
  /// Returns a new [TableCellTheme] instance with the same state properties
  /// as this theme, except for any parameters that are explicitly provided.
  /// Use [ValueGetter] functions to specify new state properties.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   backgroundColor: () => WidgetStateProperty.all(Colors.yellow.shade50),
  ///   textStyle: () => WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
  /// );
  /// ```
  TableCellTheme copyWith({
    ValueGetter<WidgetStateProperty<Border>?>? border,
    ValueGetter<WidgetStateProperty<Color>?>? backgroundColor,
    ValueGetter<WidgetStateProperty<TextStyle>?>? textStyle,
  }) {
    return TableCellTheme(
      border: border == null ? this.border : border(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
    );
  }
}

/// Theme configuration for resizable tables.
///
/// Provides styling options for resizable table components including
/// the base table theme, resizer appearance, and interaction behavior.
///
/// Example:
/// ```dart
/// ResizableTableTheme(
///   tableTheme: TableTheme(...),
///   resizerThickness: 2.0,
///   resizerColor: Colors.blue,
/// )
/// ```
class ResizableTableTheme {
  /// Base theme configuration for the table.
  final TableTheme? tableTheme;

  /// Thickness of the resize handle in pixels.
  final double? resizerThickness;

  /// Color of the resize handle.
  final Color? resizerColor;

  /// Creates a [ResizableTableTheme].
  const ResizableTableTheme({
    this.tableTheme,
    this.resizerThickness,
    this.resizerColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResizableTableTheme &&
        other.tableTheme == tableTheme &&
        other.resizerThickness == resizerThickness &&
        other.resizerColor == resizerColor;
  }

  @override
  int get hashCode {
    return Object.hash(tableTheme, resizerThickness, resizerColor);
  }

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [tableTheme] (`ValueGetter<TableTheme?>?`, optional): New table theme.
  /// - [resizerThickness] (`ValueGetter<double?>?`, optional): New resizer thickness.
  /// - [resizerColor] (`ValueGetter<Color?>?`, optional): New resizer color.
  ///
  /// Returns: A new [ResizableTableTheme] with updated properties.
  ResizableTableTheme copyWith({
    ValueGetter<TableTheme?>? tableTheme,
    ValueGetter<double?>? resizerThickness,
    ValueGetter<Color?>? resizerColor,
  }) {
    return ResizableTableTheme(
      tableTheme: tableTheme == null ? this.tableTheme : tableTheme(),
      resizerThickness:
          resizerThickness == null ? this.resizerThickness : resizerThickness(),
      resizerColor: resizerColor == null ? this.resizerColor : resizerColor(),
    );
  }
}

class _HoveredLine {
  final int index;
  final Axis direction;

  _HoveredLine(this.index, this.direction);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _HoveredLine &&
        other.index == index &&
        other.direction == direction;
  }

  @override
  int get hashCode {
    return Object.hash(index, direction);
  }
}

/// Controller for managing resizable table column and row dimensions.
///
/// Provides programmatic control over table column widths and row heights
/// with support for constraints, default sizes, and interactive resizing.
/// Extends [ChangeNotifier] to notify listeners when dimensions change.
///
/// Example:
/// ```dart
/// final controller = ResizableTableController(
///   defaultColumnWidth: 100.0,
///   defaultRowHeight: 40.0,
///   columnWidths: {0: 150.0, 2: 200.0},
///   widthConstraints: {1: ConstrainedTableSize(min: 50, max: 300)},
/// );
/// ```
class ResizableTableController extends ChangeNotifier {
  Map<int, double>? _columnWidths;
  Map<int, double>? _rowHeights;
  final double _defaultColumnWidth;
  final double _defaultRowHeight;
  final ConstrainedTableSize? _defaultWidthConstraint;
  final ConstrainedTableSize? _defaultHeightConstraint;
  final Map<int, ConstrainedTableSize>? _widthConstraints;
  final Map<int, ConstrainedTableSize>? _heightConstraints;

  /// Creates a controller for managing resizable table dimensions.
  ///
  /// This controller manages column widths and row heights with support for
  /// constraints and dynamic resizing. It provides methods to resize individual
  /// columns/rows or adjust shared borders between adjacent columns/rows.
  ///
  /// Parameters:
  /// - [columnWidths] (`Map<int, double>?`): Initial column widths by index
  /// - [defaultColumnWidth] (double, required): Default width for columns without explicit width
  /// - [rowHeights] (`Map<int, double>?`): Initial row heights by index
  /// - [defaultRowHeight] (double, required): Default height for rows without explicit height
  /// - [defaultWidthConstraint] (ConstrainedTableSize?): Default width constraints applied to all columns
  /// - [defaultHeightConstraint] (ConstrainedTableSize?): Default height constraints applied to all rows
  /// - [widthConstraints] (`Map<int, ConstrainedTableSize>?`): Per-column width constraints
  /// - [heightConstraints] (`Map<int, ConstrainedTableSize>?`): Per-row height constraints
  ///
  /// Example:
  /// ```dart
  /// ResizableTableController(
  ///   defaultColumnWidth: 100,
  ///   defaultRowHeight: 40,
  ///   widthConstraints: {
  ///     0: ConstrainedTableSize(min: 80, max: 200),
  ///   },
  /// )
  /// ```
  ResizableTableController({
    Map<int, double>? columnWidths,
    required double defaultColumnWidth,
    Map<int, double>? rowHeights,
    required double defaultRowHeight,
    ConstrainedTableSize? defaultWidthConstraint,
    ConstrainedTableSize? defaultHeightConstraint,
    Map<int, ConstrainedTableSize>? widthConstraints,
    Map<int, ConstrainedTableSize>? heightConstraints,
  })  : _columnWidths = columnWidths,
        _rowHeights = rowHeights,
        _defaultColumnWidth = defaultColumnWidth,
        _defaultRowHeight = defaultRowHeight,
        _widthConstraints = widthConstraints,
        _heightConstraints = heightConstraints,
        _defaultWidthConstraint = defaultWidthConstraint,
        _defaultHeightConstraint = defaultHeightConstraint;

  /// Resizes a specific column to a new width.
  ///
  /// Parameters:
  /// - [column] (`int`, required): Column index.
  /// - [width] (`double`, required): New width in pixels.
  ///
  /// Returns: `bool` — true if resize succeeded, false otherwise.
  bool resizeColumn(int column, double width) {
    if (column < 0 || width < 0) {
      return false;
    }
    width = width.clamp(
        _widthConstraints?[column]?.min ?? _defaultWidthConstraint?.min ?? 0,
        _widthConstraints?[column]?.max ??
            _defaultWidthConstraint?.max ??
            double.infinity);
    if (_columnWidths != null && _columnWidths![column] == width) {
      return false;
    }
    _columnWidths ??= {};
    _columnWidths![column] = width;
    notifyListeners();
    return true;
  }

  /// Resizes adjacent columns by dragging their shared border.
  ///
  /// Parameters:
  /// - [previousColumn] (`int`, required): Index of column before border.
  /// - [nextColumn] (`int`, required): Index of column after border.
  /// - [deltaWidth] (`double`, required): Width change in pixels.
  ///
  /// Returns: `double` — actual width change applied.
  double resizeColumnBorder(
      int previousColumn, int nextColumn, double deltaWidth) {
    if (previousColumn < 0 || nextColumn < 0 || deltaWidth == 0) {
      return 0;
    }
    // make sure that both previous and next column have width enough to resize
    var previousWidth = _columnWidths?[previousColumn] ?? _defaultColumnWidth;
    double newPreviousWidth = previousWidth + deltaWidth;
    var nextWidth = _columnWidths?[nextColumn] ?? _defaultColumnWidth;
    double newNextWidth = nextWidth - deltaWidth;
    double clampedPreviousWidth = newPreviousWidth.clamp(
        _widthConstraints?[previousColumn]?.min ??
            _defaultWidthConstraint?.min ??
            0,
        _widthConstraints?[previousColumn]?.max ??
            _defaultWidthConstraint?.max ??
            double.infinity);
    double clampedNextWidth = newNextWidth.clamp(
        _widthConstraints?[nextColumn]?.min ??
            _defaultWidthConstraint?.min ??
            0,
        _widthConstraints?[nextColumn]?.max ??
            _defaultWidthConstraint?.max ??
            double.infinity);
    double previousDelta = clampedPreviousWidth - previousWidth;
    double nextDelta = clampedNextWidth - nextWidth;
    // find the delta that can be applied to both columns
    double delta = _absClosestTo(previousDelta, -nextDelta, 0);

    newPreviousWidth = previousWidth + delta;
    newNextWidth = nextWidth - delta;
    _columnWidths ??= {};
    _columnWidths![previousColumn] = newPreviousWidth;
    _columnWidths![nextColumn] = newNextWidth;
    notifyListeners();
    return delta;
  }

  double _absClosestTo(double a, double b, double target) {
    double absA = (a - target).abs();
    double absB = (b - target).abs();
    return absA < absB ? a : b;
  }

  /// Resizes adjacent rows by dragging their shared border.
  ///
  /// Parameters:
  /// - [previousRow] (`int`, required): Index of row before border.
  /// - [nextRow] (`int`, required): Index of row after border.
  /// - [deltaHeight] (`double`, required): Height change in pixels.
  ///
  /// Returns: `double` — actual height change applied.
  double resizeRowBorder(int previousRow, int nextRow, double deltaHeight) {
    if (previousRow < 0 || nextRow < 0 || deltaHeight == 0) {
      return 0;
    }
    // make sure that both previous and next row have height enough to resize
    var previousHeight = _rowHeights?[previousRow] ?? _defaultRowHeight;
    double newPreviousHeight = previousHeight + deltaHeight;
    var nextHeight = _rowHeights?[nextRow] ?? _defaultRowHeight;
    double newNextHeight = nextHeight - deltaHeight;
    double clampedPreviousHeight = newPreviousHeight.clamp(
        _heightConstraints?[previousRow]?.min ??
            _defaultHeightConstraint?.min ??
            0,
        _heightConstraints?[previousRow]?.max ??
            _defaultHeightConstraint?.max ??
            double.infinity);
    double clampedNextHeight = newNextHeight.clamp(
        _heightConstraints?[nextRow]?.min ?? _defaultHeightConstraint?.min ?? 0,
        _heightConstraints?[nextRow]?.max ??
            _defaultHeightConstraint?.max ??
            double.infinity);
    double previousDelta = clampedPreviousHeight - previousHeight;
    double nextDelta = clampedNextHeight - nextHeight;
    // find the delta that can be applied to both rows
    double delta = _absClosestTo(previousDelta, -nextDelta, 0);

    newPreviousHeight = previousHeight + delta;
    newNextHeight = nextHeight - delta;
    _rowHeights ??= {};
    _rowHeights![previousRow] = newPreviousHeight;
    _rowHeights![nextRow] = newNextHeight;
    notifyListeners();
    return delta;
  }

  /// Resizes a specific row to a new height.
  ///
  /// Parameters:
  /// - [row] (`int`, required): Row index.
  /// - [height] (`double`, required): New height in pixels.
  ///
  /// Returns: `bool` — true if resize succeeded, false otherwise.
  bool resizeRow(int row, double height) {
    if (row < 0 || height < 0) {
      return false;
    }
    height = height.clamp(
        _heightConstraints?[row]?.min ?? _defaultHeightConstraint?.min ?? 0,
        _heightConstraints?[row]?.max ??
            _defaultHeightConstraint?.max ??
            double.infinity);
    if (_rowHeights != null && _rowHeights![row] == height) {
      return false;
    }
    _rowHeights ??= {};
    _rowHeights![row] = height;
    notifyListeners();
    return true;
  }

  /// Gets an unmodifiable map of custom column widths.
  ///
  /// Returns: `Map<int, double>?` — map of column indices to widths, or null if none set.
  Map<int, double>? get columnWidths => _columnWidths == null
      ? null
      : Map<int, double>.unmodifiable(_columnWidths!);

  /// Gets an unmodifiable map of custom row heights.
  ///
  /// Returns: `Map<int, double>?` — map of row indices to heights, or null if none set.
  Map<int, double>? get rowHeights =>
      _rowHeights == null ? null : Map<int, double>.unmodifiable(_rowHeights!);

  /// Gets the width of a specific column.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Column index.
  ///
  /// Returns: `double` — column width in pixels.
  double getColumnWidth(int index) {
    return _columnWidths?[index] ?? _defaultColumnWidth;
  }

  /// Gets the height of a specific row.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Row index.
  ///
  /// Returns: `double` — row height in pixels.
  double getRowHeight(int index) {
    return _rowHeights?[index] ?? _defaultRowHeight;
  }

  /// Gets the minimum height constraint for a specific row.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Row index.
  ///
  /// Returns: `double?` — minimum height, or null if unconstrained.
  double? getRowMinHeight(int index) {
    return _heightConstraints?[index]?.min ?? _defaultHeightConstraint?.min;
  }

  /// Gets the maximum height constraint for a specific row.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Row index.
  ///
  /// Returns: `double?` — maximum height, or null if unconstrained.
  double? getRowMaxHeight(int index) {
    return _heightConstraints?[index]?.max ?? _defaultHeightConstraint?.max;
  }

  /// Gets the minimum width constraint for a specific column.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Column index.
  ///
  /// Returns: `double?` — minimum width, or null if unconstrained.
  double? getColumnMinWidth(int index) {
    return _widthConstraints?[index]?.min ?? _defaultWidthConstraint?.min;
  }

  /// Gets the maximum width constraint for a specific column.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Column index.
  ///
  /// Returns: `double?` — maximum width, or null if unconstrained.
  double? getColumnMaxWidth(int index) {
    return _widthConstraints?[index]?.max ?? _defaultWidthConstraint?.max;
  }
}

/// Defines how table cells should resize.
///
/// Determines the behavior when a table cell is resized by the user.
enum TableCellResizeMode {
  /// The cell size will expand when resized
  expand,

  /// The cell size will expand when resized, but the other cells will shrink
  reallocate,

  /// Disables resizing
  none,
}

/// A table widget with resizable columns and rows.
///
/// Displays tabular data with interactive row and column resizing capabilities.
/// Supports frozen rows/columns, custom resize modes, and scrolling viewports.
///
/// Example:
/// ```dart
/// ResizableTable(
///   controller: ResizableTableController(),
///   rows: [
///     TableRow(children: [Text('Cell 1'), Text('Cell 2')]),
///     TableRow(children: [Text('Cell 3'), Text('Cell 4')]),
///   ],
/// )
/// ```
class ResizableTable extends StatefulWidget {
  /// List of table rows to display.
  final List<TableRow> rows;

  /// Controller for managing table resize state.
  final ResizableTableController controller;

  /// Theme for table styling.
  final ResizableTableTheme? theme;

  /// How content should be clipped at table boundaries.
  final Clip clipBehavior;

  /// Resize mode for column widths.
  final TableCellResizeMode cellWidthResizeMode;

  /// Resize mode for row heights.
  final TableCellResizeMode cellHeightResizeMode;

  /// Configuration for frozen (non-scrolling) rows and columns.
  final FrozenTableData? frozenCells;

  /// Horizontal scroll offset.
  final double? horizontalOffset;

  /// Vertical scroll offset.
  final double? verticalOffset;

  /// Size of the visible viewport.
  final Size? viewportSize;

  /// Creates a [ResizableTable].
  ///
  /// Parameters:
  /// - [rows] (`List<TableRow>`, required): Table rows.
  /// - [controller] (`ResizableTableController`, required): Resize controller.
  /// - [theme] (`ResizableTableTheme?`, optional): Table theme.
  /// - [clipBehavior] (`Clip`, default: `Clip.hardEdge`): Clipping behavior.
  /// - [cellWidthResizeMode] (`TableCellResizeMode`, default: `reallocate`): Column resize mode.
  /// - [cellHeightResizeMode] (`TableCellResizeMode`, default: `expand`): Row resize mode.
  /// - [frozenCells] (`FrozenTableData?`, optional): Frozen cell configuration.
  /// - [horizontalOffset] (`double?`, optional): Horizontal scroll offset.
  /// - [verticalOffset] (`double?`, optional): Vertical scroll offset.
  /// - [viewportSize] (`Size?`, optional): Viewport size.
  const ResizableTable({
    super.key,
    required this.rows,
    required this.controller,
    this.theme,
    this.clipBehavior = Clip.hardEdge,
    this.cellWidthResizeMode = TableCellResizeMode.reallocate,
    this.cellHeightResizeMode = TableCellResizeMode.expand,
    this.frozenCells,
    this.horizontalOffset,
    this.verticalOffset,
    this.viewportSize,
  });

  @override
  State<ResizableTable> createState() => _ResizableTableState();
}

class _ResizableTableState extends State<ResizableTable> {
  late List<_FlattenedTableCell> _cells;
  late int _maxColumn;
  late int _maxRow;
  final ValueNotifier<_HoveredLine?> _hoverNotifier = ValueNotifier(null);
  final ValueNotifier<_HoveredCell?> _hoveredCellNotifier = ValueNotifier(null);
  final ValueNotifier<_HoveredLine?> _dragNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _initResizerRows();
  }

  @override
  void didUpdateWidget(covariant ResizableTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.rows, oldWidget.rows)) {
      _initResizerRows();
    }
  }

  void _initResizerRows() {
    _cells = [];
    for (int r = 0; r < widget.rows.length; r++) {
      final row = widget.rows[r];
      for (int c = 0; c < row.cells.length; c++) {
        final cell = row.cells[c];
        _cells.add(_FlattenedTableCell(
          column: c,
          row: r,
          columnSpan: cell.columnSpan,
          rowSpan: cell.rowSpan,
          builder: cell.build,
          enabled: cell.enabled,
          hoveredCellNotifier: _hoveredCellNotifier,
          dragNotifier: _dragNotifier,
          tableCellThemeBuilder: row.buildDefaultTheme,
          selected: row.selected,
        ));
      }
    }
    _cells = _reorganizeCells(_cells);
    _maxColumn = 0;
    _maxRow = 0;
    for (final cell in _cells) {
      _maxColumn = max(_maxColumn, cell.column + cell.columnSpan - 1);
      _maxRow = max(_maxRow, cell.row + cell.rowSpan - 1);
    }
  }

  void _onHover(bool hover, int index, Axis direction) {
    if (hover) {
      _hoverNotifier.value = _HoveredLine(index, direction);
    } else if (_hoverNotifier.value?.index == index &&
        _hoverNotifier.value?.direction == direction) {
      _hoverNotifier.value = null;
    }
  }

  void _onDrag(bool drag, int index, Axis direction) {
    if (drag && _dragNotifier.value == null) {
      _dragNotifier.value = _HoveredLine(index, direction);
    } else if (!drag) {
      _dragNotifier.value = null;
    }
  }

  TableSize _width(int index) {
    return FixedTableSize(widget.controller.getColumnWidth(index));
  }

  TableSize _height(int index) {
    return FixedTableSize(widget.controller.getRowHeight(index));
  }

  @override
  Widget build(BuildContext context) {
    ResizableTableTheme? resizableTableTheme =
        widget.theme ?? ComponentTheme.maybeOf<ResizableTableTheme>(context);
    TableTheme? tableTheme = resizableTableTheme?.tableTheme ??
        ComponentTheme.maybeOf<TableTheme>(context);
    var children = _cells.map((cell) {
      return Data.inherit(
        data: cell,
        child: RawCell(
          column: cell.column,
          row: cell.row,
          columnSpan: cell.columnSpan,
          rowSpan: cell.rowSpan,
          child: Builder(builder: (context) {
            return cell.builder(context);
          }),
        ),
      );
    }).toList();
    return Data.inherit(
      data: this,
      child: Data.inherit(
        data: _ResizableTableData(
            controller: widget.controller,
            cellWidthResizeMode: widget.cellWidthResizeMode,
            cellHeightResizeMode: widget.cellHeightResizeMode,
            maxColumn: _maxColumn,
            maxRow: _maxRow),
        child: Container(
          clipBehavior: widget.clipBehavior,
          decoration: BoxDecoration(
            border: tableTheme?.border,
            color: tableTheme?.backgroundColor,
            borderRadius: tableTheme?.borderRadius,
          ),
          child: ListenableBuilder(
              listenable: widget.controller,
              builder: (context, child) {
                return RawTableLayout(
                  clipBehavior: widget.clipBehavior,
                  horizontalOffset: widget.horizontalOffset,
                  verticalOffset: widget.verticalOffset,
                  frozenColumn: widget.frozenCells?.testColumn,
                  frozenRow: widget.frozenCells?.testRow,
                  viewportSize: widget.viewportSize,
                  width: (index) {
                    return _width(index);
                  },
                  height: (index) {
                    return _height(index);
                  },
                  children: children,
                );
              }),
        ),
      ),
    );
  }
}

typedef _HoverCallback = void Function(bool hover, int index, Axis direction);

class _ResizableTableData {
  final ResizableTableController controller;
  final TableCellResizeMode cellWidthResizeMode;
  final TableCellResizeMode cellHeightResizeMode;
  final int maxColumn;
  final int maxRow;

  const _ResizableTableData({
    required this.controller,
    required this.cellWidthResizeMode,
    required this.cellHeightResizeMode,
    required this.maxColumn,
    required this.maxRow,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ResizableTableData &&
        other.cellWidthResizeMode == cellWidthResizeMode &&
        other.cellHeightResizeMode == cellHeightResizeMode &&
        other.maxColumn == maxColumn &&
        other.maxRow == maxRow;
  }

  @override
  int get hashCode {
    return Object.hash(
        cellWidthResizeMode, maxColumn, maxRow, cellHeightResizeMode);
  }
}

class _CellResizer extends StatefulWidget {
  final ResizableTableController controller;
  final ResizableTableTheme? theme;
  final _HoverCallback onHover;
  final _HoverCallback onDrag;
  final ValueNotifier<_HoveredLine?> hoverNotifier;
  final ValueNotifier<_HoveredLine?> dragNotifier;
  final int maxRow;
  final int maxColumn;

  const _CellResizer({
    required this.controller,
    required this.onHover,
    required this.onDrag,
    required this.hoverNotifier,
    required this.dragNotifier,
    this.theme,
    required this.maxRow,
    required this.maxColumn,
  });

  @override
  State<_CellResizer> createState() => _CellResizerState();
}

class _CellResizerState extends State<_CellResizer> {
  Resizer? _resizer;
  bool? _resizeRow;

  void _onDragStartRow(DragStartDetails details) {
    List<ResizableItem> items = [];
    for (int i = 0; i <= widget.maxRow; i++) {
      items.add(ResizableItem(
        value: widget.controller.getRowHeight(i),
        min: widget.controller.getRowMinHeight(i) ?? 0,
        max: widget.controller.getRowMaxHeight(i) ?? double.infinity,
      ));
    }
    _resizer = Resizer(items);
    _resizeRow = true;
    widget.onDrag(true, -1, Axis.horizontal);
  }

  void _onDragStartColumn(DragStartDetails details) {
    List<ResizableItem> items = [];
    for (int i = 0; i <= widget.maxColumn; i++) {
      items.add(ResizableItem(
        value: widget.controller.getColumnWidth(i),
        min: widget.controller.getColumnMinWidth(i) ?? 0,
        max: widget.controller.getColumnMaxWidth(i) ?? double.infinity,
      ));
    }
    _resizer = Resizer(items);
    _resizeRow = false;
    widget.onDrag(true, -1, Axis.vertical);
  }

  void _onDragUpdate(int start, int end, DragUpdateDetails details) {
    // _resizer!.resize(start, end, _delta!);
    _resizer!.dragDivider(end, details.primaryDelta!);
    for (int i = 0; i < _resizer!.items.length; i++) {
      // widget.controller.resizeRow(i, _resizer!.items[i].newValue);
      if (_resizeRow!) {
        widget.controller.resizeRow(i, _resizer!.items[i].newValue);
      } else {
        widget.controller.resizeColumn(i, _resizer!.items[i].newValue);
      }
    }
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onDrag(false, -1, Axis.horizontal);
    // _delta = null;
    _resizer = null;
    _resizeRow = null;
  }

  void _onDragCancel() {
    if (_resizer == null) {
      return;
    }
    widget.onDrag(false, -1, Axis.horizontal);
    _resizer!.reset();
    for (int i = 0; i <= widget.maxRow; i++) {
      if (_resizeRow == true) {
        widget.controller.resizeRow(i, _resizer!.items[i].value);
      } else {
        widget.controller.resizeColumn(i, _resizer!.items[i].value);
      }
    }
    _resizer = null;
    _resizeRow = null;
  }

  @override
  Widget build(BuildContext context) {
    double thickness = widget.theme?.resizerThickness ?? 4;
    final flattenedData = Data.of<_FlattenedTableCell>(context);
    final row = flattenedData.row;
    final column = flattenedData.column;
    final rowSpan = flattenedData.rowSpan;
    final columnSpan = flattenedData.columnSpan;
    final tableData = Data.of<_ResizableTableData>(context);
    final widthMode = tableData.cellWidthResizeMode;
    final heightMode = tableData.cellHeightResizeMode;
    final theme = Theme.of(context);
    return Stack(
      children: [
        // top
        if (row > 0 && heightMode != TableCellResizeMode.none)
          Positioned(
            top: -thickness / 2,
            left: 0,
            right: 0,
            height: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeRow,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, row - 1, Axis.horizontal);
              },
              onExit: (event) {
                widget.onHover(false, row - 1, Axis.horizontal);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: _onDragStartRow,
                onVerticalDragUpdate: (details) {
                  if (heightMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(row - 1, row, details);
                  } else {
                    widget.controller.resizeRow(
                        row - 1,
                        widget.controller.getRowHeight(row - 1) +
                            details.primaryDelta!);
                  }
                },
                onVerticalDragEnd: _onDragEnd,
                onVerticalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  // valueListenable: widget.hoverNotifier,
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color: (hover?.index == row - 1 &&
                                  hover?.direction == Axis.horizontal) ||
                              (drag?.index == row - 1 &&
                                  drag?.direction == Axis.horizontal)
                          ? widget.theme?.resizerColor ??
                              theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        // bottom
        if ((row + rowSpan <= tableData.maxRow ||
                heightMode == TableCellResizeMode.expand) &&
            heightMode != TableCellResizeMode.none)
          Positioned(
            bottom: -thickness / 2,
            left: 0,
            right: 0,
            height: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeRow,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, row + rowSpan - 1, Axis.horizontal);
              },
              onExit: (event) {
                widget.onHover(false, row + rowSpan - 1, Axis.horizontal);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: _onDragStartRow,
                onVerticalDragUpdate: (details) {
                  if (heightMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(row + rowSpan - 1, row + rowSpan, details);
                  } else {
                    widget.controller.resizeRow(
                        row + rowSpan - 1,
                        widget.controller.getRowHeight(row + rowSpan - 1) +
                            details.primaryDelta!);
                  }
                },
                onVerticalDragEnd: _onDragEnd,
                onVerticalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color: (hover?.index == row + rowSpan - 1 &&
                                  hover?.direction == Axis.horizontal) ||
                              (drag?.index == row + rowSpan - 1 &&
                                  drag?.direction == Axis.horizontal)
                          ? widget.theme?.resizerColor ??
                              theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        // left
        if (column > 0 && widthMode != TableCellResizeMode.none)
          Positioned(
            left: -thickness / 2,
            top: 0,
            bottom: 0,
            width: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, column - 1, Axis.vertical);
              },
              onExit: (event) {
                widget.onHover(false, column - 1, Axis.vertical);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: _onDragStartColumn,
                onHorizontalDragUpdate: (details) {
                  if (widthMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(column - 1, column, details);
                  } else {
                    widget.controller.resizeColumn(
                        column - 1,
                        widget.controller.getColumnWidth(column - 1) +
                            details.primaryDelta!);
                  }
                },
                onHorizontalDragEnd: _onDragEnd,
                onHorizontalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color: (hover?.index == column - 1 &&
                                  hover?.direction == Axis.vertical) ||
                              (drag?.index == column - 1 &&
                                  drag?.direction == Axis.vertical)
                          ? widget.theme?.resizerColor ??
                              theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        // right
        if ((column + columnSpan <= tableData.maxColumn ||
                widthMode == TableCellResizeMode.expand) &&
            widthMode != TableCellResizeMode.none)
          Positioned(
            right: -thickness / 2,
            top: 0,
            bottom: 0,
            width: thickness,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              hitTestBehavior: HitTestBehavior.translucent,
              onEnter: (event) {
                widget.onHover(true, column + columnSpan - 1, Axis.vertical);
              },
              onExit: (event) {
                widget.onHover(false, column + columnSpan - 1, Axis.vertical);
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: _onDragStartColumn,
                onHorizontalDragUpdate: (details) {
                  if (widthMode == TableCellResizeMode.reallocate) {
                    _onDragUpdate(
                        column + columnSpan - 1, column + columnSpan, details);
                  } else {
                    widget.controller.resizeColumn(
                        column + columnSpan - 1,
                        widget.controller
                                .getColumnWidth(column + columnSpan - 1) +
                            details.primaryDelta!);
                  }
                },
                onHorizontalDragEnd: _onDragEnd,
                onHorizontalDragCancel: _onDragCancel,
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    widget.hoverNotifier,
                    widget.dragNotifier,
                  ]),
                  builder: (context, child) {
                    _HoveredLine? hover = widget.hoverNotifier.value;
                    _HoveredLine? drag = widget.dragNotifier.value;
                    if (drag != null) {
                      hover = null;
                    }
                    return Container(
                      color: (hover?.index == column + columnSpan - 1 &&
                                  hover?.direction == Axis.vertical) ||
                              (drag?.index == column + columnSpan - 1 &&
                                  drag?.direction == Axis.vertical)
                          ? widget.theme?.resizerColor ??
                              theme.colorScheme.primary
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}

abstract class _TableCellData {
  const _TableCellData();
  int get column;
  int get row;
  int get columnSpan;
  int get rowSpan;
  _TableCellData shift(int column, int row);
}

/// This will shift cell data if there are any overlapping cells due to column or row spans.
List<T> _reorganizeCells<T extends _TableCellData>(List<T> cells) {
  int maxColumn = 0;
  int maxRow = 0;

  Map<int, Map<int, _TableCellData>> cellMap = {}; // column -> row -> cell

  // find the maximum row and column
  for (final cell in cells) {
    maxColumn = max(maxColumn, cell.column + cell.columnSpan - 1);
    maxRow = max(maxRow, cell.row + cell.rowSpan - 1);
    cellMap.putIfAbsent(cell.column, () => {});
    cellMap[cell.column]![cell.row] = cell;
  }

  // shift from bottom right to top left
  for (int c = maxColumn; c >= 0; c--) {
    for (int r = maxRow; r >= 0; r--) {
      final cell = cellMap[c]?[r];
      if (cell != null) {
        // column span
        // shift to the right from end column to the current column + 1 (reverse)
        for (int i = maxColumn; i >= cell.column; i--) {
          final rightCell = cellMap[i]?[r];
          if (rightCell != null) {
            // repeat by rowSpan
            for (int row = r; row < r + cell.rowSpan; row++) {
              if (i == cell.column && row == r) {
                continue;
              }
              final rightCell = cellMap[i]?[row];
              if (rightCell != null) {
                // remove the cell from the map
                cellMap[i]!.remove(row);
                // shift the cell to the right (+ columnSpan)
                if (row != r) {
                  cellMap.putIfAbsent(i + cell.columnSpan, () => {});
                  cellMap[i + cell.columnSpan]![row] =
                      rightCell.shift(cell.columnSpan, 0);
                } else {
                  cellMap.putIfAbsent(i + cell.columnSpan - 1, () => {});
                  cellMap[i + cell.columnSpan - 1]![row] =
                      rightCell.shift(cell.columnSpan - 1, 0);
                }
              }
            }
          }
        }
      }
    }
  }

  List<T> result = [];
  for (final column in cellMap.values) {
    result.addAll(column.values.cast<T>());
  }
  return result;
}

class _HoveredCell {
  final int column;
  final int row;
  final int columnSpan;
  final int rowSpan;

  _HoveredCell(this.column, this.row, this.columnSpan, this.rowSpan);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _HoveredCell &&
        other.column == column &&
        other.row == row &&
        other.columnSpan == columnSpan &&
        other.rowSpan == rowSpan;
  }

  @override
  int get hashCode {
    return Object.hash(column, row, columnSpan, rowSpan);
  }

  bool intersects(_HoveredCell other, Axis expected) {
    if (other == this) {
      return true;
    }
    if (expected == Axis.vertical) {
      return column < other.column + other.columnSpan &&
          column + columnSpan > other.column;
    } else {
      return row < other.row + other.rowSpan && row + rowSpan > other.row;
    }
  }
}

/// Represents a single cell in a table.
///
/// Defines cell content, spanning behavior, and styling. Cells can span
/// multiple columns or rows, respond to hover interactions, and have
/// custom themes and background colors.
///
/// Example:
/// ```dart
/// TableCell(
///   columnSpan: 2,
///   rowSpan: 1,
///   child: Text('Spanning cell'),
///   rowHover: true,
///   backgroundColor: Colors.blue.shade50,
/// )
/// ```
class TableCell {
  /// Number of columns this cell spans. Defaults to 1.
  final int columnSpan;

  /// Number of rows this cell spans. Defaults to 1.
  final int rowSpan;

  /// The widget displayed in this cell.
  final Widget child;

  /// Whether to highlight this cell when hovering over its column.
  final bool columnHover;

  /// Whether to highlight this cell when hovering over its row.
  final bool rowHover;

  /// Background color for this cell. Overrides theme color.
  final Color? backgroundColor;

  /// Custom theme for this cell. Overrides table-level theme.
  final TableCellTheme? theme;

  /// Whether this cell responds to user interactions.
  final bool enabled;

  /// Creates a [TableCell].
  const TableCell({
    this.columnSpan = 1,
    this.rowSpan = 1,
    required this.child,
    this.backgroundColor,
    this.columnHover = false,
    this.rowHover = true,
    this.theme,
    this.enabled = true,
  });

  /// Builds the widget tree for this table cell.
  ///
  /// This method renders the cell with appropriate styling including:
  /// - Background color based on theme and state
  /// - Border styling with state resolution
  /// - Hover effects for column and row highlighting
  /// - Selection state visualization
  /// - Resize handles if the table is resizable
  ///
  /// The build process integrates with the table's hover system to provide
  /// visual feedback when the mouse hovers over cells in the same row or column.
  ///
  /// Returns a [Widget] representing the fully styled table cell.
  Widget build(BuildContext context) {
    final flattenedData = Data.of<_FlattenedTableCell>(context);
    final resizedData = Data.maybeOf<_ResizableTableData>(context);
    final resizedState = Data.maybeOf<_ResizableTableState>(context);
    final currentCell = _HoveredCell(
      flattenedData.column,
      flattenedData.row,
      flattenedData.columnSpan,
      flattenedData.rowSpan,
    );
    var theme = this.theme;
    var defaultTheme = flattenedData.tableCellThemeBuilder(context);
    final appTheme = Theme.of(context);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ColoredBox(
          color: backgroundColor ?? appTheme.colorScheme.background,
          child: MouseRegion(
            onEnter: (event) {
              if (flattenedData.enabled) {
                flattenedData.hoveredCellNotifier.value = currentCell;
              }
            },
            onExit: (event) {
              if (flattenedData.enabled) {
                if (flattenedData.hoveredCellNotifier.value == currentCell) {
                  flattenedData.hoveredCellNotifier.value = null;
                }
              }
            },
            child: ListenableBuilder(
              // valueListenable: flattenedData.hoveredCellNotifier,
              listenable: Listenable.merge([
                flattenedData.hoveredCellNotifier,
                flattenedData.dragNotifier,
              ]),
              builder: (context, child) {
                var hoveredCell = flattenedData.hoveredCellNotifier.value;
                var drag = flattenedData.dragNotifier?.value;
                if (drag != null) {
                  hoveredCell = null;
                }
                var resolvedStates = {
                  if (hoveredCell != null &&
                      ((columnHover &&
                              hoveredCell.intersects(
                                  currentCell, Axis.vertical)) ||
                          (rowHover &&
                              hoveredCell.intersects(
                                  currentCell, Axis.horizontal))))
                    WidgetState.hovered,
                  if (flattenedData.selected) WidgetState.selected,
                  if (!flattenedData.enabled) WidgetState.disabled,
                };
                return Container(
                  decoration: BoxDecoration(
                    border: theme?.border?.resolve(resolvedStates) ??
                        defaultTheme.border?.resolve(resolvedStates),
                    color: theme?.backgroundColor?.resolve(resolvedStates) ??
                        defaultTheme.backgroundColor?.resolve(resolvedStates),
                  ),
                  child: DefaultTextStyle.merge(
                    style: theme?.textStyle?.resolve(resolvedStates) ??
                        defaultTheme.textStyle?.resolve(resolvedStates),
                    child: child!,
                  ),
                );
              },
              child: child,
            ),
          ),
        ),
        if (resizedData != null && resizedState != null)
          Positioned.fill(
            child: _CellResizer(
                controller: resizedData.controller,
                onHover: resizedState._onHover,
                onDrag: resizedState._onDrag,
                hoverNotifier: resizedState._hoverNotifier,
                dragNotifier: resizedState._dragNotifier,
                maxRow: resizedState._maxRow,
                theme: resizedState.widget.theme,
                maxColumn: resizedState._maxColumn),
          )
      ],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableCell &&
        other.columnSpan == columnSpan &&
        other.rowSpan == rowSpan &&
        other.child == child &&
        other.theme == theme &&
        other.enabled == enabled &&
        other.columnHover == columnHover &&
        other.rowHover == rowHover &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return Object.hash(columnSpan, rowSpan, child, theme, enabled, columnHover,
        rowHover, backgroundColor);
  }
}

/// Function that builds a [TableCellTheme] based on context.
///
/// Used to provide dynamic theming for table cells based on
/// current build context and theme data.
typedef TableCellThemeBuilder = TableCellTheme Function(BuildContext context);

/// Represents a row in a table.
///
/// Contains a list of cells and optional styling for all cells in the row.
/// Can be marked as selected to highlight the entire row.
///
/// Example:
/// ```dart
/// TableRow(
///   cells: [
///     TableCell(child: Text('Cell 1')),
///     TableCell(child: Text('Cell 2')),
///   ],
///   selected: true,
///   cellTheme: TableCellTheme(...),
/// )
/// ```
class TableRow {
  /// The cells contained in this row.
  final List<TableCell> cells;

  /// Theme applied to all cells in this row.
  final TableCellTheme? cellTheme;

  /// Whether this row is selected.
  final bool selected;

  /// Creates a [TableRow].
  const TableRow({required this.cells, this.cellTheme, this.selected = false});

  /// Builds the default theme for cells in this row.
  ///
  /// Creates a [TableCellTheme] with default styling when no explicit [cellTheme]
  /// is provided. The default theme includes:
  /// - Border with bottom line using theme border color
  /// - Background color that changes to muted on hover
  /// - Text style that becomes muted when disabled
  ///
  /// The theme uses [WidgetStateProperty] to adapt styling based on cell state
  /// (hovered, selected, disabled).
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context for accessing theme data
  ///
  /// Returns [TableCellTheme] with default or custom cell styling.
  TableCellTheme buildDefaultTheme(BuildContext context) {
    if (cellTheme != null) {
      return cellTheme!;
    }
    final theme = Theme.of(context);
    return TableCellTheme(
      border: WidgetStateProperty.resolveWith(
        (states) {
          return Border(
            bottom: BorderSide(
              color: theme.colorScheme.border,
              width: 1,
            ),
          );
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.hovered)
              ? theme.colorScheme.muted.withValues(alpha: 0.5)
              : null;
        },
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) {
          return TextStyle(
            color: states.contains(WidgetState.disabled)
                ? theme.colorScheme.muted
                : null,
          );
        },
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableRow &&
        listEquals(other.cells, cells) &&
        other.cellTheme == cellTheme &&
        other.selected == selected;
  }

  @override
  int get hashCode {
    return Object.hash(cells, cellTheme, selected);
  }
}

/// Specialized row for table footers.
///
/// Extends [TableRow] with default styling appropriate for footer rows,
/// including muted background colors and custom hover effects.
///
/// Example:
/// ```dart
/// TableFooter(
///   cells: [
///     TableCell(child: Text('Total: \$100')),
///     TableCell(child: Text('Paid')),
///   ],
/// )
/// ```
class TableFooter extends TableRow {
  /// Creates a [TableFooter].
  const TableFooter({required super.cells, super.cellTheme});

  @override
  TableCellTheme buildDefaultTheme(BuildContext context) {
    if (cellTheme != null) {
      return cellTheme!;
    }
    final theme = Theme.of(context);
    return TableCellTheme(
      border: const WidgetStatePropertyAll(null),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.hovered)
              ? theme.colorScheme.muted
              : theme.colorScheme.muted.withValues(alpha: 0.5);
        },
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) {
          return TextStyle(
            color: states.contains(WidgetState.disabled)
                ? theme.colorScheme.muted
                : null,
          );
        },
      ),
    );
  }
}

/// Specialized row for table headers.
///
/// Extends [TableRow] with default styling appropriate for header rows,
/// including bold text, muted background, and bottom border styling.
///
/// Example:
/// ```dart
/// TableHeader(
///   cells: [
///     TableCell(child: Text('Name')),
///     TableCell(child: Text('Age')),
///     TableCell(child: Text('City')),
///   ],
/// )
/// ```
class TableHeader extends TableRow {
  /// Creates a [TableHeader].
  const TableHeader({required super.cells, super.cellTheme});

  @override
  TableCellTheme buildDefaultTheme(BuildContext context) {
    if (cellTheme != null) {
      return cellTheme!;
    }
    final theme = Theme.of(context);
    return TableCellTheme(
      border: WidgetStateProperty.resolveWith(
        (states) {
          return Border(
            bottom: BorderSide(
              color: theme.colorScheme.border,
              width: 1,
            ),
          );
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          return states.contains(WidgetState.hovered)
              ? theme.colorScheme.muted
              : theme.colorScheme.muted.withValues(alpha: 0.5);
        },
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) {
          return theme.typography.semiBold.merge(TextStyle(
            color: states.contains(WidgetState.disabled)
                ? theme.colorScheme.muted
                : null,
          ));
        },
      ),
    );
  }
}

class _FlattenedTableCell extends _TableCellData {
  @override
  final int column;
  @override
  final int row;
  @override
  final int columnSpan;
  @override
  final int rowSpan;
  final WidgetBuilder builder;
  final bool enabled;
  final ValueNotifier<_HoveredCell?> hoveredCellNotifier;
  final ValueNotifier<_HoveredLine?>? dragNotifier;
  final TableCellThemeBuilder tableCellThemeBuilder;
  final bool selected;

  _FlattenedTableCell({
    required this.column,
    required this.row,
    required this.columnSpan,
    required this.rowSpan,
    required this.builder,
    required this.enabled,
    required this.hoveredCellNotifier,
    required this.dragNotifier,
    required this.tableCellThemeBuilder,
    required this.selected,
  });

  @override
  _TableCellData shift(int column, int row) {
    return _FlattenedTableCell(
      column: this.column + column,
      row: this.row + row,
      columnSpan: columnSpan,
      rowSpan: rowSpan,
      builder: builder,
      enabled: enabled,
      hoveredCellNotifier: hoveredCellNotifier,
      tableCellThemeBuilder: tableCellThemeBuilder,
      selected: selected,
      dragNotifier: dragNotifier,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _FlattenedTableCell &&
        other.column == column &&
        other.row == row &&
        other.columnSpan == columnSpan &&
        other.rowSpan == rowSpan &&
        other.builder == builder &&
        other.enabled == enabled &&
        other.hoveredCellNotifier == hoveredCellNotifier &&
        other.dragNotifier == dragNotifier &&
        other.tableCellThemeBuilder == tableCellThemeBuilder &&
        other.selected == selected;
  }

  @override
  int get hashCode {
    return Object.hash(
      column,
      row,
      columnSpan,
      rowSpan,
      builder,
      enabled,
      hoveredCellNotifier,
      dragNotifier,
      tableCellThemeBuilder,
      selected,
    );
  }
}

/// A flexible table widget with support for spanning, scrolling, and interactive features.
///
/// [Table] provides a comprehensive table component with advanced layout capabilities
/// including cell spanning, flexible sizing, frozen cells, scrolling, and rich theming.
/// It supports both simple data tables and complex layouts with header/footer rows.
///
/// ## Key Features
/// - **Cell Spanning**: Support for colspan and rowspan across multiple cells
/// - **Flexible Sizing**: Multiple sizing strategies (fixed, flex, intrinsic) for columns/rows
/// - **Frozen Cells**: Ability to freeze specific cells during scrolling
/// - **Interactive States**: Hover effects and selection states with visual feedback
/// - **Scrolling**: Optional horizontal and vertical scrolling with viewport control
/// - **Theming**: Comprehensive theming system for visual customization
///
/// ## Layout System
/// The table uses a sophisticated layout system that handles:
/// - Variable column widths via [TableSize] strategies
/// - Dynamic row heights based on content
/// - Complex cell spanning calculations
/// - Efficient rendering with viewport culling
///
/// ## Sizing Strategies
/// - [FlexTableSize]: Proportional sizing like CSS flex
/// - [FixedTableSize]: Absolute pixel sizes
/// - [IntrinsicTableSize]: Size based on content
///
/// Example:
/// ```dart
/// Table(
///   rows: [
///     TableHeader(cells: [
///       TableCell(child: Text('Name')),
///       TableCell(child: Text('Age')),
///       TableCell(child: Text('City')),
///     ]),
///     TableRow(cells: [
///       TableCell(child: Text('John Doe')),
///       TableCell(child: Text('25')),
///       TableCell(child: Text('New York')),
///     ]),
///   ],
///   columnWidths: {
///     0: FlexTableSize(flex: 2),
///     1: FixedTableSize(width: 80),
///     2: FlexTableSize(flex: 1),
///   },
/// );
/// ```
class Table extends StatefulWidget {
  /// List of rows to display in the table.
  ///
  /// Type: `List<TableRow>`. Contains the table data organized as rows.
  /// Can include [TableRow], [TableHeader], and [TableFooter] instances.
  /// Each row contains a list of [TableCell] widgets.
  final List<TableRow> rows;

  /// Default sizing strategy for all columns.
  ///
  /// Type: `TableSize`. Used when no specific width is provided in
  /// [columnWidths]. Defaults to [FlexTableSize] for proportional sizing.
  final TableSize defaultColumnWidth;

  /// Default sizing strategy for all rows.
  ///
  /// Type: `TableSize`. Used when no specific height is provided in
  /// [rowHeights]. Defaults to [IntrinsicTableSize] for content-based sizing.
  final TableSize defaultRowHeight;

  /// Specific column width overrides.
  ///
  /// Type: `Map<int, TableSize>?`. Maps column indices to specific sizing
  /// strategies. Overrides [defaultColumnWidth] for specified columns.
  final Map<int, TableSize>? columnWidths;

  /// Specific row height overrides.
  ///
  /// Type: `Map<int, TableSize>?`. Maps row indices to specific sizing
  /// strategies. Overrides [defaultRowHeight] for specified rows.
  final Map<int, TableSize>? rowHeights;

  /// Clipping behavior for the table content.
  ///
  /// Type: `Clip`. Controls how content is clipped at table boundaries.
  /// Defaults to [Clip.hardEdge] for clean boundaries.
  final Clip clipBehavior;

  /// Theme configuration for the table appearance.
  ///
  /// Type: `TableTheme?`. Controls borders, colors, and overall styling.
  /// If null, uses the default theme from [ComponentTheme].
  final TableTheme? theme;

  /// Configuration for frozen cells during scrolling.
  ///
  /// Type: `FrozenTableData?`. Specifies which cells remain visible
  /// during horizontal or vertical scrolling. Useful for headers/footers.
  final FrozenTableData? frozenCells;

  /// Horizontal scroll offset for the table viewport.
  ///
  /// Type: `double?`. Controls horizontal scrolling position. If provided,
  /// the table displays within a scrollable viewport.
  final double? horizontalOffset;

  /// Vertical scroll offset for the table viewport.
  ///
  /// Type: `double?`. Controls vertical scrolling position. If provided,
  /// the table displays within a scrollable viewport.
  final double? verticalOffset;

  /// Size constraints for the table viewport.
  ///
  /// Type: `Size?`. When provided with scroll offsets, constrains the
  /// visible area of the table. Essential for scrolling behavior.
  final Size? viewportSize;

  /// Creates a [Table] widget.
  ///
  /// The table displays data organized in rows and cells with flexible
  /// sizing and interactive features.
  ///
  /// Parameters:
  /// - [rows] (`List<TableRow>`, required): Table data organized as rows
  /// - [defaultColumnWidth] (TableSize, default: FlexTableSize()): Default column sizing
  /// - [defaultRowHeight] (TableSize, default: IntrinsicTableSize()): Default row sizing
  /// - [columnWidths] (`Map<int, TableSize>?`, optional): Column-specific sizes
  /// - [rowHeights] (`Map<int, TableSize>?`, optional): Row-specific sizes
  /// - [clipBehavior] (Clip, default: Clip.hardEdge): Content clipping behavior
  /// - [theme] (TableTheme?, optional): Visual styling configuration
  /// - [frozenCells] (FrozenTableData?, optional): Frozen cell configuration
  /// - [horizontalOffset] (double?, optional): Horizontal scroll position
  /// - [verticalOffset] (double?, optional): Vertical scroll position
  /// - [viewportSize] (Size?, optional): Viewport size constraints
  ///
  /// Example:
  /// ```dart
  /// Table(
  ///   rows: [
  ///     TableHeader(cells: [TableCell(child: Text('Header'))]),
  ///     TableRow(cells: [TableCell(child: Text('Data'))]),
  ///   ],
  ///   columnWidths: {0: FixedTableSize(width: 200)},
  /// );
  /// ```
  const Table({
    super.key,
    required this.rows,
    this.defaultColumnWidth = const FlexTableSize(),
    this.defaultRowHeight = const IntrinsicTableSize(),
    this.columnWidths,
    this.rowHeights,
    this.clipBehavior = Clip.hardEdge,
    this.theme,
    this.frozenCells,
    this.horizontalOffset,
    this.verticalOffset,
    this.viewportSize,
  });

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  late List<_FlattenedTableCell> _cells;
  final ValueNotifier<_HoveredCell?> _hoveredCellNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _initCells();
  }

  @override
  void didUpdateWidget(covariant Table oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.rows, oldWidget.rows)) {
      _initCells();
    }
  }

  void _initCells() {
    _cells = [];
    for (int r = 0; r < widget.rows.length; r++) {
      final row = widget.rows[r];
      for (int c = 0; c < row.cells.length; c++) {
        final cell = row.cells[c];
        _cells.add(_FlattenedTableCell(
          column: c,
          row: r,
          columnSpan: cell.columnSpan,
          rowSpan: cell.rowSpan,
          builder: cell.build,
          enabled: cell.enabled,
          hoveredCellNotifier: _hoveredCellNotifier,
          dragNotifier: null,
          tableCellThemeBuilder: row.buildDefaultTheme,
          selected: row.selected,
        ));
      }
    }
    _cells = _reorganizeCells(_cells);
  }

  @override
  Widget build(BuildContext context) {
    TableTheme? tableTheme =
        widget.theme ?? ComponentTheme.maybeOf<TableTheme>(context);
    return Container(
      clipBehavior: widget.clipBehavior,
      decoration: BoxDecoration(
        border: tableTheme?.border,
        color: tableTheme?.backgroundColor,
        borderRadius: tableTheme?.borderRadius,
      ),
      child: RawTableLayout(
        clipBehavior: widget.clipBehavior,
        frozenColumn: widget.frozenCells?.testColumn,
        frozenRow: widget.frozenCells?.testRow,
        horizontalOffset: widget.horizontalOffset,
        verticalOffset: widget.verticalOffset,
        viewportSize: widget.viewportSize,
        width: (index) {
          if (widget.columnWidths != null) {
            return widget.columnWidths![index] ?? widget.defaultColumnWidth;
          }
          return widget.defaultColumnWidth;
        },
        height: (index) {
          if (widget.rowHeights != null) {
            return widget.rowHeights![index] ?? widget.defaultRowHeight;
          }
          return widget.defaultRowHeight;
        },
        children: _cells.map((cell) {
          return Data.inherit(
            data: cell,
            child: RawCell(
              column: cell.column,
              row: cell.row,
              columnSpan: cell.columnSpan,
              rowSpan: cell.rowSpan,
              child: Builder(builder: (context) {
                return cell.builder(context);
              }),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Reference to a table row or column by index and span.
///
/// Used to identify specific rows or columns in table layouts,
/// particularly for frozen/pinned row and column functionality.
///
/// Example:
/// ```dart
/// TableRef(0, 2) // References rows/columns 0 and 1
/// TableRef(5)    // References row/column 5 with span of 1
/// ```
class TableRef {
  /// Starting index of the reference.
  final int index;

  /// Number of rows/columns spanned. Defaults to 1.
  final int span;

  /// Creates a [TableRef].
  const TableRef(this.index, [this.span = 1]);

  /// Tests if this reference includes the given index and span.
  bool test(int index, int span) {
    return this.index <= index && this.index + this.span > index;
  }
}

/// Configuration for frozen (pinned) rows and columns in a table.
///
/// Specifies which rows and columns should remain fixed in place
/// during scrolling, useful for keeping headers or key columns visible.
///
/// Example:
/// ```dart
/// FrozenTableData(
///   frozenRows: [TableRef(0)],      // Freeze first row (header)
///   frozenColumns: [TableRef(0, 2)], // Freeze first two columns
/// )
/// ```
class FrozenTableData {
  /// Rows that should be frozen during vertical scrolling.
  final Iterable<TableRef> frozenRows;

  /// Columns that should be frozen during horizontal scrolling.
  final Iterable<TableRef> frozenColumns;

  /// Creates a [FrozenTableData].
  const FrozenTableData(
      {this.frozenRows = const [], this.frozenColumns = const []});

  /// Tests if a row at the given index and span is frozen.
  bool testRow(int index, int span) {
    for (final ref in frozenRows) {
      if (ref.test(index, span)) {
        return true;
      }
    }
    return false;
  }

  /// Tests if a column at the given index and span is frozen.
  bool testColumn(int index, int span) {
    for (final ref in frozenColumns) {
      if (ref.test(index, span)) {
        return true;
      }
    }
    return false;
  }
}

/// Parent data for table cell layout information.
///
/// Stores layout parameters for cells in a table including position,
/// span, and frozen state. Used internally by the table rendering system.
class TableParentData extends ContainerBoxParentData<RenderBox> {
  /// Column index of this cell.
  int? column;

  /// Row index of this cell.
  int? row;

  /// Number of columns this cell spans.
  int? columnSpan;

  /// Number of rows this cell spans.
  int? rowSpan;

  /// Whether to compute size for this cell.
  bool computeSize = true;

  /// Whether this cell's row is frozen.
  bool frozenRow = false;

  /// Whether this cell's column is frozen.
  bool frozenColumn = false;
}

/// Low-level widget for positioning cells in table layouts.
///
/// Sets parent data for a table cell widget. Used internally by
/// table implementations to manage cell positioning and spanning.
///
/// Example:
/// ```dart
/// RawCell(
///   column: 0,
///   row: 1,
///   columnSpan: 2,
///   child: Container(...),
/// )
/// ```
class RawCell extends ParentDataWidget<TableParentData> {
  /// Column index for this cell.
  final int column;

  /// Row index for this cell.
  final int row;

  /// Number of columns spanned. Defaults to 1.
  final int? columnSpan;

  /// Number of rows spanned. Defaults to 1.
  final int? rowSpan;

  /// Whether to compute size for this cell.
  final bool computeSize;

  /// Creates a [RawCell].
  const RawCell({
    super.key,
    required this.column,
    required this.row,
    this.columnSpan,
    this.rowSpan,
    this.computeSize = true,
    required super.child,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as TableParentData;
    bool needsLayout = false;
    if (parentData.column != column) {
      parentData.column = column;
      needsLayout = true;
    }
    if (parentData.row != row) {
      parentData.row = row;
      needsLayout = true;
    }
    if (parentData.columnSpan != columnSpan) {
      parentData.columnSpan = columnSpan;
      needsLayout = true;
    }
    if (parentData.rowSpan != rowSpan) {
      parentData.rowSpan = rowSpan;
      needsLayout = true;
    }
    if (parentData.computeSize != computeSize) {
      parentData.computeSize = computeSize;
      needsLayout = true;
    }
    if (needsLayout) {
      final table = renderObject.parent as RenderTableLayout;
      table.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => RawTableLayout;
}

/// Base class for table sizing strategies.
///
/// Abstract class that defines how table columns and rows should be sized.
/// Implementations include fixed, flexible, and intrinsic sizing modes.
abstract class TableSize {
  /// Creates a [TableSize].
  const TableSize();
}

/// Table size mode that distributes available space using flex factors.
///
/// Similar to Flutter's [Flexible] widget, allocates space proportionally
/// based on the flex value. Used for responsive column/row sizing.
///
/// Example:
/// ```dart
/// FlexTableSize(flex: 2.0, fit: FlexFit.tight)
/// ```
class FlexTableSize extends TableSize {
  /// Flex factor for space distribution. Defaults to 1.
  final double flex;

  /// How the space should be allocated. Defaults to tight.
  final FlexFit fit;

  /// Creates a [FlexTableSize].
  const FlexTableSize({this.flex = 1, this.fit = FlexFit.tight});
}

/// Table size mode with a fixed pixel value.
///
/// Allocates a specific fixed size regardless of available space.
/// Used for columns/rows that should maintain a constant size.
///
/// Example:
/// ```dart
/// FixedTableSize(150.0) // 150 pixels
/// ```
class FixedTableSize extends TableSize {
  /// The fixed size value in pixels.
  final double value;

  /// Creates a [FixedTableSize] with the specified pixel value.
  const FixedTableSize(this.value);
}

/// Table size mode that uses the intrinsic size of cell content.
///
/// Sizes the column/row based on the natural size of its content.
/// May be expensive for large tables as it requires measuring content.
///
/// Example:
/// ```dart
/// IntrinsicTableSize() // Size based on content
/// ```
class IntrinsicTableSize extends TableSize {
  /// Creates an [IntrinsicTableSize].
  const IntrinsicTableSize();
}

/// Predicate function to test if a cell matches certain criteria.
///
/// Used internally for filtering and testing cells based on their
/// index and span values.
typedef CellPredicate = bool Function(int index, int span);

/// Low-level table layout widget.
///
/// Provides raw table layout functionality with support for frozen rows/columns
/// and scrolling. Used internally by higher-level table widgets.
///
/// Example:
/// ```dart
/// RawTableLayout(
///   width: (index) => FlexTableSize(),
///   height: (index) => FixedTableSize(50),
///   clipBehavior: Clip.hardEdge,
///   children: [...],
/// )
/// ```
class RawTableLayout extends MultiChildRenderObjectWidget {
  /// Creates a [RawTableLayout].
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, optional): Table cell widgets.
  /// - [width] (`TableSizeSupplier`, required): Column width supplier.
  /// - [height] (`TableSizeSupplier`, required): Row height supplier.
  /// - [clipBehavior] (`Clip`, required): Content clipping behavior.
  /// - [frozenColumn] (`CellPredicate?`, optional): Frozen column predicate.
  /// - [frozenRow] (`CellPredicate?`, optional): Frozen row predicate.
  /// - [verticalOffset] (`double?`, optional): Vertical scroll offset.
  /// - [horizontalOffset] (`double?`, optional): Horizontal scroll offset.
  /// - [viewportSize] (`Size?`, optional): Viewport size for scrolling.
  const RawTableLayout({
    super.key,
    super.children,
    required this.width,
    required this.height,
    required this.clipBehavior,
    this.frozenColumn,
    this.frozenRow,
    this.verticalOffset,
    this.horizontalOffset,
    this.viewportSize,
  });

  /// Supplier function for column widths.
  final TableSizeSupplier width;

  /// Supplier function for row heights.
  final TableSizeSupplier height;

  /// How content should be clipped.
  final Clip clipBehavior;

  /// Predicate for determining frozen columns.
  final CellPredicate? frozenColumn;

  /// Predicate for determining frozen rows.
  final CellPredicate? frozenRow;

  /// Vertical scroll offset.
  final double? verticalOffset;

  /// Horizontal scroll offset.
  final double? horizontalOffset;

  /// Size of the visible viewport.
  final Size? viewportSize;

  @override
  RenderTableLayout createRenderObject(BuildContext context) {
    return RenderTableLayout(
        width: width,
        height: height,
        clipBehavior: clipBehavior,
        frozenCell: frozenColumn,
        frozenRow: frozenRow,
        verticalOffset: verticalOffset,
        horizontalOffset: horizontalOffset,
        viewportSize: viewportSize);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderTableLayout renderObject) {
    bool needsRelayout = false;
    if (renderObject._width != width) {
      renderObject._width = width;
      needsRelayout = true;
    }
    if (renderObject._height != height) {
      renderObject._height = height;
      needsRelayout = true;
    }
    if (renderObject._clipBehavior != clipBehavior) {
      renderObject._clipBehavior = clipBehavior;
      needsRelayout = true;
    }
    if (renderObject._frozenColumn != frozenColumn) {
      renderObject._frozenColumn = frozenColumn;
      needsRelayout = true;
    }
    if (renderObject._frozenRow != frozenRow) {
      renderObject._frozenRow = frozenRow;
      needsRelayout = true;
    }
    if (renderObject._verticalOffset != verticalOffset) {
      renderObject._verticalOffset = verticalOffset;
      needsRelayout = true;
    }
    if (renderObject._horizontalOffset != horizontalOffset) {
      renderObject._horizontalOffset = horizontalOffset;
      needsRelayout = true;
    }
    if (renderObject._viewportSize != viewportSize) {
      renderObject._viewportSize = viewportSize;
      needsRelayout = true;
    }
    if (needsRelayout) {
      renderObject.markNeedsLayout();
    }
  }
}

/// Function that provides a [TableSize] for a given index.
///
/// Used to dynamically determine column widths or row heights based
/// on the column/row index. Enables different sizing strategies for
/// different parts of the table.
///
/// Example:
/// ```dart
/// TableSizeSupplier widthSupplier = (index) {
///   if (index == 0) return FixedTableSize(50);
///   return FlexTableSize(flex: 1);
/// };
/// ```
typedef TableSizeSupplier = TableSize Function(int index);

/// Custom render object for laying out table cells with advanced features.
///
/// Provides a sophisticated table layout system with support for:
/// - Flexible and fixed column widths and row heights
/// - Frozen columns and rows (sticky headers/footers)
/// - Viewport-based scrolling and clipping
/// -Span cells (cells that span multiple columns/rows)
/// - Dynamic sizing based on content or constraints
///
/// This render object handles the complex layout calculations needed for
/// tables with variable-sized cells, scrolling, and frozen regions.
///
/// See also:
/// - [TableSize], which defines sizing strategies for columns and rows
/// - [TableLayoutResult], which contains the computed layout dimensions
class RenderTableLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, TableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  TableSizeSupplier _width;
  TableSizeSupplier _height;
  Clip _clipBehavior;
  CellPredicate? _frozenColumn;
  CellPredicate? _frozenRow;
  double? _verticalOffset;
  double? _horizontalOffset;
  Size? _viewportSize;

  TableLayoutResult? _layoutResult;

  /// Creates a render object for table layout.
  ///
  /// Initializes the table layout system with sizing functions and optional
  /// frozen cell configurations. This render object handles the complex
  /// layout calculations for tables with variable cell sizes.
  ///
  /// Parameters:
  /// - [children] (`List<RenderBox>?`): Optional initial child render boxes
  /// - [width] (TableSizeSupplier, required): Function providing width for each column
  /// - [height] (TableSizeSupplier, required): Function providing height for each row
  /// - [clipBehavior] (Clip, required): How to clip children outside table bounds
  /// - [frozenCell] (CellPredicate?): Predicate identifying frozen columns
  /// - [frozenRow] (CellPredicate?): Predicate identifying frozen rows
  /// - [verticalOffset] (double?): Vertical scroll offset for viewport
  /// - [horizontalOffset] (double?): Horizontal scroll offset for viewport
  /// - [viewportSize] (Size?): Size of the visible viewport area
  ///
  /// Frozen cells remain visible during scrolling, useful for sticky headers.
  RenderTableLayout(
      {List<RenderBox>? children,
      required TableSizeSupplier width,
      required TableSizeSupplier height,
      required Clip clipBehavior,
      CellPredicate? frozenCell,
      CellPredicate? frozenRow,
      double? verticalOffset,
      double? horizontalOffset,
      Size? viewportSize})
      : _clipBehavior = clipBehavior,
        _width = width,
        _height = height,
        _frozenColumn = frozenCell,
        _frozenRow = frozenRow,
        _verticalOffset = verticalOffset,
        _horizontalOffset = horizontalOffset,
        _viewportSize = viewportSize {
    addAll(children);
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! TableParentData) {
      child.parentData = TableParentData();
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // reverse hit test traversal so that the first child is hit tested last
    // important for column and row spans
    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      final hit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          return child!.hitTest(result, position: transformed);
        },
      );
      if (hit) {
        return true;
      }
      child = childAfter(child);
    }
    return false;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return computeTableSize(BoxConstraints.loose(Size(double.infinity, height)),
        (child, extent) {
      return child.getMinIntrinsicWidth(extent);
    }).width;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return computeTableSize(constraints).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // reverse paint traversal so that the first child is painted last
    // important for column and row spans
    // (ASSUMPTION: children are already sorted in the correct order)
    if (_clipBehavior != Clip.none) {
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        (context, offset) {
          RenderBox? child = lastChild;
          while (child != null) {
            final parentData = child.parentData as TableParentData;
            if (parentData.computeSize &&
                !parentData.frozenRow &&
                !parentData.frozenColumn) {
              context.paintChild(child, offset + parentData.offset);
            }
            child = childBefore(child);
          }
        },
        clipBehavior: _clipBehavior,
      );
      RenderBox? child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (!parentData.computeSize &&
            !parentData.frozenRow &&
            !parentData.frozenColumn) {
          context.paintChild(child, offset + parentData.offset);
        }
        child = childBefore(child);
      }
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        (context, offset) {
          RenderBox? child = lastChild;
          while (child != null) {
            final parentData = child.parentData as TableParentData;
            if (parentData.frozenColumn) {
              context.paintChild(child, offset + parentData.offset);
            }
            child = childBefore(child);
          }
        },
        clipBehavior: _clipBehavior,
      );
      context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        (context, offset) {
          RenderBox? child = lastChild;
          while (child != null) {
            final parentData = child.parentData as TableParentData;
            if (parentData.frozenRow) {
              context.paintChild(child, offset + parentData.offset);
            }
            child = childBefore(child);
          }
        },
        clipBehavior: _clipBehavior,
      );
      child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (!parentData.computeSize && (parentData.frozenColumn)) {
          context.paintChild(child, offset + parentData.offset);
        }
        child = childBefore(child);
      }
      child = lastChild;
      while (child != null) {
        final parentData = child.parentData as TableParentData;
        if (!parentData.computeSize && (parentData.frozenRow)) {
          context.paintChild(child, offset + parentData.offset);
        }
        child = childBefore(child);
      }
      return;
    }
    RenderBox? child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (!parentData.frozenRow && !parentData.frozenColumn) {
        context.paintChild(child, offset + parentData.offset);
      }
      child = childBefore(child);
    }
    child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.frozenColumn) {
        context.paintChild(child, offset + parentData.offset);
      }
      child = childBefore(child);
    }
    child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.frozenRow) {
        context.paintChild(child, offset + parentData.offset);
      }
      child = childBefore(child);
    }
  }

  @override
  void performLayout() {
    final result = computeTableSize(constraints);
    size = constraints.constrain(result.size);

    Map<int, double> frozenRows = {};
    Map<int, double> frozenColumns = {};

    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      final column = parentData.column;
      final row = parentData.row;
      if (column != null && row != null) {
        double width = 0;
        double height = 0;
        int columnSpan = parentData.columnSpan ?? 1;
        int rowSpan = parentData.rowSpan ?? 1;
        bool frozenRow = _frozenRow?.call(row, rowSpan) ?? false;
        bool frozenColumn = _frozenColumn?.call(column, columnSpan) ?? false;
        for (int i = 0;
            i < columnSpan && column + i < result.columnWidths.length;
            i++) {
          width += result.columnWidths[column + i];
        }
        for (int i = 0;
            i < rowSpan && row + i < result.rowHeights.length;
            i++) {
          height += result.rowHeights[row + i];
        }
        child.layout(BoxConstraints.tightFor(width: width, height: height));
        final offset = result.getOffset(column, row);
        double offsetX = offset.dx;
        double offsetY = offset.dy;
        if (frozenRow) {
          double verticalOffset = _verticalOffset ?? 0;
          verticalOffset = max(0, verticalOffset);
          if (_viewportSize != null) {
            double maxVerticalOffset = size.height - _viewportSize!.height;
            verticalOffset = min(verticalOffset, maxVerticalOffset);
          }
          double offsetInViewport = offsetY - verticalOffset;
          // make sure its visible on the viewport
          double minViewport = 0;
          double maxViewport = constraints.minHeight;
          for (int i = 0; i < row; i++) {
            var rowHeight = frozenRows[i] ?? 0;
            minViewport += rowHeight;
          }
          double verticalAdjustment = 0;
          if (offsetInViewport < minViewport) {
            verticalAdjustment = -offsetInViewport + minViewport;
          } else if (offsetInViewport + height > maxViewport) {
            verticalAdjustment = maxViewport - offsetInViewport - height;
          }
          frozenRows[row] = max(frozenRows[row] ?? 0, height);
          offsetY += verticalAdjustment;
        }
        if (frozenColumn) {
          double horizontalOffset = _horizontalOffset ?? 0;
          horizontalOffset = max(0, horizontalOffset);
          if (_viewportSize != null) {
            double maxHorizontalOffset = size.width - _viewportSize!.width;
            horizontalOffset = min(horizontalOffset, maxHorizontalOffset);
          }
          double offsetInViewport = offsetX - horizontalOffset;
          // make sure its visible on the viewport
          double minViewport = 0;
          double maxViewport = constraints.minWidth;
          for (int i = 0; i < column; i++) {
            var columnWidth = frozenColumns[i] ?? 0;
            minViewport += columnWidth;
          }
          double horizontalAdjustment = 0;
          if (offsetInViewport < minViewport) {
            horizontalAdjustment = -offsetInViewport + minViewport;
          } else if (offsetInViewport + width > maxViewport) {
            horizontalAdjustment = maxViewport - offsetInViewport - width;
          }
          frozenColumns[column] = max(frozenColumns[column] ?? 0, width);
          offsetX += horizontalAdjustment;
        }
        parentData.frozenRow = frozenRow;
        parentData.frozenColumn = frozenColumn;
        parentData.offset = Offset(offsetX, offsetY);
        child = childAfter(child);
      }
    }

    _layoutResult = result;
  }

  /// Computes the table layout with specified constraints.
  ///
  /// Performs the complex table layout algorithm that:
  /// 1. Determines maximum row and column counts from child cells
  /// 2. Calculates fixed and flexible sizing for all columns and rows
  /// 3. Distributes available space among flex items
  /// 4. Handles both tight and loose flex constraints
  /// 5. Computes final dimensions for each column and row
  ///
  /// The layout algorithm respects size constraints from [TableSize] objects
  /// and ensures cells spanning multiple columns/rows are properly handled.
  ///
  /// Parameters:
  /// - [constraints] (BoxConstraints, required): Layout constraints for the table
  /// - [intrinsicComputer] (IntrinsicComputer?): Optional function to compute intrinsic sizes
  ///
  /// Returns [TableLayoutResult] containing computed dimensions and layout metadata.
  TableLayoutResult computeTableSize(BoxConstraints constraints,
      [IntrinsicComputer? intrinsicComputer]) {
    double flexWidth = 0;
    double flexHeight = 0;
    double fixedWidth = 0;
    double fixedHeight = 0;

    Map<int, double> columnWidths = {};
    Map<int, double> rowHeights = {};

    int maxRow = 0;
    int maxColumn = 0;

    bool hasTightFlexWidth = false;
    bool hasTightFlexHeight = false;

    // find the maximum row and column
    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.computeSize) {
        int? column = parentData.column;
        int? row = parentData.row;
        if (column != null && row != null) {
          int columnSpan = parentData.columnSpan ?? 1;
          int rowSpan = parentData.rowSpan ?? 1;
          maxColumn = max(maxColumn, column + columnSpan - 1);
          maxRow = max(maxRow, row + rowSpan - 1);
        }
      }
      child = childAfter(child);
    }

    // micro-optimization: avoid calculating flexes if there are no flexes
    bool hasFlexWidth = false;
    bool hasFlexHeight = false;

    // row
    for (int r = 0; r <= maxRow; r++) {
      final heightConstraint = _height(r);
      if (heightConstraint is FlexTableSize &&
          constraints.hasBoundedHeight &&
          intrinsicComputer == null) {
        flexHeight += heightConstraint.flex;
        hasFlexHeight = true;
        if (heightConstraint.fit == FlexFit.tight) {
          hasTightFlexHeight = true;
        }
      } else if (heightConstraint is FixedTableSize) {
        fixedHeight += heightConstraint.value;
        rowHeights[r] = max(rowHeights[r] ?? 0, heightConstraint.value);
      }
    }
    // column
    for (int c = 0; c <= maxColumn; c++) {
      final widthConstraint = _width(c);
      if (widthConstraint is FlexTableSize && constraints.hasBoundedWidth) {
        flexWidth += widthConstraint.flex;
        hasFlexWidth = true;
        if (widthConstraint.fit == FlexFit.tight) {
          hasTightFlexWidth = true;
        }
      } else if (widthConstraint is FixedTableSize) {
        fixedWidth += widthConstraint.value;
        columnWidths[c] = max(columnWidths[c] ?? 0, widthConstraint.value);
      }
    }

    double spacePerFlexWidth = 0;
    double spacePerFlexHeight = 0;
    double remainingWidth;
    double remainingHeight;
    if (constraints.hasBoundedWidth) {
      remainingWidth = constraints.maxWidth - fixedWidth;
    } else {
      remainingWidth = double.infinity;
    }
    if (constraints.hasBoundedHeight) {
      remainingHeight = constraints.maxHeight - fixedHeight;
    } else {
      remainingHeight = double.infinity;
    }

    // find the proper intrinsic sizes (if any)
    child = lastChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      if (parentData.computeSize) {
        int? column = parentData.column;
        int? row = parentData.row;
        if (column != null && row != null) {
          final widthConstraint = _width(column);
          final heightConstraint = _height(row);
          if (widthConstraint is IntrinsicTableSize ||
              (widthConstraint is FlexTableSize && intrinsicComputer != null)) {
            var extent = rowHeights[row] ?? remainingHeight;
            double maxIntrinsicWidth = intrinsicComputer != null
                ? intrinsicComputer(child, extent)
                : child.getMaxIntrinsicWidth(extent);
            maxIntrinsicWidth = min(maxIntrinsicWidth, remainingWidth);
            int columnSpan = parentData.columnSpan ?? 1;
            // distribute the intrinsic width to all columns
            maxIntrinsicWidth = maxIntrinsicWidth / columnSpan;
            for (int i = 0; i < columnSpan; i++) {
              columnWidths[column + i] =
                  max(columnWidths[column + i] ?? 0, maxIntrinsicWidth);
            }
          }
          if (heightConstraint is IntrinsicTableSize ||
              (heightConstraint is FlexTableSize &&
                  intrinsicComputer != null)) {
            var extent = columnWidths[column] ?? remainingWidth;
            double maxIntrinsicHeight = intrinsicComputer != null
                ? intrinsicComputer(child, extent)
                : child.getMaxIntrinsicHeight(extent);
            maxIntrinsicHeight = min(maxIntrinsicHeight, remainingHeight);
            int rowSpan = parentData.rowSpan ?? 1;
            // distribute the intrinsic height to all rows
            maxIntrinsicHeight = maxIntrinsicHeight / rowSpan;
            for (int i = 0; i < rowSpan; i++) {
              rowHeights[row + i] =
                  max(columnWidths[row + i] ?? 0, maxIntrinsicHeight);
            }
          }
        }
      }
      child = childBefore(child);
    }

    double usedColumnWidth = columnWidths.values.fold(0, (a, b) => a + b);
    double usedRowHeight = rowHeights.values.fold(0, (a, b) => a + b);
    double looseRemainingWidth = remainingWidth;
    double looseRemainingHeight = remainingHeight;
    double looseSpacePerFlexWidth = 0;
    double looseSpacePerFlexHeight = 0;

    if (intrinsicComputer == null) {
      // recalculate remaining space for flexes
      if (constraints.hasBoundedWidth) {
        remainingWidth = constraints.maxWidth - usedColumnWidth;
      } else {
        remainingWidth = double.infinity;
      }
      if (constraints.hasInfiniteWidth) {
        looseRemainingWidth = double.infinity;
      } else {
        looseRemainingWidth = max(0, constraints.minWidth - usedColumnWidth);
      }
      if (constraints.hasBoundedHeight) {
        remainingHeight = constraints.maxHeight - usedRowHeight;
      } else {
        remainingHeight = double.infinity;
      }
      if (constraints.hasInfiniteHeight) {
        looseRemainingHeight = double.infinity;
      } else {
        looseRemainingHeight = max(0, constraints.minHeight - usedRowHeight);
      }
      if (flexWidth > 0 && remainingWidth > 0) {
        spacePerFlexWidth = remainingWidth / flexWidth;
      } else {
        spacePerFlexWidth = 0;
      }
      if (flexWidth > 0 && looseRemainingWidth > 0) {
        looseSpacePerFlexWidth = looseRemainingWidth / flexWidth;
      }
      if (flexHeight > 0 && remainingHeight > 0) {
        spacePerFlexHeight = remainingHeight / flexHeight;
      } else {
        spacePerFlexHeight = 0;
      }
      if (flexHeight > 0 && looseRemainingHeight > 0) {
        spacePerFlexHeight = looseRemainingHeight / flexHeight;
      }

      // calculate space used for flexes
      if (hasFlexWidth) {
        for (int c = 0; c <= maxColumn; c++) {
          final widthConstraint = _width(c);
          if (widthConstraint is FlexTableSize) {
            // columnWidths[c] = widthConstraint.flex * spacePerFlexWidth;
            if (widthConstraint.fit == FlexFit.tight || hasTightFlexWidth) {
              columnWidths[c] = widthConstraint.flex * spacePerFlexWidth;
            } else {
              columnWidths[c] = widthConstraint.flex * looseSpacePerFlexWidth;
            }
          }
        }
      }
      if (hasFlexHeight) {
        for (int r = 0; r <= maxRow; r++) {
          final heightConstraint = _height(r);
          if (heightConstraint is FlexTableSize) {
            // rowHeights[r] = heightConstraint.flex * spacePerFlexHeight;
            if (heightConstraint.fit == FlexFit.tight || hasTightFlexHeight) {
              rowHeights[r] = heightConstraint.flex * spacePerFlexHeight;
            } else {
              rowHeights[r] = heightConstraint.flex * looseSpacePerFlexHeight;
            }
          }
        }
      }
    }

    // convert the column widths and row heights to a list, where missing values are 0
    List<double> columnWidthsList = List.generate(maxColumn + 1, (index) {
      return columnWidths[index] ?? 0;
    });
    columnWidths.forEach((key, value) {
      columnWidthsList[key] = value;
    });
    List<double> rowHeightsList =
        // List.filled(rowHeights.keys.reduce(max) + 1, 0);
        List.generate(maxRow + 1, (index) {
      return rowHeights[index] ?? 0;
    });
    rowHeights.forEach((key, value) {
      rowHeightsList[key] = value;
    });
    return TableLayoutResult(
      columnWidths: columnWidthsList,
      rowHeights: rowHeightsList,
      remainingWidth: remainingWidth,
      remainingHeight: remainingHeight,
      remainingLooseWidth: looseRemainingWidth,
      remainingLooseHeight: looseRemainingHeight,
      hasTightFlexWidth: hasTightFlexWidth,
      hasTightFlexHeight: hasTightFlexHeight,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return computeTableSize(BoxConstraints.loose(Size(double.infinity, height)),
        (child, extent) {
      return child.getMaxIntrinsicWidth(extent);
    }).width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return computeTableSize(BoxConstraints.loose(Size(width, double.infinity)),
        (child, extent) {
      return child.getMinIntrinsicHeight(extent);
    }).height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeTableSize(BoxConstraints.loose(Size(width, double.infinity)),
        (child, extent) {
      return child.getMaxIntrinsicHeight(extent);
    }).height;
  }

  // delegate from TableLayoutResult, with read-only view
  /// Gets an unmodifiable list of computed column widths.
  ///
  /// Returns the width of each column after layout calculation. The list
  /// index corresponds to the column index, and the value is the width in
  /// logical pixels.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns an unmodifiable `List<double>` of column widths.
  List<double> get columnWidths {
    assert(_layoutResult != null, 'Layout result is not available');
    return List.unmodifiable(_layoutResult!.columnWidths);
  }

  /// Gets an unmodifiable list of computed row heights.
  ///
  /// Returns the height of each row after layout calculation. The list
  /// index corresponds to the row index, and the value is the height in
  /// logical pixels.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns an unmodifiable `List<double>` of row heights.
  List<double> get rowHeights {
    assert(_layoutResult != null, 'Layout result is not available');
    return List.unmodifiable(_layoutResult!.rowHeights);
  }

  /// Gets the top-left offset of a cell at the specified position.
  ///
  /// Calculates the cumulative offset by summing the widths of all columns
  /// before the specified column and heights of all rows before the specified row.
  ///
  /// Parameters:
  /// - [column] (int, required): Zero-based column index
  /// - [row] (int, required): Zero-based row index
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns [Offset] representing the cell's top-left corner position.
  Offset getOffset(int column, int row) {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.getOffset(column, row);
  }

  /// Gets the remaining unclaimed width in the table layout.
  ///
  /// This represents horizontal space not allocated to any column after
  /// fixed and flex sizing calculations. Useful for understanding how much
  /// space is available for expansion or debugging layout issues.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining width in logical pixels as a double.
  double get remainingWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingWidth;
  }

  /// Gets the remaining unclaimed height in the table layout.
  ///
  /// This represents vertical space not allocated to any row after
  /// fixed and flex sizing calculations. Useful for understanding how much
  /// space is available for expansion or debugging layout issues.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining height in logical pixels as a double.
  double get remainingHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingHeight;
  }

  /// Gets the remaining loose (flexible) width available for loose flex items.
  ///
  /// Loose flex items can shrink below their flex allocation. This getter
  /// returns the remaining width available specifically for items with
  /// loose flex constraints (FlexFit.loose).
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining loose width in logical pixels as a double.
  double get remainingLooseWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingLooseWidth;
  }

  /// Gets the remaining loose (flexible) height available for loose flex items.
  ///
  /// Loose flex items can shrink below their flex allocation. This getter
  /// returns the remaining height available specifically for items with
  /// loose flex constraints (FlexFit.loose).
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining loose height in logical pixels as a double.
  double get remainingLooseHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingLooseHeight;
  }

  /// Indicates whether any column uses tight flex sizing.
  ///
  /// Tight flex items must occupy their full flex allocation. This getter
  /// returns true if at least one column has a tight flex constraint
  /// (FlexFit.tight), which affects how remaining space is distributed.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns true if table has tight flex width columns, false otherwise.
  bool get hasTightFlexWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.hasTightFlexWidth;
  }

  /// Indicates whether any row uses tight flex sizing.
  ///
  /// Tight flex items must occupy their full flex allocation. This getter
  /// returns true if at least one row has a tight flex constraint
  /// (FlexFit.tight), which affects how remaining space is distributed.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns true if table has tight flex height rows, false otherwise.
  bool get hasTightFlexHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.hasTightFlexHeight;
  }
}

/// Function that computes intrinsic dimensions for a render box.
///
/// Used internally during table layout to calculate natural sizes
/// of cells when using intrinsic sizing modes.
typedef IntrinsicComputer = double Function(RenderBox child, double extent);

/// Result of table layout calculations.
///
/// Contains computed column widths, row heights, and remaining space
/// information after layout. Used internally by the table rendering system.
class TableLayoutResult {
  /// Computed widths for each column.
  final List<double> columnWidths;

  /// Computed heights for each row.
  final List<double> rowHeights;

  /// Remaining width after layout.
  final double remainingWidth;

  /// Remaining height after layout.
  final double remainingHeight;

  /// Remaining loose width for flex items.
  final double remainingLooseWidth;

  /// Remaining loose height for flex items.
  final double remainingLooseHeight;

  /// Whether tight flex sizing is used for width.
  final bool hasTightFlexWidth;

  /// Whether tight flex sizing is used for height.
  final bool hasTightFlexHeight;

  /// Creates a [TableLayoutResult].
  TableLayoutResult({
    required this.columnWidths,
    required this.rowHeights,
    required this.remainingWidth,
    required this.remainingHeight,
    required this.remainingLooseWidth,
    required this.remainingLooseHeight,
    required this.hasTightFlexWidth,
    required this.hasTightFlexHeight,
  });

  /// Calculates the top-left offset of a cell at the given position.
  ///
  /// Computes the cumulative offset by summing all column widths before
  /// the target column and all row heights before the target row.
  ///
  /// Parameters:
  /// - [column] (int, required): Zero-based column index
  /// - [row] (int, required): Zero-based row index
  ///
  /// Returns [Offset] representing the cell's position relative to table origin.
  Offset getOffset(int column, int row) {
    double x = 0;
    for (int i = 0; i < column; i++) {
      x += columnWidths[i];
    }
    double y = 0;
    for (int i = 0; i < row; i++) {
      y += rowHeights[i];
    }
    return Offset(x, y);
  }

  /// Returns the sum of all column widths and row heights.
  Size get size {
    return Size(width, height);
  }

  /// Gets the total width of the table.
  ///
  /// Calculates the sum of all column widths to determine the table's
  /// total horizontal extent. This is the natural width the table would
  /// occupy without any constraints.
  ///
  /// Returns total table width in logical pixels as a double.
  double get width {
    return columnWidths.fold(0, (a, b) => a + b);
  }

  /// Gets the total height of the table.
  ///
  /// Calculates the sum of all row heights to determine the table's
  /// total vertical extent. This is the natural height the table would
  /// occupy without any constraints.
  ///
  /// Returns total table height in logical pixels as a double.
  double get height {
    return rowHeights.fold(0, (a, b) => a + b);
  }
}
