---
title: "Class: SubmitButton"
description: "Reference for SubmitButton"
---

```dart
class SubmitButton extends StatelessWidget {
  final AbstractButtonStyle? style;
  final Widget child;
  final Widget? loading;
  final Widget? error;
  final Widget? leading;
  final Widget? trailing;
  final Widget? loadingLeading;
  final Widget? loadingTrailing;
  final Widget? errorLeading;
  final Widget? errorTrailing;
  final AlignmentGeometry? alignment;
  final bool disableHoverEffect;
  final bool? enabled;
  final bool? enableFeedback;
  final bool disableTransition;
  final FocusNode? focusNode;
  const SubmitButton({super.key, required this.child, this.style, this.loading, this.error, this.leading, this.trailing, this.alignment, this.loadingLeading, this.loadingTrailing, this.errorLeading, this.errorTrailing, this.disableHoverEffect = false, this.enabled, this.enableFeedback, this.disableTransition = false, this.focusNode});
  widgets.Widget build(widgets.BuildContext context);
}
```
