import 'package:shadcn_flutter/shadcn_flutter.dart';

enum ShadcnState {
  hovered,
  focused,
  pressed,
  dragged,
  selected,
  scrolledUnder,
  disabled,
  error;
}

class ButtonStates {
  static ShadcnState get hovered => ShadcnState.hovered;
  static ShadcnState get focused => ShadcnState.focused;
  static ShadcnState get pressed => ShadcnState.pressed;
  static ShadcnState get disabled => ShadcnState.disabled;

  const ButtonStates._();
}

abstract class ShadcnStateProperty<T> {
  const ShadcnStateProperty._();

  static ShadcnStateBuilder<T> builder<T>(
      T Function(ThemeData theme) resolver) {
    return ShadcnStateBuilder(resolver);
  }

  static ShadcnStateAll<T> all<T>(T Function(ThemeData theme) resolver) {
    return ShadcnStateAll(resolver);
  }

  static ShadcnStateAll<T> direct<T>(T value) {
    return ShadcnStateAll((_) => value);
  }

  T resolveFrom(Set<ShadcnState> states, ThemeData theme);
}

class ShadcnStateAll<T> extends ShadcnStateProperty<T> {
  final T Function(ThemeData theme) _resolver;

  ShadcnStateAll(T Function(ThemeData theme) resolver)
      : _resolver = resolver,
        super._();

  @override
  T resolveFrom(Set<ShadcnState> states, ThemeData theme) {
    return _resolver(theme);
  }
}

class ShadcnStateBuilder<T> extends ShadcnStateProperty<T> {
  final Map<Set<ShadcnState>, T Function(ThemeData theme)> _map = {};

  ShadcnStateBuilder(T Function(ThemeData theme) resolver) : super._() {
    _map[{}] = resolver;
  }

  ShadcnStateBuilder<T> whenMultiple(
      Set<ShadcnState> states, T Function(ThemeData theme) resolver) {
    _map[states] = resolver;
    return this;
  }

  ShadcnStateBuilder<T> when(
      ShadcnState state, T Function(ThemeData theme) resolver) {
    _map[{state}] = resolver;
    return this;
  }

  ShadcnStateBuilder<T> direct(ShadcnState state, T value) {
    _map[{state}] = (_) => value;
    return this;
  }

  ShadcnStateBuilder<T> directMultiple(Set<ShadcnState> states, T value) {
    _map[states] = (_) => value;
    return this;
  }

  @override
  T resolveFrom(Set<ShadcnState> states, ThemeData theme) {
    final matchingStates = _map.keys.firstWhere(
      (element) => element.containsAll(states),
      orElse: () => <ShadcnState>{},
    );

    return _map[matchingStates]!(theme);
  }
}
