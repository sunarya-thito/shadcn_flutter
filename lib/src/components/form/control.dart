import '../../../shadcn_flutter.dart';

mixin ComponentController<T> implements ValueNotifier<T> {}

class ComponentValueController<T> extends ValueNotifier<T>
    implements ComponentController<T> {
  ComponentValueController(super.value);
}

mixin ControlledComponent<T> on Widget {
  ComponentController<T>? get controller;
  T? get initialValue;
  ValueChanged<T>? get onChanged;
  bool get enabled;
}

class ControlledComponentData<T> {
  final T value;
  final ValueChanged<T> onChanged;
  final bool enabled;

  const ControlledComponentData({
    required this.value,
    required this.onChanged,
    required this.enabled,
  });
}

class ControlledComponentAdapter<T> extends StatefulWidget
    with ControlledComponent<T> {
  @override
  final T? initialValue;
  @override
  final ValueChanged<T>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<T>? controller;
  final Widget Function(BuildContext context, ControlledComponentData<T> data)
      builder;

  const ControlledComponentAdapter({
    super.key,
    required this.builder,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.enabled = true,
  }) : assert(controller != null || initialValue is T,
            'Either controller or initialValue must be provided');

  @override
  _ControlledComponentAdapterState<T> createState() =>
      _ControlledComponentAdapterState<T>();
}

class _ControlledComponentAdapterState<T>
    extends State<ControlledComponentAdapter<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    T? value = widget.controller?.value ?? widget.initialValue;
    assert(value != null, 'Either controller or initialValue must be provided');
    _value = value as T;
    widget.controller?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {
      _value = widget.controller!.value;
    });
  }

  @override
  void didUpdateWidget(covariant ControlledComponentAdapter<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }
  }

  void _onChanged(T value) {
    widget.onChanged?.call(value);
    final controller = widget.controller;
    if (controller != null) {
      controller.value = value;
    } else {
      setState(() {
        _value = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      ControlledComponentData(
        value: _value,
        onChanged: _onChanged,
        enabled: widget.enabled,
      ),
    );
  }
}
