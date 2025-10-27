---
title: "Class: InputFeatureState"
description: "Reference for InputFeatureState"
---

```dart
abstract class InputFeatureState<T extends InputFeature> {
  T get feature;
  TickerProvider get tickerProvider;
  BuildContext get context;
  TextField get input;
  bool get attached;
  TextEditingController get controller;
  void initState();
  void didChangeDependencies();
  void dispose();
  void didFeatureUpdate(InputFeature oldFeature);
  void onTextChanged(String text);
  void onSelectionChanged(TextSelection selection);
  Iterable<Widget> buildLeading();
  Iterable<Widget> buildTrailing();
  Iterable<MapEntry<Type, Action<Intent>>> buildActions();
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts();
  Widget wrap(Widget child);
  TextField interceptInput(TextField input);
  void setState(VoidCallback fn);
}
```
