import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Since MapEntry does not override operator==, we need to create a custom matcher
class ContainsMapEntry<K, V> extends Matcher {
  final MapEntry<K, V> entry;

  ContainsMapEntry(this.entry);

  @override
  Description describe(Description description) {
    return description.add('contains ').addDescriptionOf(entry);
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is Iterable<MapEntry<K, V>>) {
      for (var i in item) {
        if (i.key == entry.key && i.value == entry.value) {
          return true;
        }
      }
    }
    return false;
  }
}

main() {
  test('Map.add triggers the listener', () {
    var map = MapNotifier<int, int>();
    Iterable<MapEntry<int, int>>? added;
    map.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    map[1] = 1;
    expect(added, ContainsMapEntry(const MapEntry(1, 1)));
  });

  test('Map.remove triggers the listener', () {
    var map = MapNotifier<int, int>({1: 1});
    Iterable<MapEntry<int, int>>? removed;
    map.addChangeListener(
      (details) {
        removed = details.removed;
      },
    );
    map.remove(1);
    expect(removed, ContainsMapEntry(const MapEntry(1, 1)));
  });

  test('Map.clear triggers the listener', () {
    var map = MapNotifier<int, int>({1: 1, 2: 2, 3: 3});
    Iterable<MapEntry<int, int>>? removed;
    map.addChangeListener(
      (details) {
        removed = details.removed;
      },
    );
    map.clear();
    expect(removed, ContainsMapEntry(const MapEntry(1, 1)));
    expect(removed, ContainsMapEntry(const MapEntry(2, 2)));
    expect(removed, ContainsMapEntry(const MapEntry(3, 3)));
  });

  test('Map.addAll triggers the listener', () {
    var map = MapNotifier<int, int>();
    Iterable<MapEntry<int, int>>? added;
    map.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    map.addAll({1: 1, 2: 2, 3: 3});
    expect(added, ContainsMapEntry(const MapEntry(1, 1)));
    expect(added, ContainsMapEntry(const MapEntry(2, 2)));
    expect(added, ContainsMapEntry(const MapEntry(3, 3)));
  });

  test('Map.removeWhere triggers the listener', () {
    var map = MapNotifier<int, int>({1: 1, 2: 2, 3: 3});
    Iterable<MapEntry<int, int>>? removed;
    map.addChangeListener(
      (details) {
        removed = details.removed;
      },
    );
    map.removeWhere((key, value) => key.isEven);
    expect(removed, ContainsMapEntry(const MapEntry(2, 2)));
  });

  test('Map.update triggers the listener', () {
    var map = MapNotifier<int, int>({1: 1});
    Iterable<MapEntry<int, int>>? added;
    Iterable<MapEntry<int, int>>? removed;
    map.addChangeListener(
      (details) {
        added = details.added;
        removed = details.removed;
      },
    );
    map.update(1, (value) => value + 1, ifAbsent: () => 0);
    expect(added, ContainsMapEntry(const MapEntry(1, 2)));
    expect(removed, ContainsMapEntry(const MapEntry(1, 1)));
  });

  test('Map.updateAll triggers the listener', () {
    var map = MapNotifier<int, int>({1: 1, 2: 2, 3: 3});
    Iterable<MapEntry<int, int>>? added;
    Iterable<MapEntry<int, int>>? removed;
    map.addChangeListener(
      (details) {
        added = details.added;
        removed = details.removed;
      },
    );
    map.updateAll((key, value) => value + 1);
    expect(added, ContainsMapEntry(const MapEntry(1, 2)));
    expect(added, ContainsMapEntry(const MapEntry(2, 3)));
    expect(added, ContainsMapEntry(const MapEntry(3, 4)));
    expect(removed, ContainsMapEntry(const MapEntry(1, 1)));
    expect(removed, ContainsMapEntry(const MapEntry(2, 2)));
    expect(removed, ContainsMapEntry(const MapEntry(3, 3)));
  });

  test('Map= triggers the listener', () {
    var map = MapNotifier<int, int>({1: 1});
    Iterable<MapEntry<int, int>>? added;
    Iterable<MapEntry<int, int>>? removed;
    map.addChangeListener(
      (details) {
        added = details.added;
        removed = details.removed;
      },
    );
    map[1] = 2;
    expect(added, ContainsMapEntry(const MapEntry(1, 2)));
    expect(removed, ContainsMapEntry(const MapEntry(1, 1)));
  });

  test('Map.addListener trigger test', () {
    var map = MapNotifier<int, int>();
    bool triggered = false;
    void listener() {
      triggered = true;
    }

    map.addListener(listener);
    map[1] = 1;
    expect(triggered, isTrue);
  });

  test('Map.removeListener trigger test', () {
    var map = MapNotifier<int, int>();
    bool triggered = false;
    void listener() {
      triggered = true;
    }

    map.addListener(listener);
    map.removeListener(listener);
    map[1] = 1;
    expect(triggered, isFalse);
  });
}
