import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A modal dialog component for displaying important alerts and confirmations.
///
/// AlertDialog provides a focused overlay interface for critical user interactions
/// that require immediate attention or confirmation. Built on top of [ModalBackdrop]
/// and [ModalContainer], it ensures proper accessibility and visual hierarchy.
///
/// The dialog features a flexible layout system supporting optional leading/trailing
/// icons, title text, descriptive content, and customizable action buttons. All
/// elements automatically adapt to the current theme's color scheme and scaling.
///
/// Key features:
/// - Modal presentation with backdrop blur and overlay
/// - Flexible content layout with optional elements
/// - Automatic theme integration and responsive scaling
/// - Customizable surface effects (blur, opacity)
/// - Action button layout with proper spacing
/// - Safe area handling for various screen sizes
///
/// The component is a StatefulWidget to manage internal modal state and
/// ensure proper lifecycle management during show/hide transitions.
///
/// Example:
/// ```dart
/// AlertDialog(
///   leading: Icon(Icons.warning),
///   title: Text('Delete Item'),
///   content: Text('Are you sure you want to delete this item?'),
///   actions: [
///     Button.ghost(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
///     Button.destructive(onPressed: _deleteItem, child: Text('Delete')),
///   ],
/// );
/// ```
class AlertDialog extends StatefulWidget {
  /// Optional leading widget, typically an icon or graphic.
  ///
  /// Type: `Widget?`. Displayed at the start of the dialog header with
  /// automatic icon styling (XL size, muted foreground color).
  final Widget? leading;

  /// Optional trailing widget for additional dialog controls.
  ///
  /// Type: `Widget?`. Positioned at the end of the dialog header with
  /// similar styling to the leading widget.
  final Widget? trailing;

  /// Optional title widget for the dialog header.
  ///
  /// Type: `Widget?`. Displayed prominently with large, semi-bold text styling.
  /// Should contain the primary message or question for the user.
  final Widget? title;

  /// Optional content widget for detailed dialog information.
  ///
  /// Type: `Widget?`. Provides additional context or description with
  /// small, muted text styling. Positioned below the title.
  final Widget? content;

  /// Optional list of action buttons for user interaction.
  ///
  /// Type: `List<Widget>?`. Buttons are arranged horizontally at the bottom
  /// of the dialog with consistent spacing. Typically includes cancel and
  /// confirmation options.
  final List<Widget>? actions;

  /// Surface blur intensity for the modal backdrop.
  ///
  /// Type: `double?`. If null, uses theme default blur value.
  /// Higher values create more pronounced background blur effects.
  final double? surfaceBlur;

  /// Surface opacity for the modal backdrop.
  ///
  /// Type: `double?`. If null, uses theme default opacity value.
  /// Controls the transparency level of the backdrop overlay.
  final double? surfaceOpacity;

  /// Barrier color for the modal backdrop.
  ///
  /// Type: `Color?`. If null, defaults to black with 80% opacity.
  /// The color overlay applied behind the dialog content.
  final Color? barrierColor;

  /// Internal padding for the dialog content.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses responsive padding
  /// based on theme scaling (24 * scaling). Controls spacing around
  /// all dialog content.
  final EdgeInsetsGeometry? padding;

  /// Creates an [AlertDialog].
  ///
  /// All parameters are optional, allowing for flexible dialog configurations
  /// from simple text alerts to complex confirmation interfaces.
  ///
  /// Parameters:
  /// - [leading] (Widget?, optional): Icon or graphic at dialog start
  /// - [title] (Widget?, optional): Primary dialog heading
  /// - [content] (Widget?, optional): Detailed description or message
  /// - [actions] (`List<Widget>?`, optional): Action buttons for user response
  /// - [trailing] (Widget?, optional): Additional controls at dialog end
  /// - [surfaceBlur] (double?, optional): Backdrop blur intensity
  /// - [surfaceOpacity] (double?, optional): Backdrop opacity level
  /// - [barrierColor] (Color?, optional): Backdrop overlay color
  /// - [padding] (EdgeInsetsGeometry?, optional): Internal content padding
  ///
  /// Example:
  /// ```dart
  /// AlertDialog(
  ///   title: Text('Confirm Action'),
  ///   content: Text('This action cannot be undone.'),
  ///   actions: [
  ///     TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
  ///     ElevatedButton(onPressed: _confirm, child: Text('Confirm')),
  ///   ],
  /// );
  /// ```
  const AlertDialog({
    super.key,
    this.leading,
    this.title,
    this.content,
    this.actions,
    this.trailing,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.barrierColor,
    this.padding,
  });

  @override
  State<AlertDialog> createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialog> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var scaling = themeData.scaling;
    return ModalBackdrop(
      borderRadius: themeData.borderRadiusXxl,
      barrierColor: widget.barrierColor ?? Colors.black.withValues(alpha: 0.8),
      surfaceClip: ModalBackdrop.shouldClipSurface(
          widget.surfaceOpacity ?? themeData.surfaceOpacity),
      child: ModalContainer(
        fillColor: themeData.colorScheme.popover,
        filled: true,
        borderRadius: themeData.borderRadiusXxl,
        borderWidth: 1 * scaling,
        borderColor: themeData.colorScheme.muted,
        padding: widget.padding ?? EdgeInsets.all(24 * scaling),
        surfaceBlur: widget.surfaceBlur ?? themeData.surfaceBlur,
        surfaceOpacity: widget.surfaceOpacity ?? themeData.surfaceOpacity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null)
                    widget.leading!.iconXLarge().iconMutedForeground(),
                  if (widget.title != null || widget.content != null)
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title != null)
                            widget.title!.large().semiBold(),
                          if (widget.content != null)
                            widget.content!.small().muted(),
                        ],
                      ).gap(8 * scaling),
                    ),
                  if (widget.trailing != null)
                    widget.trailing!.iconXLarge().iconMutedForeground(),
                ],
              ).gap(16 * scaling),
            ),
            if (widget.actions != null && widget.actions!.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                // children: widget.actions!,
                children: join(widget.actions!, SizedBox(width: 8 * scaling))
                    .toList(),
              ),
          ],
        ).gap(16 * scaling),
      ),
    );
  }
}
