import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  test('Set.add triggers the listener', () {
    var set = SetNotifier<int>();
    Iterable<int>? added;
    set.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    set.add(1);
    expect(added, containsAll([1]));
  });

  test('Set.remove triggers the listener', () {
    var set = SetNotifier<int>({1});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.remove(1);
    expect(removed, containsAll([1]));
  });

  test('Set.clear triggers the listener', () {
    var set = SetNotifier<int>({1, 2, 3});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.clear();
    expect(removed, containsAll([1, 2, 3]));
  });

  test('Set.addAll triggers the listener', () {
    var set = SetNotifier<int>();
    Iterable<int>? added;
    set.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    set.addAll([1, 2, 3]);
    expect(added, containsAll([1, 2, 3]));
  });

  test('Set.removeAll triggers the listener', () {
    var set = SetNotifier<int>({1, 2, 3});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.removeAll([1, 2]);
    expect(removed, containsAll([1, 2]));
  });

  test('Set.retainAll triggers the listener', () {
    var set = SetNotifier<int>({1, 2, 3});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.retainAll([1, 2]);
    expect(removed, containsAll([3]));
  });

  test('Set.removeWhere triggers the listener', () {
    var set = SetNotifier<int>({1, 2, 3});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.removeWhere((element) => element.isEven);
    expect(removed, containsAll([2]));
  });

  test('Set.retainWhere triggers the listener', () {
    var set = SetNotifier<int>({1, 2, 3});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.retainWhere((element) => element.isEven);
    expect(removed, containsAll([1, 3]));
  });

  test('Set.clear does not trigger the listener if the set is empty', () {
    var set = SetNotifier<int>();
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.clear();
    expect(removed, isNull);
  });

  test('Set.addAll does not trigger the listener if the added set is empty',
      () {
    var set = SetNotifier<int>();
    Iterable<int>? added;
    set.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    set.addAll([]);
    expect(added, isNull);
  });

  test(
      'Set.removeAll does not trigger the listener if the removed set is empty',
      () {
    var set = SetNotifier<int>({1, 2, 3});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.removeAll([]);
    expect(removed, isNull);
  });

  test(
      'Set.remove does not trigger the listener if the element is not in the set',
      () {
    var set = SetNotifier<int>({1});
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.remove(2);
    expect(removed, isNull);
  });

  test('Set.remove does not trigger the listener if the set is empty', () {
    var set = SetNotifier<int>();
    Iterable<int>? removed;
    set.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    set.remove(1);
    expect(removed, isNull);
  });

  test(
      'Set.add does not trigger the listener if the element is already in the set',
      () {
    var set = SetNotifier<int>({1});
    Iterable<int>? added;
    set.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    set.add(1);
    expect(added, isNull);
  });

  test('Set.addAll does not trigger the listener if the added set is empty',
      () {
    var set = SetNotifier<int>();
    Iterable<int>? added;
    set.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    set.addAll([]);
    expect(added, isNull);
  });

  test('Set.addListener trigger test', () {
    var set = SetNotifier<int>();
    bool triggered = false;
    void listener() {
      triggered = true;
    }

    set.addListener(listener);
    set.add(1);
    expect(triggered, isTrue);
  });

  test('Set.removeListener trigger test', () {
    var set = SetNotifier<int>();
    bool triggered = false;
    void listener() {
      triggered = true;
    }

    set.addListener(listener);
    set.removeListener(listener);
    set.add(1);
    expect(triggered, isFalse);
  });
}
