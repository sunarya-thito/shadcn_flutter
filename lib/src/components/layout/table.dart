import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';
import '../../resizer.dart';

class TableTheme {
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final TableCellTheme? cellTheme;

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

  TableTheme copyWith({
    Border? border,
    Color? backgroundColor,
    TableCellTheme? cellTheme,
  }) {
    return TableTheme(
      border: border ?? this.border,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cellTheme: cellTheme ?? this.cellTheme,
    );
  }
}

class ConstrainedTableSize {
  final double min;
  final double max;

  const ConstrainedTableSize({
    this.min = double.negativeInfinity,
    this.max = double.infinity,
  });
}

class TableCellTheme {
  final WidgetStateProperty<Border?>? border;
  final WidgetStateProperty<Color?>? backgroundColor;
  final WidgetStateProperty<TextStyle?>? textStyle;

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

  TableCellTheme copyWith({
    WidgetStateProperty<Border>? border,
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<TextStyle>? textStyle,
  }) {
    return TableCellTheme(
      border: border ?? this.border,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

class ResizableTableTheme {
  final TableTheme? tableTheme;
  final double? resizerThickness;
  final Color? resizerColor;

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

  ResizableTableTheme copyWith({
    TableTheme? tableTheme,
    double? resizerThickness,
    Color? resizerColor,
  }) {
    return ResizableTableTheme(
      tableTheme: tableTheme ?? this.tableTheme,
      resizerThickness: resizerThickness ?? this.resizerThickness,
      resizerColor: resizerColor ?? this.resizerColor,
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

class ResizableTableController extends ChangeNotifier {
  Map<int, double>? _columnWidths;
  Map<int, double>? _rowHeights;
  final double _defaultColumnWidth;
  final double _defaultRowHeight;
  final ConstrainedTableSize? _defaultWidthConstraint;
  final ConstrainedTableSize? _defaultHeightConstraint;
  final Map<int, ConstrainedTableSize>? _widthConstraints;
  final Map<int, ConstrainedTableSize>? _heightConstraints;

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

  Map<int, double>? get columnWidths => _columnWidths == null
      ? null
      : Map<int, double>.unmodifiable(_columnWidths!);

  Map<int, double>? get rowHeights =>
      _rowHeights == null ? null : Map<int, double>.unmodifiable(_rowHeights!);

  double getColumnWidth(int index) {
    return _columnWidths?[index] ?? _defaultColumnWidth;
  }

  double getRowHeight(int index) {
    return _rowHeights?[index] ?? _defaultRowHeight;
  }

  double? getRowMinHeight(int index) {
    return _heightConstraints?[index]?.min ?? _defaultHeightConstraint?.min;
  }

  double? getRowMaxHeight(int index) {
    return _heightConstraints?[index]?.max ?? _defaultHeightConstraint?.max;
  }

  double? getColumnMinWidth(int index) {
    return _widthConstraints?[index]?.min ?? _defaultWidthConstraint?.min;
  }

  double? getColumnMaxWidth(int index) {
    return _widthConstraints?[index]?.max ?? _defaultWidthConstraint?.max;
  }
}

enum TableCellResizeMode {
  /// The cell size will expand when resized
  expand,

  /// The cell size will expand when resized, but the other cells will shrink
  reallocate,

  /// Disables resizing
  none,
}

class ResizableTable extends StatefulWidget {
  final List<TableRow> rows;
  final ResizableTableController controller;
  final ResizableTableTheme? theme;
  final Clip clipBehavior;
  final TableCellResizeMode cellWidthResizeMode;
  final TableCellResizeMode cellHeightResizeMode;
  final FrozenTableData? frozenCells;
  final double? horizontalOffset;
  final double? verticalOffset;
  final Size? viewportSize;

  const ResizableTable({super.key, 
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

class TableCell {
  final int columnSpan;
  final int rowSpan;
  final Widget child;
  final bool columnHover;
  final bool rowHover;
  final Color? backgroundColor;
  final TableCellTheme? theme;
  final bool enabled;

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

typedef TableCellThemeBuilder = TableCellTheme Function(BuildContext context);

class TableRow {
  final List<TableCell> cells;
  final TableCellTheme? cellTheme;
  final bool selected;

  const TableRow({required this.cells, this.cellTheme, this.selected = false});

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

class TableFooter extends TableRow {
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

class TableHeader extends TableRow {
  const TableHeader({required cells, cellTheme})
      : super(cells: cells, cellTheme: cellTheme);

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

class Table extends StatefulWidget {
  final List<TableRow> rows;
  final TableSize defaultColumnWidth;
  final TableSize defaultRowHeight;
  final Map<int, TableSize>? columnWidths;
  final Map<int, TableSize>? rowHeights;
  final Clip clipBehavior;
  final TableTheme? theme;
  final FrozenTableData? frozenCells;
  final double? horizontalOffset;
  final double? verticalOffset;
  final Size? viewportSize;
  const Table({super.key, 
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

class TableRef {
  final int index;
  final int span;

  const TableRef(this.index, [this.span = 1]);

  bool test(int index, int span) {
    return this.index <= index && this.index + this.span > index;
  }
}

class FrozenTableData {
  final Iterable<TableRef> frozenRows;
  final Iterable<TableRef> frozenColumns;

  const FrozenTableData(
      {this.frozenRows = const [], this.frozenColumns = const []});

  bool testRow(int index, int span) {
    for (final ref in frozenRows) {
      if (ref.test(index, span)) {
        return true;
      }
    }
    return false;
  }

  bool testColumn(int index, int span) {
    for (final ref in frozenColumns) {
      if (ref.test(index, span)) {
        return true;
      }
    }
    return false;
  }
}

class TableParentData extends ContainerBoxParentData<RenderBox> {
  int? column;
  int? row;
  int? columnSpan;
  int? rowSpan;
  bool computeSize = true;
  bool frozenRow = false;
  bool frozenColumn = false;
}

class RawCell extends ParentDataWidget<TableParentData> {
  final int column;
  final int row;
  final int? columnSpan;
  final int? rowSpan;
  final bool computeSize;

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

abstract class TableSize {
  const TableSize();
}

class FlexTableSize extends TableSize {
  final double flex;
  final FlexFit fit;
  const FlexTableSize({this.flex = 1, this.fit = FlexFit.tight});
}

class FixedTableSize extends TableSize {
  final double value;
  const FixedTableSize(this.value);
}

class IntrinsicTableSize extends TableSize {
  const IntrinsicTableSize();
}

typedef CellPredicate = bool Function(int index, int span);

class RawTableLayout extends MultiChildRenderObjectWidget {
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

  final TableSizeSupplier width;
  final TableSizeSupplier height;
  final Clip clipBehavior;
  final CellPredicate? frozenColumn;
  final CellPredicate? frozenRow;
  final double? verticalOffset;
  final double? horizontalOffset;
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

typedef TableSizeSupplier = TableSize Function(int index);

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
  List<double> get columnWidths {
    assert(_layoutResult != null, 'Layout result is not available');
    return List.unmodifiable(_layoutResult!.columnWidths);
  }

  List<double> get rowHeights {
    assert(_layoutResult != null, 'Layout result is not available');
    return List.unmodifiable(_layoutResult!.rowHeights);
  }

  Offset getOffset(int column, int row) {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.getOffset(column, row);
  }

  double get remainingWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingWidth;
  }

  double get remainingHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingHeight;
  }

  double get remainingLooseWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingLooseWidth;
  }

  double get remainingLooseHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.remainingLooseHeight;
  }

  bool get hasTightFlexWidth {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.hasTightFlexWidth;
  }

  bool get hasTightFlexHeight {
    assert(_layoutResult != null, 'Layout result is not available');
    return _layoutResult!.hasTightFlexHeight;
  }
}

typedef IntrinsicComputer = double Function(RenderBox child, double extent);

class TableLayoutResult {
  final List<double> columnWidths;
  final List<double> rowHeights;
  final double remainingWidth;
  final double remainingHeight;
  final double remainingLooseWidth;
  final double remainingLooseHeight;
  final bool hasTightFlexWidth;
  final bool hasTightFlexHeight;

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

  double get width {
    return columnWidths.fold(0, (a, b) => a + b);
  }

  double get height {
    return rowHeights.fold(0, (a, b) => a + b);
  }
}
