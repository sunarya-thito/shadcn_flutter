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
      return _builder(context, data as T, child);
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

  static List<T> collect<T>(BuildContext context) {
    final List<T> data = [];
    context.visitAncestorElements((element) {
      if (element.widget is Data<T>) {
        var currentData = (element.widget as Data<T>)._data;
        if (currentData != null) {
          data.add(currentData);
        } else {
          return false;
        }
      }
      return true;
    });
    return data;
  }

  static void visitAncestors<T>(
      BuildContext context, bool Function(T data) visitor) {
    context.visitAncestorElements((element) {
      if (element.widget is Data<T>) {
        var currentData = (element.widget as Data<T>)._data;
        if (currentData != null) {
          if (!visitor(currentData)) {
            return false;
          }
        } else {
          return false;
        }
      }
      return true;
    });
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

  static T? maybeFindRoot<T>(BuildContext context) {
    T? found;
    context.visitAncestorElements((element) {
      if (element.widget is Data<T>) {
        var data = (element.widget as Data<T>)._data;
        if (data != null) {
          found = data;
        }
      }
      return true;
    });
    return found;
  }

  static T findRoot<T>(BuildContext context) {
    final data = maybeFindRoot<T>(context);
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

  @override
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
    return _CaptureAllData(data: _data, child: child);
  }
}

class _CaptureAllData extends StatelessWidget {
  const _CaptureAllData({
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

mixin ModelProperty<T> {
  Symbol get dataKey;
  T get value;
  set value(T data);

  ModelKey<T> get modelKey => ModelKey<T>(dataKey);

  Type get dataType => T;

  Model<T> get normalized;

  bool get isReadOnly;
}

class Model<T> extends StatelessWidget with ModelProperty<T> {
  @override
  final Symbol dataKey;
  @override
  final T value;
  final Widget? child;
  final ValueChanged<T>? onChanged;

  const Model(this.dataKey, this.value, {this.onChanged}) : child = null;

  const Model.inherit(this.dataKey, this.value,
      {super.key, this.onChanged, required this.child});

  @override
  set value(T data) {
    assert(onChanged != null, 'Model<$T>($dataKey) is read-only');
    onChanged?.call(data);
  }

  @override
  bool get isReadOnly => onChanged == null;

  static T? maybeOf<T>(BuildContext context, Symbol key) {
    return MultiModel.maybeOf(context, key);
  }

  static T of<T>(BuildContext context, Symbol key) {
    return MultiModel.of(context, key);
  }

  static T? maybeFind<T>(BuildContext context, Symbol key) {
    return MultiModel.maybeFind(context, key);
  }

  static T find<T>(BuildContext context, Symbol key) {
    return MultiModel.find(context, key);
  }

  static void change<T>(BuildContext context, Symbol key, T data) {
    MultiModel.change(context, key, data);
  }

  static ModelProperty<T>? maybeFindProperty<T>(
      BuildContext context, Symbol key) {
    return MultiModel.maybeFindProperty(context, key);
  }

  static ModelProperty<T> findProperty<T>(BuildContext context, Symbol key) {
    return MultiModel.findProperty(context, key);
  }

  static void maybeChange<T>(BuildContext context, Symbol key, T data) {
    MultiModel.maybeChange(context, key, data);
  }

  static ModelProperty<T> ofProperty<T>(BuildContext context, Symbol key) {
    return MultiModel.ofProperty(context, key);
  }

  static ModelProperty<T>? maybeOfProperty<T>(
      BuildContext context, Symbol key) {
    return MultiModel.maybeOfProperty(context, key);
  }

  @override
  Widget build(BuildContext context) {
    return MultiModel(
      data: [this],
      child: child ?? const SizedBox(),
    );
  }

  @override
  Model<T> get normalized => this;

  @override
  String toStringShort() {
    return 'Model<$T>($dataKey: $value)';
  }
}

class ModelNotifier<T> extends StatelessWidget
    with ModelProperty<T>
    implements Listenable {
  @override
  final Symbol dataKey;
  final ValueNotifier<T> notifier;
  final Widget? child;

  const ModelNotifier(this.dataKey, this.notifier) : child = null;

  const ModelNotifier.inherit(this.dataKey, this.notifier,
      {super.key, required this.child});

  @override
  T get value => notifier.value;

  @override
  set value(T data) {
    notifier.value = data;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Model.inherit(dataKey, value, onChanged: (value) {
          notifier.value = value;
        }, child: child);
      },
      child: child,
    );
  }

  void _handleDataChanged(T data) {
    this.value = data;
  }

  @override
  Model<T> get normalized =>
      Model(dataKey, value, onChanged: _handleDataChanged);

  @override
  String toStringShort() {
    return 'ModelNotifier<$T>($dataKey: $notifier)';
  }

  @override
  bool get isReadOnly => false;

  @override
  void addListener(VoidCallback listener) {
    notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    notifier.removeListener(listener);
  }
}

class ModelListenable<T> extends StatelessWidget
    with ModelProperty<T>
    implements Listenable {
  @override
  final Symbol dataKey;
  final ValueListenable<T> listenable;
  final Widget? child;

  const ModelListenable(this.dataKey, this.listenable) : child = null;

  const ModelListenable.inherit(this.dataKey, this.listenable,
      {super.key, required this.child});

  @override
  T get value => listenable.value;

  @override
  set value(T data) {
    assert(false, 'ModelListenable<$T>($dataKey) is read-only');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (context, value, child) {
        return Model.inherit(dataKey, value, child: child);
      },
      child: child,
    );
  }

  @override
  Model<T> get normalized => Model(dataKey, value);

  @override
  String toStringShort() {
    return 'ModelListenable<$T>($dataKey: $listenable)';
  }

  @override
  bool get isReadOnly => true;

  @override
  void addListener(VoidCallback listener) {
    listenable.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listenable.removeListener(listener);
  }
}

class ModelKey<T> {
  final Symbol key;

  const ModelKey(this.key);

  T? maybeOf(BuildContext context) {
    return MultiModel.maybeOf<T>(context, key);
  }

  T of(BuildContext context) {
    return MultiModel.of<T>(context, key);
  }

  T? maybeFind(BuildContext context) {
    return MultiModel.maybeFind<T>(context, key);
  }

  T find(BuildContext context) {
    return MultiModel.find<T>(context, key);
  }

  void maybeChange(BuildContext context, T data) {
    MultiModel.maybeChange(context, key, data);
  }

  void change(BuildContext context, T data) {
    MultiModel.change(context, key, data);
  }

  ModelProperty<T>? maybeFindProperty(BuildContext context) {
    return MultiModel.maybeFindProperty<T>(context, key);
  }

  ModelProperty<T> findProperty(BuildContext context) {
    return MultiModel.findProperty<T>(context, key);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ModelKey && other.key == key && other.dataType == T;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() => 'ModelKey<$T>($key)';

  Type get dataType => T;
}

class MultiModel extends StatelessWidget {
  final List<ModelProperty> data;
  final Widget child;

  const MultiModel({required this.data, required this.child});

  @override
  Widget build(BuildContext context) {
    Listenable mergedListenable = Listenable.merge(
      data.whereType<Listenable>(),
    );
    return ListenableBuilder(
      listenable: mergedListenable,
      builder: (context, child) {
        return _InheritedModel(
          data.map((e) => e.normalized).toList(),
          child: this.child,
        );
      },
    );
  }

  static T? maybeOf<T>(BuildContext context, Symbol key) {
    return maybeOfProperty<T>(context, key)?.value;
  }

  static T of<T>(BuildContext context, Symbol key) {
    return ofProperty<T>(context, key).value;
  }

  static T? maybeFind<T>(BuildContext context, Symbol key) {
    return maybeOfProperty<T>(context, key)?.value;
  }

  static T find<T>(BuildContext context, Symbol key) {
    return findProperty<T>(context, key).value;
  }

  static void change<T>(BuildContext context, Symbol key, T data) {
    final widget = context.findAncestorWidgetOfExactType<_InheritedModel>();
    assert(widget != null, 'No Model<$T>($key) found in context');
    for (final model in widget!.data) {
      if (model.dataKey == key) {
        model.value = data;
        return;
      }
    }
    assert(false, 'No Model<$T>($key) found in context');
  }

  static void maybeChange<T>(BuildContext context, Symbol key, T data) {
    final widget = context.findAncestorWidgetOfExactType<_InheritedModel>();
    if (widget == null) {
      return;
    }
    for (final model in widget.data) {
      if (model.dataKey == key) {
        model.value = data;
        return;
      }
    }
  }

  static ModelProperty<T>? maybeFindProperty<T>(
      BuildContext context, Symbol key) {
    final widget = context.findAncestorWidgetOfExactType<_InheritedModel>();
    if (widget == null) {
      return null;
    }
    for (final model in widget.data) {
      if (model.dataKey == key && model.dataType == T) {
        return model as ModelProperty<T>;
      }
    }
    return null;
  }

  static ModelProperty<T> findProperty<T>(BuildContext context, Symbol key) {
    final model = maybeFindProperty<T>(context, key);
    assert(model != null, 'No Model<$T>($key) found in context');
    return model!;
  }

  static ModelProperty<T>? maybeOfProperty<T>(
      BuildContext context, Symbol key) {
    var model = InheritedModel.inheritFrom<_InheritedModel>(context,
        aspect: ModelKey<T>(key));
    if (model == null) {
      return null;
    }
    for (final model in model.data) {
      if (model.dataKey == key && model.dataType == T) {
        return model as ModelProperty<T>;
      }
    }
    return null;
  }

  static ModelProperty<T> ofProperty<T>(BuildContext context, Symbol key) {
    final model = maybeOfProperty<T>(context, key);
    assert(model != null, 'No Model<$T>($key) found in context');
    return model!;
  }
}

class _InheritedModel extends InheritedModel<ModelKey> {
  final Iterable<Model> data;

  const _InheritedModel(this.data, {required super.child});

  @override
  bool updateShouldNotify(covariant _InheritedModel oldWidget) {
    for (final model in data) {
      bool found = false;
      for (final oldModel in oldWidget.data) {
        if (model.modelKey == oldModel.modelKey) {
          found = true;

          if (model.value != oldModel.value) {
            // the existing model has changed
            return true;
          }
        }
      }
      if (!found) {
        // a new model has been added
        return true;
      }
    }
    for (final oldModel in oldWidget.data) {
      bool found = false;
      for (final model in data) {
        if (model.modelKey == oldModel.modelKey) {
          found = true;
        }
      }
      if (!found) {
        // a model has been removed
        return true;
      }
    }
    return false;
  }

  @override
  bool isSupportedAspect(Object aspect) {
    if (aspect is ModelKey) {
      return data.any((model) =>
          model.dataKey == aspect.key && model.dataType == aspect.dataType);
    }
    return false;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant _InheritedModel oldWidget, Set<ModelKey> dependencies) {
    for (final model in data) {
      bool found = false;
      for (final oldModel in oldWidget.data) {
        if (model.modelKey == oldModel.modelKey) {
          found = true;
          if (model.value != oldModel.value) {
            // the existing model has changed
            return dependencies.contains(model.modelKey);
          }
        }
      }
      if (!found) {
        // a new model has been added
        return dependencies.contains(model.modelKey);
      }
    }
    for (final oldModel in oldWidget.data) {
      bool found = false;
      for (final model in data) {
        if (model.modelKey == oldModel.modelKey) {
          found = true;
        }
      }
      if (!found) {
        // a model has been removed
        return dependencies.contains(oldModel.modelKey);
      }
    }
    return false;
  }
}

typedef ModelWidgetBuilder<T> = Widget Function(
    BuildContext context, ModelProperty<T> model, Widget? child);

class ModelBuilder<T> extends StatelessWidget {
  final Symbol dataKey;
  final ModelWidgetBuilder<T> builder;
  final Widget? child;

  const ModelBuilder(
    this.dataKey, {
    super.key,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final model = MultiModel.maybeOfProperty<T>(context, dataKey);
    assert(model != null, 'No Model<$T>($dataKey) found in context');
    return builder(context, model!, child);
  }
}
