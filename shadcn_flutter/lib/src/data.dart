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
    final type = _typeOf<Data<T>>();
    final widget = context.dependOnInheritedWidgetOfExactType<Data<T>>();
    assert(widget != null, 'No Data<$T> found in context');
    assert(widget!.data != null, 'No Data<$T> found in context');
    return widget!.data!;
  }

  static T? maybeOf<T>(BuildContext context) {
    final type = _typeOf<Data<T>>();
    final widget = context.dependOnInheritedWidgetOfExactType<Data<T>>();
    if (widget == null) {
      return null;
    }
    return widget.data;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(covariant Data<T> oldWidget) {
    return oldWidget.data != data;
  }
}
