---
title: "Class: ChatGroupTheme"
description: "Defines the theme for a [ChatGroup]."
---

```dart
/// Defines the theme for a [ChatGroup].
class ChatGroupTheme extends ComponentThemeData {
  /// The spacing between chat bubbles in the group.
  final double? spacing;
  /// The alignment of the avatar relative to the chat bubbles.
  final AxisAlignmentGeometry? avatarAlignment;
  /// The spacing between the avatar and the chat bubbles.
  final double? avatarSpacing;
  /// Creates a [ChatGroupTheme].
  ///
  /// Parameters:
  /// - [spacing] (`double?`, optional): The spacing between chat bubbles in the group.
  /// - [avatarAlignment] (`AxisAlignmentGeometry?`, optional): The alignment of the avatar relative to the chat bubbles.
  /// - [avatarSpacing] (`double?`, optional): The spacing between the avatar and the chat bubbles.
  const ChatGroupTheme({this.spacing, this.avatarAlignment, this.avatarSpacing});
  /// Creates a copy of this theme with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing value.
  /// - [avatarAlignment] (`ValueGetter<AxisAlignmentGeometry?>?`, optional): New avatar alignment value.
  /// - [avatarSpacing] (`ValueGetter<double?>?`, optional): New avatar spacing value.
  ///
  /// Returns:
  /// A new [ChatGroupTheme] with the specified values updated.
  ChatGroupTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<AxisAlignmentGeometry?>? avatarAlignment, ValueGetter<double?>? avatarSpacing});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
