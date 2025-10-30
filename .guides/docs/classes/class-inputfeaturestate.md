---
title: "Class: InputFeatureState"
description: "Abstract base state class for input features."
---

```dart
/// Abstract base state class for input features.
///
/// Manages the lifecycle and state of features that extend text field
/// functionality, such as clear buttons, counters, or custom decorations.
abstract class InputFeatureState<T extends InputFeature> {
  /// The input feature associated with this state.
  T get feature;
  /// The ticker provider for animations.
  TickerProvider get tickerProvider;
  /// The build context for this feature.
  BuildContext get context;
  /// The parent text field widget.
  TextField get input;
  /// Whether this feature is currently attached to a text field.
  bool get attached;
  /// The text editing controller for the text field.
  TextEditingController get controller;
  /// Initializes this feature state.
  ///
  /// Called when the feature is first attached to a text field.
  void initState();
  /// Called when dependencies change.
  ///
  /// Override to respond to dependency changes in the widget tree.
  void didChangeDependencies();
  /// Disposes resources used by this feature state.
  ///
  /// Called when the feature is detached from the text field.
  void dispose();
  /// Called when the feature is updated.
  ///
  /// Override to respond to feature configuration changes.
  void didFeatureUpdate(InputFeature oldFeature);
  /// Called when the text field's text changes.
  ///
  /// Override to respond to text changes.
  void onTextChanged(String text);
  /// Called when the text field's selection changes.
  ///
  /// Override to respond to selection changes.
  void onSelectionChanged(TextSelection selection);
  /// Builds leading widgets for the text field.
  ///
  /// Override to provide widgets shown before the input.
  Iterable<Widget> buildLeading();
  /// Builds trailing widgets for the text field.
  ///
  /// Override to provide widgets shown after the input.
  Iterable<Widget> buildTrailing();
  /// Builds actions for keyboard shortcuts.
  ///
  /// Override to provide custom actions.
  Iterable<MapEntry<Type, Action<Intent>>> buildActions();
  /// Builds keyboard shortcuts.
  ///
  /// Override to provide custom keyboard shortcuts.
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts();
  /// Wraps the text field widget.
  ///
  /// Override to wrap the field with additional widgets.
  Widget wrap(Widget child);
  /// Intercepts and modifies the text field configuration.
  ///
  /// Override to modify the text field before rendering.
  TextField interceptInput(TextField input);
  /// Triggers a state update for the attached text field.
  ///
  /// Parameters:
  /// - [fn] (`VoidCallback`, required): State update callback.
  ///
  /// Throws: AssertionError if feature is not attached.
  void setState(VoidCallback fn);
}
```
