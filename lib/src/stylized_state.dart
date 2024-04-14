enum ShadcnState {
  hovered,
  focused,
  pressed,
  dragged,
  selected,
  scrolledUnder,
  disabled,
  error,
}

typedef ShadcnPropertyResolver<T> = T Function(Set<ShadcnState> states);

abstract class ShadcnStateProperty<T> {
  const ShadcnStateProperty._();
  factory ShadcnStateProperty(ShadcnPropertyResolver<T> resolver) {
    return ShadcnStatePropertyBuilder(resolver);
  }
  factory ShadcnStateProperty.mapped(Map<Set<ShadcnState>, T> map) {
    return ShadcnStatePropertyMap(map);
  }
  T resolveFrom(Set<ShadcnState> states);
}

class ShadcnStatePropertyBuilder<T> extends ShadcnStateProperty<T> {
  final ShadcnPropertyResolver<T> resolver;

  const ShadcnStatePropertyBuilder(this.resolver) : super._();

  @override
  T resolveFrom(Set<ShadcnState> states) {
    return resolver(states);
  }
}

class ShadcnStatePropertyMap<T> extends ShadcnStateProperty<T> {
  final Map<Set<ShadcnState>, T> _map;

  const ShadcnStatePropertyMap(this._map) : super._();

  @override
  T resolveFrom(Set<ShadcnState> states) {
    for (final entry in _map.entries) {
      // contains any
      if (entry.key.any((state) => states.contains(state))) {
        return entry.value;
      }
    }
    return _map[{}]!;
  }
}
