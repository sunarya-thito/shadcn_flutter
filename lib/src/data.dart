import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class DistinctData {
  bool shouldNotify(covariant DistinctData oldData);
}

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
    super.key,
    required this.holder,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedDataHolder<T> oldWidget) {
    return oldWidget.holder != holder;
  }
}

class InheritedRootDataHolder extends InheritedDataHolderWidget<dynamic> {
  @override
  final DataHolder<dynamic> holder;

  const InheritedRootDataHolder({
    super.key,
    required this.holder,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedRootDataHolder oldWidget) {
    return oldWidget.holder != holder;
  }
}

class DataMessengerRoot extends StatefulWidget {
  final Widget child;

  const DataMessengerRoot({
    super.key,
    required this.child,
  });

  @override
  State<DataMessengerRoot> createState() => _DataMessengerRootState();
}

class _DataMessengerRootState extends State<DataMessengerRoot>
    implements DataHolder {
  final Map<Type, LinkedHashSet<ForwardableDataState>> _senders = {};

  @override
  void register(ForwardableDataState receiver) {
    final type = receiver.dataType;
    _senders.putIfAbsent(type, () => LinkedHashSet());
    _senders[type]!.add(receiver);
  }

  @override
  void unregister(ForwardableDataState receiver) {
    final type = receiver.dataType;
    _senders[type]?.remove(receiver);
  }

  @override
  dynamic findData(BuildContext context, Type type) {
    LinkedHashSet<ForwardableDataState>? receivers = _senders[type];
    if (receivers == null) {
      return null;
    }
    for (ForwardableDataState receiver in receivers) {
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
    super.key,
    required this.child,
  });

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
    super.key,
    required this.data,
    required this.child,
  });

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
    return Data<T>.inherit(
      data: widget.data,
      child: DataMessenger<T>(
        child: widget.child,
      ),
    );
  }
}

abstract class MultiDataItem {
  Type get dataType;
  Widget _wrap(Widget child);
}

class DataNotifier<T> extends StatelessWidget implements MultiDataItem {
  final ValueListenable<T> notifier;
  final Widget? _child;

  const DataNotifier(this.notifier, {super.key}) : _child = null;

  const DataNotifier.inherit({
    super.key,
    required this.notifier,
    required Widget child,
  }) : _child = child;

  @override
  Widget _wrap(Widget child) {
    return DataNotifier<T>.inherit(
      notifier: notifier,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Data<T>.inherit(
          data: value,
          child: child!,
        );
      },
      child: _child,
    );
  }

  @override
  Type get dataType => T;
}

typedef DataWidgetBuilder<T> = Widget Function(
    BuildContext context, T data, Widget? child);
typedef OptionalDataWidgetBuilder<T> = Widget Function(
    BuildContext context, T? data, Widget? child);

class DataBuilder<T> extends StatelessWidget {
  final DataWidgetBuilder<T>? _builder;
  final OptionalDataWidgetBuilder<T>? _optionalBuilder;
  final Widget? child;

  const DataBuilder.optionally({
    super.key,
    required OptionalDataWidgetBuilder<T> builder,
    this.child,
  })  : _builder = null,
        _optionalBuilder = builder;

  const DataBuilder({
    super.key,
    required DataWidgetBuilder<T> builder,
    this.child,
  })  : _builder = builder,
        _optionalBuilder = null;

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<T>(context);
    if (_builder != null) {
      assert(data != null, 'No Data<$T> found in context');
      return _builder!(context, data as T, child);
    }
    return _optionalBuilder!(context, data, child);
  }
}

class MultiData extends StatefulWidget {
  final List<MultiDataItem> data;
  final Widget child;

  const MultiData({
    super.key,
    required this.data,
    required this.child,
  });

  @override
  State<MultiData> createState() => _MultiDataState();
}

class _MultiDataState extends State<MultiData> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Widget result = KeyedSubtree(
      key: _key,
      child: widget.child,
    );
    for (final data in widget.data) {
      // make sure dataType is not dynamic
      final Type dataType = data.dataType;
      assert(dataType != dynamic, 'Data must have a type');
      result = data._wrap(result);
    }
    return result;
  }
}

class Data<T> extends StatelessWidget implements MultiDataItem {
  final T? _data;
  final Widget? child;

  const Data(T data, {super.key})
      : _data = data,
        child = null,
        super();

  const Data.inherit({
    super.key,
    required T data,
    this.child,
  }) : _data = data;

  const Data.boundary({
    super.key,
    this.child,
  }) : _data = null;

  T get data {
    assert(_data != null, 'No Data<$T> found in context');
    return _data!;
  }

  @override
  Widget _wrap(Widget child) {
    return _InheritedData<T>._internal(
      key: key,
      data: _data,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(dataType != dynamic, 'Data must have a type');
    return _InheritedData<T>._internal(
      data: _data,
      child: child ?? const SizedBox(),
    );
  }

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
    final widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedData<T>>();
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
    final data = <_InheritedData>[];
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
        if (ancestor is InheritedElement && ancestor.widget is _InheritedData) {
          final _InheritedData dataWidget = ancestor.widget as _InheritedData;
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
}

class _InheritedData<T> extends InheritedWidget {
  final T? data;

  Type get dataType => T;

  const _InheritedData._internal({
    super.key,
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _InheritedData<T> oldWidget) {
    if (data is DistinctData && oldWidget.data is DistinctData) {
      return (data as DistinctData)
          .shouldNotify(oldWidget.data as DistinctData);
    }
    return oldWidget.data != data;
  }

  Widget? wrap(Widget child, BuildContext context) {
    _InheritedData<T>? ancestor =
        context.dependOnInheritedWidgetOfExactType<_InheritedData<T>>();
    // if it's the same type, we don't need to wrap it
    if (identical(this, ancestor)) {
      return null;
    }
    final data = this.data;
    if (data == null) {
      return Data<T>.boundary(child: child);
    }
    return Data<T>.inherit(
      data: data,
      child: child,
    );
  }
}

class CapturedData {
  CapturedData._(this._data);

  final List<_InheritedData> _data;

  Widget wrap(Widget child) {
    return _CaptureAll(data: _data, child: child);
  }
}

class _CaptureAll extends StatelessWidget {
  const _CaptureAll({
    required this.data,
    required this.child,
  });

  final List<_InheritedData> data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    for (final data in data) {
      var wrap = data.wrap(result, context);
      if (wrap == null) {
        continue;
      }
      result = wrap;
    }
    return result;
  }
}
