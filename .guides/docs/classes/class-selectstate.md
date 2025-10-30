---
title: "Class: SelectState"
description: "State class for the [Select] widget managing selection and popup interactions."
---

```dart
/// State class for the [Select] widget managing selection and popup interactions.
///
/// This state class handles the select dropdown's internal state including:
/// - Focus management for keyboard navigation
/// - Popup controller for opening/closing the dropdown menu
/// - Value change notifications
/// - Theme integration
///
/// The state implements [FormValueSupplier] to integrate with form validation
/// and value management systems.
///
/// See also:
/// - [Select], the widget that uses this state
/// - [PopoverController], used to control the dropdown popup
/// - [FormValueSupplier], the mixin providing form integration
class SelectState<T> extends State<Select<T>> with FormValueSupplier<T, Select<T>> {
  void didChangeDependencies();
  void initState();
  void didUpdateWidget(Select<T> oldWidget);
  void didReplaceFormValue(T value);
  void dispose();
  Widget build(BuildContext context);
}
```
