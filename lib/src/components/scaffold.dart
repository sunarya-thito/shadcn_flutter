import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Scaffold extends StatefulWidget {
  final Widget? body;
  final bool scrollable;
  final EdgeInsetsGeometry? padding;

  const Scaffold({Key? key, this.body, this.scrollable = true, this.padding})
      : super(key: key);

  @override
  ScaffoldState createState() => ScaffoldState();

  static ScaffoldState of(BuildContext context) {
    return Data.of(context);
  }

  static ScaffoldState? maybeOf(BuildContext context) {
    return Data.maybeOf(context);
  }
}

enum SheetPosition { top, bottom, left, right }

class ScaffoldState extends State<Scaffold> {
  static const double _shift = 64;
  final List<_IndexedSheet> _sheets = [];

  void openSheet(Widget sheet, SheetPosition position) {
    _IndexedSheet indexedSheet = _IndexedSheet(
        position: position,
        length: _sheets.length + 1,
        index: _sheets.length,
        child: sheet);
    setState(() {
      _sheets.add(indexedSheet);
      _updateIndexes();
    });
  }

  void closeSheet(Widget sheet) {
    for (var indexedSheet in _sheets) {
      if (indexedSheet.child == sheet && !indexedSheet.close) {
        _closeSheet(indexedSheet);
        return;
      }
    }
  }

  void _closeSheet(_IndexedSheet sheet) {
    setState(() {
      // _sheets[sheet.index] = sheet.copyWith(close: true);
      int index = _sheets.indexOf(sheet);
      _sheets[index] = sheet.copyWith(close: true);
      _updateIndexes();
    });
  }

  void _updateIndexes() {
    Map<SheetPosition, int> lengthMap = {
      SheetPosition.top: 0,
      SheetPosition.bottom: 0,
      SheetPosition.left: 0,
      SheetPosition.right: 0,
    };
    for (var sheet in _sheets) {
      if (sheet.close) continue;
      lengthMap[sheet.position] = lengthMap[sheet.position]! + 1;
    }
    int top = 0;
    int bottom = 0;
    int left = 0;
    int right = 0;
    for (int i = 0; i < _sheets.length; i++) {
      var sheet = _sheets[i];
      if (sheet.close) continue;
      switch (sheet.position) {
        case SheetPosition.top:
          sheet =
              sheet.copyWith(length: lengthMap[SheetPosition.top]!, index: top);
          top++;
          break;
        case SheetPosition.bottom:
          sheet = sheet.copyWith(
              length: lengthMap[SheetPosition.bottom]!, index: bottom);
          bottom++;
          break;
        case SheetPosition.left:
          sheet = sheet.copyWith(
              length: lengthMap[SheetPosition.left]!, index: left);
          left++;
          break;
        case SheetPosition.right:
          sheet = sheet.copyWith(
              length: lengthMap[SheetPosition.right]!, index: right);
          right++;
          break;
      }
      _sheets[i] = sheet;
    }
  }

  void removeSheet(Widget sheet) {
    for (var indexedSheet in _sheets) {
      if (indexedSheet.child == sheet && !indexedSheet.close) {
        _removeSheet(indexedSheet);
        return;
      }
    }
  }

  void _removeSheet(_IndexedSheet sheet) {
    setState(() {
      _sheets.remove(sheet);
      _updateIndexes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int totalTopSheets = _sheets
        .where((sheet) => sheet.position == SheetPosition.top && !sheet.close)
        .length;
    int totalBottomSheets = _sheets
        .where(
            (sheet) => sheet.position == SheetPosition.bottom && !sheet.close)
        .length;
    int totalLeftSheets = _sheets
        .where((sheet) => sheet.position == SheetPosition.left && !sheet.close)
        .length;
    int totalRightSheets = _sheets
        .where((sheet) => sheet.position == SheetPosition.right && !sheet.close)
        .length;
    // padding grows exponentially with each sheet
    double paddingTop = totalTopSheets * _shift;
    double paddingBottom = totalBottomSheets * _shift;
    double paddingLeft = totalLeftSheets * _shift;
    double paddingRight = totalRightSheets * _shift;
    return LayoutBuilder(builder: (context, constraints) {
      return Data(
        data: this,
        child: mergeAnimatedTextStyle(
          duration: kDefaultDuration,
          child: AnimatedIconTheme(
            data: IconThemeData(
              color: theme.colorScheme.foreground,
              weight: 100,
            ),
            duration: kDefaultDuration,
            child: AnimatedValueBuilder(
              value: EdgeInsets.only(
                top: paddingTop,
                bottom: paddingBottom,
                left: paddingLeft,
                right: paddingRight,
              ),
              lerp: EdgeInsets.lerp,
              duration: kDefaultDuration,
              curve: Curves.easeOutCubic,
              builder: (context, shiftPadding) {
                return Stack(
                  children: [
                    Container(
                      color: theme.colorScheme.background,
                      padding: shiftPadding,
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: AnimatedContainer(
                          constraints: constraints,
                          duration: kDefaultDuration,
                          color: theme.colorScheme.background,
                          child: widget.scrollable
                              ? SingleChildScrollView(
                                  padding: widget.padding,
                                  child: widget.body,
                                )
                              : Padding(
                                  padding: widget.padding ?? EdgeInsets.zero,
                                  child: widget.body,
                                ),
                        ),
                      ),
                    ),
                    for (var sheet in _sheets)
                      Positioned.fill(
                        child: sheet,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

class _IndexedSheet extends StatefulWidget {
  final Widget child;
  final int index;
  final int length;
  final SheetPosition position;
  final bool close;

  _IndexedSheet({
    required this.child,
    this.index = 0,
    this.length = 1,
    required this.position,
    this.close = false,
  }) : super(key: ValueKey(child.hashCode));

  @override
  State<_IndexedSheet> createState() => _IndexedSheetState();

  _IndexedSheet copyWith({
    Widget? child,
    int? index,
    int? length,
    SheetPosition? position,
    bool? close,
  }) {
    return _IndexedSheet(
      index: index ?? this.index,
      length: length ?? this.length,
      position: position ?? this.position,
      close: close ?? this.close,
      child: child ?? this.child,
    );
  }
}

class _IndexedSheetState extends State<_IndexedSheet> {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_IndexedSheet(index: ${widget.index}, length: ${widget.length}, position: ${widget.position}, close: ${widget.close})';
  }

  @override
  Widget build(BuildContext context) {
    double offset = ((widget.length - widget.index - 1) / widget.length) * 100;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context)._closeSheet(widget);
            },
            // child: Container(
            //   color: Colors.black.withOpacity(0.5),
            // ),
            child: AnimatedValueBuilder(
              initialValue: 0.0,
              value: widget.close ? 0.0 : 1.0,
              duration: kDefaultDuration,
              builder: (context, value) {
                return Container(
                  color: Colors.black.withOpacity(0.6 * value),
                );
              },
            ),
          ),
        ),
        AnimatedPositioned(
          duration: kDefaultDuration,
          top: widget.position == SheetPosition.top
              ? offset
              : widget.position == SheetPosition.left ||
                      widget.position == SheetPosition.right
                  ? 0
                  : null,
          bottom: widget.position == SheetPosition.bottom
              ? offset
              : widget.position == SheetPosition.left ||
                      widget.position == SheetPosition.right
                  ? 0
                  : null,
          left: widget.position == SheetPosition.left
              ? offset
              : widget.position == SheetPosition.top ||
                      widget.position == SheetPosition.bottom
                  ? 0
                  : null,
          right: widget.position == SheetPosition.right
              ? offset
              : widget.position == SheetPosition.top ||
                      widget.position == SheetPosition.bottom
                  ? 0
                  : null,
          child: AnimatedValueBuilder(
            initialValue: -1.0,
            value: widget.close ? -1.0 : 0.0,
            duration: kDefaultDuration,
            onEnd: (value) {
              if (value == -1.0) {
                Scaffold.maybeOf(context)?._removeSheet(widget);
              }
            },
            curve: Curves.easeOutCubic,
            builder: (context, value) {
              return FractionalTranslation(
                translation: widget.position == SheetPosition.top
                    ? Offset(0, value)
                    : widget.position == SheetPosition.bottom
                        ? Offset(0, -value)
                        : widget.position == SheetPosition.left
                            ? Offset(value, 0)
                            : widget.position == SheetPosition.right
                                ? Offset(-value, 0)
                                : Offset.zero,
                child: widget.child,
              );
            },
          ),
        ),
      ],
    );
  }
}

class DrawerKey extends LabeledGlobalKey<DrawerPortalState> {
  DrawerKey([String? value]) : super(value);

  void open(Widget widget, SheetPosition position) {
    currentState?.open(widget, position);
  }

  void changePosition(SheetPosition position) {
    currentState?.changePosition(position);
  }

  void close() {
    currentState?.close();
  }
}

class DrawerPortal extends StatefulWidget {
  final Widget child;

  const DrawerPortal({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  DrawerPortalState createState() => DrawerPortalState();
}

class DrawerPortalState extends State<DrawerPortal> {
  ScaffoldState? _scaffold;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScaffoldState? oldScaffold = _scaffold;
    _scaffold = Scaffold.maybeOf(context);
    if (_scaffold == null) {
      throw Exception('DrawerBuilder must be a descendant of a Scaffold');
    }
    if (oldScaffold != _scaffold && _opened != null) {
      oldScaffold?.removeSheet(_opened!);
      _scaffold?.openSheet(_opened!, _position!);
    }
  }

  Widget? _opened;
  SheetPosition? _position;

  void open(Widget widget, SheetPosition position) {
    close();
    _opened = widget;
    _position = position;
    _scaffold!.openSheet(widget, position);
    print('open $_opened');
  }

  void changePosition(SheetPosition position) {
    Widget? opened = _opened;
    close();
    if (opened != null) {
      _scaffold!.openSheet(opened, position);
      _position = position;
    }
  }

  void close() {
    if (_opened != null) {
      _scaffold!.closeSheet(_opened!);
      _opened = null;
      print('close $_opened');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
