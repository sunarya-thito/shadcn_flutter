import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class DataHolder<T> {
  void register(ForwardableDataState<T> receiver);
  void unregister(ForwardableDataState<T> receiver);
  T? findData(BuildContext context, Type type);
}

abstract class InheritedDataHolderWidget<T> extends InheritedWidget {
  const InheritedDataHolderWidget({required super.child, super.key});

  DataHolder<T> get holder;
}

class InheritedDataHolder<T> extends InheritedDataHolderWidget<T> {
  @override
  final DataHolder<T> holder;

  const InheritedDataHolder({
    Key? key,
    required this.holder,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedDataHolder<T> oldWidget) {
    return oldWidget.holder != holder;
  }
}

class InheritedRootDataHolder extends InheritedDataHolderWidget<dynamic> {
  @override
  final DataHolder<dynamic> holder;

  const InheritedRootDataHolder({
    Key? key,
    required this.holder,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedRootDataHolder oldWidget) {
    return oldWidget.holder != holder;
  }
}

class DataMessengerRoot extends StatefulWidget {
  final Widget child;

  const DataMessengerRoot({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<DataMessengerRoot> createState() => _DataMessengerRootState();
}

class _DataMessengerRootState extends State<DataMessengerRoot>
    implements DataHolder {
  final Map<Type, LinkedHashSet> _receivers = {};

  @override
  void register(ForwardableDataState receiver) {
    final type = receiver.dataType;
    _receivers.putIfAbsent(type, () => LinkedHashSet());
    _receivers[type]!.add(receiver);
  }

  @override
  void unregister(ForwardableDataState receiver) {
    final type = receiver.dataType;
    _receivers[type]?.remove(receiver);
  }

  @override
  dynamic findData(BuildContext context, Type type) {
    for (final receiver in _receivers[type] ?? []) {
      var didFindData = false;
      receiver.context.visitAncestorElements((element) {
        if (element == context) {
          didFindData = true;
          return false;
        }
        return true;
      });
      if (didFindData) {
        return receiver.widget.data;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InheritedRootDataHolder(
      holder: this,
      child: widget.child,
    );
  }
}

class DataMessenger<T> extends StatefulWidget {
  final Widget child;

  const DataMessenger({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<DataMessenger<T>> createState() => _DataMessengerState<T>();
}

class _DataMessengerState<T> extends State<DataMessenger<T>>
    implements DataHolder<T> {
  final LinkedHashSet<ForwardableDataState<T>> _receivers = LinkedHashSet();

  @override
  void register(ForwardableDataState<T> receiver) {
    _receivers.add(receiver);
  }

  @override
  void unregister(ForwardableDataState<T> receiver) {
    _receivers.remove(receiver);
  }

  @override
  T? findData(BuildContext context, Type type) {
    for (final receiver in _receivers) {
      var didFindData = false;
      receiver.context.visitAncestorElements((element) {
        if (element == context) {
          didFindData = true;
          return false;
        }
        return true;
      });
      if (didFindData) {
        return receiver.widget.data;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InheritedDataHolder<T>(
      holder: this,
      child: widget.child,
    );
  }
}

class ForwardableData<T> extends StatefulWidget {
  final T data;
  final Widget child;

  const ForwardableData({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  @override
  State<ForwardableData<T>> createState() => ForwardableDataState<T>();
}

class ForwardableDataState<T> extends State<ForwardableData<T>> {
  DataHolder? _messenger;

  Type get dataType => T;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InheritedDataHolderWidget? inheritedDataHolder =
        context.dependOnInheritedWidgetOfExactType<InheritedDataHolder<T>>();
    // if not found, try to find
    inheritedDataHolder ??=
        context.dependOnInheritedWidgetOfExactType<InheritedRootDataHolder>();
    final messenger = inheritedDataHolder?.holder;
    if (messenger != _messenger) {
      _messenger?.unregister(this);
      _messenger = messenger;
      _messenger?.register(this);
    }
  }

  @override
  void dispose() {
    _messenger?.unregister(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Data<T>(
      data: widget.data,
      child: DataMessenger<T>(
        child: widget.child,
      ),
    );
  }
}

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
    final data = maybeOf<T>(context);
    assert(data != null, 'No Data<$T> found in context');
    return data!;
  }

  static T? maybeFind<T>(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<Data<T>>();
    if (widget == null) {
      return null;
    }
    return widget.data;
  }

  static T? maybeFindMessenger<T>(BuildContext context) {
    InheritedDataHolderWidget? holder =
        context.findAncestorWidgetOfExactType<InheritedDataHolder<T>>();
    holder ??= context.findAncestorWidgetOfExactType<InheritedRootDataHolder>();
    if (holder != null) {
      return holder.holder.findData(context, T);
    }
    return null;
  }

  static T findMessenger<T>(BuildContext context) {
    final data = maybeFindMessenger<T>(context);
    assert(data != null, 'No Data<$T> found in context');
    return data!;
  }

  static T find<T>(BuildContext context) {
    final data = maybeFind<T>(context);
    assert(data != null, 'No Data<$T> found in context');
    return data!;
  }

  static T? maybeOf<T>(BuildContext context) {
    // InheritedDataHolder? holder =
    //     context.dependOnInheritedWidgetOfExactType<InheritedDataHolder<T>>();
    // holder ??= context
    //     .dependOnInheritedWidgetOfExactType<InheritedDataHolder<dynamic>>();
    // if (holder != null) {
    //   return holder.holder.findData(context, T);
    // }
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
          // data.add(dataWidget);
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
      return Data<T>.boundary(child: child);
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
      var wrap = data.wrap(result);
      if (wrap == null) {
        continue;
      }
      result = wrap;
    }
    return result;
  }
}

class ComponentTheme<T> extends InheritedTheme {
  final T data;

  const ComponentTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ComponentTheme<T>(
      data: data,
      child: child,
    );
  }

  static T of<T>(BuildContext context) {
    final data = maybeOf<T>(context);
    assert(data != null, 'No Data<$T> found in context');
    return data!;
  }

  static T? maybeOf<T>(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<ComponentTheme<T>>();
    if (widget == null) {
      return null;
    }
    return widget.data;
  }

  @override
  bool updateShouldNotify(covariant ComponentTheme<T> oldWidget) {
    return oldWidget.data != data;
  }
}
