import 'package:flutter/widgets.dart';

class DataBuilder<T> extends StatelessWidget {
  final T data;
  final WidgetBuilder builder;

  const DataBuilder({
    Key? key,
    required this.data,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Data<T>(
      data: data,
      child: Builder(builder: builder),
    );
  }
}

class Data<T> extends InheritedWidget {
  final T? data;

  const Data({
    Key? key,
    required T this.data,
    required Widget child,
  }) : super(key: key, child: child);

  const Data.boundary({
    Key? key,
    required Widget child,
  })  : data = null,
        super(key: key, child: child);

  static T of<T>(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<Data<T>>();
    assert(widget != null, 'No Data<$T> found in context');
    assert(widget!.data != null, 'No Data<$T> found in context');
    return widget!.data!;
  }

  static T? maybeOf<T>(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<Data<T>>();
    if (widget == null) {
      return null;
    }
    return widget.data;
  }

  static Widget captureAll(BuildContext context, Widget child,
      {BuildContext? to}) {
    return capture(from: context, to: to).wrap(child);
  }

  static CapturedData capture(
      {required BuildContext from, required BuildContext? to}) {
    if (from == to) {
      return CapturedData._([]);
    }
    final data = <Data>[];
    final Set<Type> dataTypes = <Type>{};
    late bool debugDidFindAncestor;
    assert(() {
      debugDidFindAncestor = to == null;
      return true;
    }());

    from.visitAncestorElements(
      (ancestor) {
        if (ancestor == to) {
          assert(() {
            debugDidFindAncestor = true;
            return true;
          }());
          return false;
        }
        if (ancestor is InheritedElement && ancestor.widget is Data) {
          final Data dataWidget = ancestor.widget as Data;
          final Type dataType = dataWidget.dataType;
          if (!dataTypes.contains(dataType)) {
            dataTypes.add(dataType);
            data.add(dataWidget);
          }
        }
        return true;
      },
    );

    assert(debugDidFindAncestor,
        'The provided `to` context must be an ancestor of the `from` context.');

    return CapturedData._(data);
  }

  Type get dataType => T;

  @override
  bool updateShouldNotify(covariant Data<T> oldWidget) {
    return oldWidget.data != data;
  }

  Widget? wrap(Widget child) {
    final data = this.data;
    if (data == null) {
      return null;
    }
    return Data<T>(
      data: data,
      child: child,
    );
  }
}

class CapturedData {
  CapturedData._(this._data);

  final List<Data> _data;

  Widget wrap(Widget child) {
    return _CaptureAll(data: _data, child: child);
  }
}

class _CaptureAll extends StatelessWidget {
  const _CaptureAll({
    required this.data,
    required this.child,
  });

  final List<Data> data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    for (final data in data) {
      result = data.wrap(result)!;
    }
    return result;
  }
}
