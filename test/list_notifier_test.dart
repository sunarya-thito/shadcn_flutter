import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  test('List.add triggers the listener', () {
    var list = ListNotifier<int>();
    Iterable<int>? added;
    list.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    list.add(1);
    expect(added, containsAll([1]));
  });

  test('List.remove triggers the listener', () {
    var list = ListNotifier<int>([1]);
    Iterable<int>? removed;
    list.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    list.remove(1);
    expect(removed, containsAll([1]));
  });

  test('List.clear triggers the listener', () {
    var list = ListNotifier<int>([1, 2, 3]);
    Iterable<int>? removed;
    list.addChangeListener(
      (details) {
        removed = details.removed.toList();
      },
    );
    list.clear();
    expect(removed, containsAll([1, 2, 3]));
  });

  test('List.addAll triggers the listener', () {
    var list = ListNotifier<int>();
    Iterable<int>? added;
    list.addChangeListener(
      (details) {
        added = details.added;
      },
    );
    list.addAll([1, 2, 3]);
    expect(added, containsAll([1, 2, 3]));
  });

  test('List.addListener trigger test', () {
    var list = ListNotifier<int>();
    bool triggered = false;
    void listener() {
      triggered = true;
    }

    list.addListener(listener);
    list.add(1);
    expect(triggered, isTrue);
  });

  test('List.removeListener trigger test ', () {
    var list = ListNotifier<int>();
    bool triggered = false;
    void listener() {
      triggered = true;
    }

    list.addListener(listener);
    list.removeListener(listener);
    list.add(1);
    expect(triggered, isFalse);
  });
}
