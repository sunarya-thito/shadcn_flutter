import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

mixin DistinctData {
  bool shouldNotify(covariant DistinctData oldData);
}

mixin AlwaysUpdateData implements DistinctData {
  @override
  bool shouldNotify(covariant DistinctData oldData) => true;
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

class ModelBoundary<T> extends StatelessWidget implements Model<T> {
  @override
  final Symbol dataKey;
  @override
  final Widget? child;

  const ModelBoundary(this.dataKey, {super.key, this.child});

  @override
  T get value {
    assert(false, 'No Model<$T>($dataKey) found in context');
    throw Exception('ModelBoundary<$T>($dataKey)');
  }

  @override
  Widget build(BuildContext context) {
    return Model<T>.inherit(dataKey, value, child: child!);
  }

  @override
  Type get dataType => T;

  @override
  bool get isReadOnly => true;

  @override
  ModelKey<T> get modelKey => ModelKey<T>(dataKey);

  @override
  Model<T> get normalized => this;

  @override
  final ValueChanged<T>? onChanged = null;

  @override
  set value(T data) {
    assert(false, 'No Model<$T>($dataKey) found in context');
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
        if (model is ModelBoundary<T>) {
          return null;
        }
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
        if (model is ModelBoundary<T>) {
          return null;
        }
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

class SetChangeDetails<T> {
  final Iterable<T> added;
  final Iterable<T> removed;

  const SetChangeDetails(this.added, this.removed);
}

class ListChangeDetails<T> {
  final Iterable<T> added;
  final Iterable<T> removed;
  final int index;

  const ListChangeDetails(this.added, this.removed, this.index);
}

abstract class ChangeListener {
  void dispatch(Object? event);
}

class _SetChangeListener<T> extends ChangeListener {
  final SetChangeListener<T> listener;

  _SetChangeListener(this.listener);

  @override
  void dispatch(Object? event) {
    listener(event as SetChangeDetails<T>);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _SetChangeListener<T> && other.listener == listener;
  }

  @override
  int get hashCode => listener.hashCode;
}

class _ListChangeListener<T> extends ChangeListener {
  final ListChangeListener<T> listener;

  _ListChangeListener(this.listener);

  @override
  void dispatch(Object? event) {
    listener(event as ListChangeDetails<T>);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ListChangeListener<T> && other.listener == listener;
  }

  @override
  int get hashCode => listener.hashCode;
}

class _MapChangeListener<K, V> extends ChangeListener {
  final MapChangeListener<K, V> listener;

  _MapChangeListener(this.listener);

  @override
  void dispatch(Object? event) {
    listener(event as MapChangeDetails<K, V>);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _MapChangeListener<K, V> && other.listener == listener;
  }

  @override
  int get hashCode => listener.hashCode;
}

class _VoidChangeListener extends ChangeListener {
  final VoidCallback listener;

  _VoidChangeListener(this.listener);

  @override
  void dispatch(Object? event) {
    listener();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _VoidChangeListener && other.listener == listener;
  }

  @override
  int get hashCode => listener.hashCode;
}

class MapChangeDetails<K, V> {
  final Iterable<MapEntry<K, V>> added;
  final Iterable<MapEntry<K, V>> removed;

  const MapChangeDetails(this.added, this.removed);
}

typedef SetChangeListener<T> = void Function(SetChangeDetails<T> details);
typedef ListChangeListener<T> = void Function(ListChangeDetails<T> details);
typedef MapChangeListener<K, V> = void Function(MapChangeDetails<K, V> details);

abstract class SetListenable<T> extends ValueListenable<Set<T>> {
  Set<T> get value;
  void addChangeListener(SetChangeListener<T> listener);
  void removeChangeListener(SetChangeListener<T> listener);
}

abstract class ListListenable<T> extends ValueListenable<List<T>> {
  List<T> get value;
  void addChangeListener(ListChangeListener<T> listener);
  void removeChangeListener(ListChangeListener<T> listener);
}

abstract class MapListenable<K, V> extends ValueListenable<Map<K, V>> {
  Map<K, V> get value;
  void addChangeListener(MapChangeListener<K, V> listener);
  void removeChangeListener(MapChangeListener<K, V> listener);
}

mixin NotifierHelper {
  int _count = 0;
  static final List<ChangeListener?> _emptyListeners =
      List<ChangeListener?>.filled(0, null);

  List<ChangeListener?> _listeners = _emptyListeners;
  int _notificationCallStackDepth = 0;
  int _reentrantlyRemovedListeners = 0;
  bool _debugDisposed = false;

  bool _creationDispatched = false;

  static bool debugAssertNotDisposed(NotifierHelper notifier) {
    assert(() {
      if (notifier._debugDisposed) {
        throw FlutterError(
          'A ${notifier.runtimeType} was used after being disposed.\n'
          'Once you have called dispose() on a ${notifier.runtimeType}, it '
          'can no longer be used.',
        );
      }
      return true;
    }());
    return true;
  }

  @protected
  bool get hasListeners {
    return _count > 0;
  }

  @protected
  static void maybeDispatchObjectCreation(NotifierHelper object) {
    // Tree shaker does not include this method and the class MemoryAllocations
    // if kFlutterMemoryAllocationsEnabled is false.
    if (kFlutterMemoryAllocationsEnabled && !object._creationDispatched) {
      FlutterMemoryAllocations.instance.dispatchObjectCreated(
        library: _shadcnDataLibrary,
        className: '$NotifierHelper',
        object: object,
      );
      object._creationDispatched = true;
    }
  }

  void defaultAddListener(ChangeListener listener) {
    assert(debugAssertNotDisposed(this));

    if (kFlutterMemoryAllocationsEnabled) {
      maybeDispatchObjectCreation(this);
    }

    if (_count == _listeners.length) {
      if (_count == 0) {
        _listeners = List<ChangeListener?>.filled(1, listener);
      } else {
        final List<ChangeListener?> newListeners =
            List<ChangeListener?>.filled(_count * 2, null);
        for (int i = 0; i < _count; i++) {
          newListeners[i] = _listeners[i];
        }
        _listeners = newListeners;
      }
    }
    _listeners[_count++] = listener;
  }

  void _removeAt(int index) {
    // The list holding the listeners is not growable for performances reasons.
    // We still want to shrink this list if a lot of listeners have been added
    // and then removed outside a notifyListeners iteration.
    // We do this only when the real number of listeners is half the length
    // of our list.
    _count -= 1;
    if (_count * 2 <= _listeners.length) {
      final List<ChangeListener?> newListeners =
          List<ChangeListener?>.filled(_count, null);

      // Listeners before the index are at the same place.
      for (int i = 0; i < index; i++) {
        newListeners[i] = _listeners[i];
      }

      // Listeners after the index move towards the start of the list.
      for (int i = index; i < _count; i++) {
        newListeners[i] = _listeners[i + 1];
      }

      _listeners = newListeners;
    } else {
      // When there are more listeners than half the length of the list, we only
      // shift our listeners, so that we avoid to reallocate memory for the
      // whole list.
      for (int i = index; i < _count; i++) {
        _listeners[i] = _listeners[i + 1];
      }
      _listeners[_count] = null;
    }
  }

  void defaultRemoveListener(ChangeListener listener) {
    // This method is allowed to be called on disposed instances for usability
    // reasons. Due to how our frame scheduling logic between render objects and
    // overlays, it is common that the owner of this instance would be disposed a
    // frame earlier than the listeners. Allowing calls to this method after it
    // is disposed makes it easier for listeners to properly clean up.
    for (int i = 0; i < _count; i++) {
      final ChangeListener? listenerAtIndex = _listeners[i];
      if (listenerAtIndex == listener) {
        if (_notificationCallStackDepth > 0) {
          // We don't resize the list during notifyListeners iterations
          // but we set to null, the listeners we want to remove. We will
          // effectively resize the list at the end of all notifyListeners
          // iterations.
          _listeners[i] = null;
          _reentrantlyRemovedListeners++;
        } else {
          // When we are outside the notifyListeners iterations we can
          // effectively shrink the list.
          _removeAt(i);
        }
        break;
      }
    }
  }

  @mustCallSuper
  void dispose() {
    assert(debugAssertNotDisposed(this));
    assert(
      _notificationCallStackDepth == 0,
      'The "dispose()" method on $this was called during the call to '
      '"notifyListeners()". This is likely to cause errors since it modifies '
      'the list of listeners while the list is being used.',
    );
    assert(() {
      _debugDisposed = true;
      return true;
    }());
    if (kFlutterMemoryAllocationsEnabled && _creationDispatched) {
      FlutterMemoryAllocations.instance.dispatchObjectDisposed(object: this);
    }
    _listeners = _emptyListeners;
    _count = 0;
  }

  @protected
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  void defaultNotifyListeners(Object? event) {
    assert(debugAssertNotDisposed(this));
    if (_count == 0) {
      return;
    }

    // To make sure that listeners removed during this iteration are not called,
    // we set them to null, but we don't shrink the list right away.
    // By doing this, we can continue to iterate on our list until it reaches
    // the last listener added before the call to this method.

    // To allow potential listeners to recursively call notifyListener, we track
    // the number of times this method is called in _notificationCallStackDepth.
    // Once every recursive iteration is finished (i.e. when _notificationCallStackDepth == 0),
    // we can safely shrink our list so that it will only contain not null
    // listeners.

    _notificationCallStackDepth++;

    final int end = _count;
    for (int i = 0; i < end; i++) {
      try {
        final ChangeListener? listener = _listeners[i];
        if (listener != null) {
          listener.dispatch(event);
        }
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'foundation library',
          context: ErrorDescription(
              'while dispatching notifications for $runtimeType'),
          informationCollector: () => <DiagnosticsNode>[
            DiagnosticsProperty<NotifierHelper>(
              'The $runtimeType sending notification was',
              this,
              style: DiagnosticsTreeStyle.errorProperty,
            ),
          ],
        ));
      }
    }

    _notificationCallStackDepth--;

    if (_notificationCallStackDepth == 0 && _reentrantlyRemovedListeners > 0) {
      // We really remove the listeners when all notifications are done.
      final int newLength = _count - _reentrantlyRemovedListeners;
      if (newLength * 2 <= _listeners.length) {
        // As in _removeAt, we only shrink the list when the real number of
        // listeners is half the length of our list.
        final List<ChangeListener?> newListeners =
            List<ChangeListener?>.filled(newLength, null);

        int newIndex = 0;
        for (int i = 0; i < _count; i++) {
          final listener = _listeners[i];
          if (listener != null) {
            newListeners[newIndex++] = listener;
          }
        }

        _listeners = newListeners;
      } else {
        // Otherwise we put all the null references at the end.
        for (int i = 0; i < newLength; i += 1) {
          if (_listeners[i] == null) {
            // We swap this item with the next not null item.
            int swapIndex = i + 1;
            while (_listeners[swapIndex] == null) {
              swapIndex += 1;
            }
            _listeners[i] = _listeners[swapIndex];
            _listeners[swapIndex] = null;
          }
        }
      }

      _reentrantlyRemovedListeners = 0;
      _count = newLength;
    }
  }
}

const String _shadcnDataLibrary = 'package:shadcn_flutter/shadcn_flutter.dart';

class SetNotifier<T> extends SetListenable<T>
    with NotifierHelper, Iterable<T>
    implements Set<T> {
  final Set<T> _set;

  SetNotifier([Set<T> set = const {}]) : _set = Set<T>.from(set);

  Set<T> get value => UnmodifiableSetView<T>(_set);

  Set<T> _helperToSet(Iterable<T> iterable) {
    return iterable is Set<T> ? iterable : iterable.toSet();
  }

  @override
  Set<R> cast<R>() {
    return _set.cast<R>();
  }

  @override
  void addAll(Iterable<T> values) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final Set<T> added = _helperToSet(values).difference(_set);
    if (added.isNotEmpty) {
      _set.addAll(added);
      notifyListeners(SetChangeDetails<T>(added, const []));
    }
  }

  @override
  void clear() {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    if (_set.isNotEmpty) {
      final Set<T> removed = Set<T>.from(_set);
      _set.clear();
      notifyListeners(SetChangeDetails<T>(const [], removed));
    }
  }

  @override
  void addChangeListener(SetChangeListener<T> listener) {
    defaultAddListener(_SetChangeListener<T>(listener));
  }

  @override
  void removeChangeListener(SetChangeListener<T> listener) {
    defaultRemoveListener(_SetChangeListener<T>(listener));
  }

  @override
  void addListener(VoidCallback listener) {
    defaultAddListener(_VoidChangeListener(listener));
  }

  @override
  void removeListener(VoidCallback listener) {
    defaultRemoveListener(_VoidChangeListener(listener));
  }

  @protected
  @visibleForTesting
  @pragma('vm:notify-debugger-on-exception')
  void notifyListeners(SetChangeDetails<T> details) {
    super.defaultNotifyListeners(details);
  }

  @override
  Iterator<T> get iterator => _set.iterator;

  @override
  int get length => _set.length;

  @override
  bool containsAll(Iterable<Object?> other) {
    return _set.containsAll(other);
  }

  @override
  Set<T> difference(Set<Object?> other) {
    return _set.difference(other);
  }

  @override
  Set<T> intersection(Set<Object?> other) {
    return _set.intersection(other);
  }

  @override
  T? lookup(Object? object) {
    return _set.lookup(object);
  }

  @override
  void removeWhere(bool Function(T element) test) {
    final Set<T> removed = _set.where(test).toSet();
    _set.removeAll(removed);
    notifyListeners(SetChangeDetails<T>(const [], removed));
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    final Set<T> removed =
        _set.where((element) => !elements.contains(element)).toSet();
    _set.retainAll(elements);
    notifyListeners(SetChangeDetails<T>(const [], removed));
  }

  @override
  void retainWhere(bool Function(T element) test) {
    final Set<T> removed = _set.where((element) => !test(element)).toSet();
    _set.retainWhere(test);
    notifyListeners(SetChangeDetails<T>(const [], removed));
  }

  @override
  Set<T> union(Set<T> other) {
    return _set.union(other);
  }

  @override
  bool add(T value) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    if (_set.add(value)) {
      notifyListeners(SetChangeDetails<T>([value], const []));
      return true;
    }
    return false;
  }

  @override
  bool remove(Object? value) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    if (_set.remove(value)) {
      notifyListeners(SetChangeDetails<T>(const [], [value as T]));
      return true;
    }
    return false;
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    List<T> removed = [];
    for (final element in elements) {
      if (_set.remove(element)) {
        removed.add(element as T);
      }
    }
    if (removed.isNotEmpty) {
      notifyListeners(SetChangeDetails<T>(const [], removed));
    }
  }
}

class ListNotifier<T> extends ListListenable<T>
    with NotifierHelper, Iterable<T>
    implements List<T> {
  final List<T> _list;

  ListNotifier([List<T> list = const []]) : _list = List<T>.from(list);

  List<T> get value => UnmodifiableListView<T>(_list);

  @protected
  void notifyListeners(ListChangeDetails<T> details) {
    super.defaultNotifyListeners(details);
  }

  @override
  void addListener(VoidCallback listener) {
    defaultAddListener(_VoidChangeListener(listener));
  }

  @override
  void removeListener(VoidCallback listener) {
    defaultRemoveListener(_VoidChangeListener(listener));
  }

  @override
  List<R> cast<R>() {
    return _list.cast<R>();
  }

  @override
  void add(T value) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    _list.add(value);
    notifyListeners(ListChangeDetails<T>([value], const [], _list.length - 1));
  }

  @override
  void addAll(Iterable<T> values) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final int index = _list.length;
    _list.addAll(values);
    notifyListeners(ListChangeDetails<T>(values.toList(), const [], index));
  }

  @override
  void insert(int index, T value) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    _list.insert(index, value);
    notifyListeners(ListChangeDetails<T>([value], const [], index));
  }

  @override
  void insertAll(int index, Iterable<T> values) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    _list.insertAll(index, values);
    notifyListeners(ListChangeDetails<T>(values.toList(), const [], index));
  }

  @override
  void removeRange(int start, int end) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.sublist(start, end);
    _list.removeRange(start, end);
    notifyListeners(ListChangeDetails<T>(const [], removed, start));
  }

  @override
  void removeWhere(bool Function(T element) test) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.where(test).toList();
    for (final value in removed) {
      _list.remove(value);
    }
    notifyListeners(ListChangeDetails<T>(const [], removed, 0));
  }

  @override
  void retainWhere(bool Function(T element) test) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.where((element) => !test(element)).toList();
    for (final value in removed) {
      _list.remove(value);
    }
    notifyListeners(ListChangeDetails<T>(const [], removed, 0));
  }

  @override
  void clear() {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    if (_list.isNotEmpty) {
      final List<T> removed = List<T>.from(_list);
      _list.clear();
      notifyListeners(ListChangeDetails<T>(const [], removed, 0));
    }
  }

  @override
  void sort([int Function(T a, T b)? compare]) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    _list.sort(compare);
    notifyListeners(
        ListChangeDetails<T>(List<T>.from(_list), List<T>.from(_list), 0));
  }

  @override
  void shuffle([Random? random]) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    _list.shuffle(random);
    notifyListeners(
        ListChangeDetails<T>(List<T>.from(_list), List<T>.from(_list), 0));
  }

  @override
  void fillRange(int start, int end, [T? fillValue]) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.sublist(start, end);
    _list.fillRange(start, end, fillValue);
    notifyListeners(ListChangeDetails<T>(List<T>.from(_list), removed, start));
  }

  @override
  void setAll(int index, Iterable<T> values) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.sublist(index, index + values.length);
    _list.setAll(index, values);
    notifyListeners(ListChangeDetails<T>(List<T>.from(_list), removed, index));
  }

  @override
  void setRange(int start, int end, Iterable<T> newContents,
      [int skipCount = 0]) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.sublist(start, end);
    _list.setRange(start, end, newContents, skipCount);
    notifyListeners(ListChangeDetails<T>(List<T>.from(_list), removed, start));
  }

  @override
  void replaceRange(int start, int end, Iterable<T> newContents) {
    assert(NotifierHelper.debugAssertNotDisposed(this));
    final List<T> removed = _list.sublist(start, end);
    _list.replaceRange(start, end, newContents);
    notifyListeners(ListChangeDetails<T>(List<T>.from(_list), removed, start));
  }

  T operator [](int index) => _list[index];

  void operator []=(int index, T value) {
    final T removed = _list[index];
    _list[index] = value;
    notifyListeners(ListChangeDetails<T>([value], [removed], index));
  }

  @override
  void addChangeListener(ListChangeListener<T> listener) {
    defaultAddListener(_ListChangeListener<T>(listener));
  }

  @override
  void removeChangeListener(ListChangeListener<T> listener) {
    defaultRemoveListener(_ListChangeListener<T>(listener));
  }

  @override
  Iterator<T> get iterator => _list.iterator;

  @override
  int get length => _list.length;

  @override
  List<T> operator +(List<T> other) {
    return _list + other;
  }

  @override
  Map<int, T> asMap() {
    return _list.asMap();
  }

  @override
  set first(T value) {
    final T removed = _list.first;
    _list.first = value;
    notifyListeners(ListChangeDetails<T>([value], [removed], 0));
  }

  @override
  Iterable<T> getRange(int start, int end) {
    return _list.getRange(start, end);
  }

  @override
  int indexOf(T element, [int start = 0]) {
    return _list.indexOf(element, start);
  }

  @override
  int indexWhere(bool Function(T element) test, [int start = 0]) {
    return _list.indexWhere(test, start);
  }

  @override
  set last(T value) {
    final T removed = _list.last;
    _list.last = value;
    notifyListeners(ListChangeDetails<T>([value], [removed], _list.length - 1));
  }

  @override
  int lastIndexOf(T element, [int? start]) {
    return _list.lastIndexOf(element, start);
  }

  @override
  int lastIndexWhere(bool Function(T element) test, [int? start]) {
    return _list.lastIndexWhere(test, start);
  }

  @override
  set length(int newLength) {
    final List<T> removed = _list.sublist(newLength);
    _list.length = newLength;
    notifyListeners(ListChangeDetails<T>(const [], removed, newLength));
  }

  @override
  Iterable<T> get reversed => _list.reversed;

  @override
  List<T> sublist(int start, [int? end]) {
    return _list.sublist(start, end);
  }

  @override
  bool remove(Object? value) {
    final int index = _list.indexOf(value as T);
    if (index == -1) {
      return false;
    }
    _list.removeAt(index);
    notifyListeners(ListChangeDetails<T>(const [], [value], index));
    return true;
  }

  @override
  T removeAt(int index) {
    final T removed = _list.removeAt(index);
    notifyListeners(ListChangeDetails<T>(const [], [removed], index));
    return removed;
  }

  @override
  T removeLast() {
    final T removed = _list.removeLast();
    notifyListeners(ListChangeDetails<T>(const [], [removed], _list.length));
    return removed;
  }
}

class MapNotifier<K, V> extends MapListenable<K, V>
    with NotifierHelper
    implements Map<K, V> {
  final Map<K, V> _map;

  MapNotifier([Map<K, V> map = const {}]) : _map = Map<K, V>.from(map);

  Map<K, V> get value => UnmodifiableMapView<K, V>(_map);

  @protected
  void notifyListeners(MapChangeDetails<K, V> details) {
    super.defaultNotifyListeners(details);
  }

  @override
  void addListener(VoidCallback listener) {
    defaultAddListener(_VoidChangeListener(listener));
  }

  @override
  void removeListener(VoidCallback listener) {
    defaultRemoveListener(_VoidChangeListener(listener));
  }

  @override
  V? operator [](Object? key) {
    return _map[key];
  }

  @override
  void operator []=(K key, V value) {
    bool containsKey = _map.containsKey(key);
    V? removed = containsKey ? _map[key] : null;
    _map[key] = value;
    notifyListeners(MapChangeDetails<K, V>([MapEntry(key, value)],
        [if (containsKey) MapEntry(key, removed as V)]));
  }

  @override
  void addAll(Map<K, V> other) {
    final List<MapEntry<K, V>> added = [];
    final List<MapEntry<K, V>> removed = [];
    for (final entry in other.entries) {
      if (_map.containsKey(entry.key)) {
        removed.add(MapEntry(entry.key, _map[entry.key] as V));
      }
      added.add(entry);
    }
    _map.addAll(other);
    notifyListeners(MapChangeDetails<K, V>(added, removed));
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    final List<MapEntry<K, V>> added = [];
    final List<MapEntry<K, V>> removed = [];
    for (final entry in newEntries) {
      if (_map.containsKey(entry.key)) {
        removed.add(MapEntry(entry.key, _map[entry.key] as V));
      }
      added.add(entry);
    }
    _map.addEntries(newEntries);
    notifyListeners(MapChangeDetails<K, V>(added, removed));
  }

  @override
  void addChangeListener(MapChangeListener<K, V> listener) {
    defaultAddListener(_MapChangeListener<K, V>(listener));
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return _map.cast<RK, RV>();
  }

  @override
  void clear() {
    final List<MapEntry<K, V>> removed = _map.entries.toList();
    _map.clear();
    notifyListeners(MapChangeDetails<K, V>(const [], removed));
  }

  @override
  bool containsKey(Object? key) {
    return _map.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return _map.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => _map.entries;

  @override
  void forEach(void Function(K key, V value) action) {
    _map.forEach(action);
  }

  @override
  bool get isEmpty => _map.isEmpty;

  @override
  bool get isNotEmpty => _map.isNotEmpty;

  @override
  Iterable<K> get keys => _map.keys;

  @override
  int get length => _map.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return _map.map(convert);
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    final bool containsKey = _map.containsKey(key);
    V? removed = containsKey ? _map[key] : null;
    V value = _map.putIfAbsent(key, ifAbsent);
    if (containsKey) {
      notifyListeners(MapChangeDetails<K, V>(
          [MapEntry(key, value)], [MapEntry(key, removed as V)]));
    } else {
      notifyListeners(MapChangeDetails<K, V>([MapEntry(key, value)], []));
    }
    return value;
  }

  @override
  V? remove(Object? key) {
    if (!_map.containsKey(key)) {
      return null;
    }
    V removed = _map.remove(key) as V;
    notifyListeners(MapChangeDetails<K, V>([], [MapEntry(key as K, removed)]));
    return removed;
  }

  @override
  void removeChangeListener(MapChangeListener<K, V> listener) {
    defaultRemoveListener(_MapChangeListener<K, V>(listener));
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    final List<MapEntry<K, V>> removed = [];
    for (final entry in _map.entries) {
      if (test(entry.key, entry.value)) {
        removed.add(entry);
      }
    }
    for (final entry in removed) {
      _map.remove(entry.key);
    }
    notifyListeners(MapChangeDetails<K, V>([], removed));
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    final bool containsKey = _map.containsKey(key);
    V? removed = containsKey ? _map[key] : null;
    V value = _map.update(key, update, ifAbsent: ifAbsent);
    if (containsKey) {
      notifyListeners(MapChangeDetails<K, V>(
          [MapEntry(key, value)], [MapEntry(key, removed as V)]));
    } else {
      notifyListeners(MapChangeDetails<K, V>([MapEntry(key, value)], []));
    }
    return value;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    final List<MapEntry<K, V>> added = [];
    final List<MapEntry<K, V>> removed = [];
    for (final entry in _map.entries) {
      V newValue = update(entry.key, entry.value);
      if (_map.containsKey(entry.key)) {
        removed.add(MapEntry(entry.key, _map[entry.key] as V));
      }
      added.add(MapEntry(entry.key, newValue));
    }
    _map.updateAll(update);
    notifyListeners(MapChangeDetails<K, V>(added, removed));
  }

  @override
  Iterable<V> get values => _map.values;
}
