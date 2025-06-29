import 'package:shadcn_flutter/shadcn_flutter.dart';

mixin Choice<T> {
  static void choose<T>(BuildContext context, T item) {
    Data.of<Choice<T>>(context).selectItem(item);
  }

  static Iterable<T>? getValue<T>(BuildContext context) {
    return Data.of<Choice<T>>(context).value;
  }

  void selectItem(T item);
  Iterable<T>? get value;
}

class MultipleAnswerController<T> extends ValueNotifier<Iterable<T>?>
    with ComponentController<Iterable<T>?> {
  MultipleAnswerController([super.value]);
}

class MultipleChoiceController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  MultipleChoiceController([super.value]);
}

class ControlledMultipleAnswer<T> extends StatelessWidget
    with ControlledComponent<Iterable<T>?> {
  @override
  final MultipleAnswerController<T>? controller;
  @override
  final Iterable<T>? initialValue;
  @override
  final ValueChanged<Iterable<T>?>? onChanged;
  @override
  final bool enabled;
  final bool allowUnselect;
  final Widget child;

  const ControlledMultipleAnswer({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.enabled = true,
    this.allowUnselect = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<Iterable<T>?>(
      builder: (context, data) {
        return MultipleAnswer<T>(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          allowUnselect: allowUnselect,
          child: child,
        );
      },
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}

class ControlledMultipleChoice<T> extends StatelessWidget
    with ControlledComponent<T?> {
  @override
  final MultipleChoiceController<T>? controller;
  @override
  final T? initialValue;
  @override
  final ValueChanged<T?>? onChanged;
  @override
  final bool enabled;
  final bool allowUnselect;
  final Widget child;

  const ControlledMultipleChoice({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.enabled = true,
    this.allowUnselect = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<T?>(
      builder: (context, data) {
        return MultipleChoice<T>(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          allowUnselect: allowUnselect,
          child: child,
        );
      },
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}

class MultipleChoice<T> extends StatefulWidget {
  final Widget child;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool? enabled;
  final bool allowUnselect;

  const MultipleChoice({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
    this.allowUnselect = false,
  });

  @override
  State<MultipleChoice<T>> createState() => _MultipleChoiceState<T>();
}

class _MultipleChoiceState<T> extends State<MultipleChoice<T>>
    with Choice<T>, FormValueSupplier<T?, MultipleChoice<T>> {
  @override
  void didReplaceFormValue(T? value) {
    widget.onChanged?.call(value);
  }

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant MultipleChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<Choice<T>>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void selectItem(T item) {
    if (widget.enabled == false) {
      return;
    }
    if (widget.value != null && widget.value != item) {
      return;
    }
    if (widget.onChanged != null) {
      if (widget.value == item) {
        if (widget.allowUnselect) {
          widget.onChanged?.call(null);
        }
      } else {
        widget.onChanged?.call(item);
      }
    }
  }

  @override
  Iterable<T>? get value {
    T? value = widget.value;
    if (value == null) {
      return null;
    }
    return [value];
  }
}

class MultipleAnswer<T> extends StatefulWidget {
  final Widget child;
  final Iterable<T>? value;
  final ValueChanged<Iterable<T>?>? onChanged;
  final bool? enabled;
  final bool allowUnselect;

  const MultipleAnswer({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
    this.allowUnselect = true,
  });

  @override
  State<MultipleAnswer<T>> createState() => _MultipleAnswerState<T>();
}

class _MultipleAnswerState<T> extends State<MultipleAnswer<T>>
    with Choice<T>, FormValueSupplier<Iterable<T>, MultipleAnswer<T>> {
  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant MultipleAnswer<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<Choice<T>>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void selectItem(T item) {
    if (widget.enabled == false) {
      return;
    }
    var value = widget.value;
    if (value == null) {
      widget.onChanged?.call([item]);
    } else if (value.contains(item)) {
      if (widget.allowUnselect) {
        widget.onChanged?.call(value.where((e) => e != item));
      }
    } else {
      widget.onChanged?.call(value.followedBy([item]));
    }
  }

  @override
  Iterable<T>? get value {
    return widget.value;
  }

  @override
  void didReplaceFormValue(Iterable<T>? value) {
    widget.onChanged?.call(value);
  }
}
