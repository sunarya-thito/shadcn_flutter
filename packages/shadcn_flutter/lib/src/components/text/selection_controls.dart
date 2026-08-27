import 'package:flutter/widgets.dart';

/// Text selection handle controls that draw no drag handles.
///
/// shadcn_flutter renders its own selection toolbar through
/// [EditableText.contextMenuBuilder] (see [buildEditableTextContextMenu]), so
/// the only job left for [TextSelectionControls] is the drag handles. Desktop
/// platforms have none, which makes this implementation empty by design.
///
/// Mixing in [TextSelectionHandleControls] opts out of the deprecated
/// `buildToolbar` path entirely, so no toolbar is ever built from here.
class _ShadcnTextSelectionHandleControls extends TextSelectionControls
    with TextSelectionHandleControls {
  /// There are no handles, so they occupy no space.
  @override
  Size getHandleSize(double textLineHeight) => Size.zero;

  /// There are no handles, so nothing is painted.
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    return const SizedBox.shrink();
  }

  /// There are no handles, so there is nothing to anchor.
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return Offset.zero;
  }
}

/// Handle-less text selection controls used by shadcn_flutter text inputs.
///
/// Selection *handles* are suppressed; the selection *toolbar* is provided
/// separately by [buildEditableTextContextMenu], which renders shadcn styled
/// menus and adapts between the mobile and desktop layouts.
///
/// Assign this to [TextField.selectionControls] (it is already the default) or
/// to any other widget taking [TextSelectionControls]:
///
/// ```dart
/// EditableText(
///   selectionControls: shadcnTextSelectionHandleControls,
///   contextMenuBuilder: buildEditableTextContextMenu,
///   // ...
/// );
/// ```
final TextSelectionControls shadcnTextSelectionHandleControls =
    _ShadcnTextSelectionHandleControls();
