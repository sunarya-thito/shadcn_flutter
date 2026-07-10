import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that constrains the width of its child based on a factor and aligns it.
///
/// This widget is used by [ChatBubble] to limit the width of the bubble relative to
/// the available width and to align it within that space.
///
/// Parameters:
/// - [widthFactor] (`double`, required): The fraction of the available width that the child should occupy.
/// - [alignment] (`AxisAlignmentGeometry`, required): The alignment of the child within the available space.
/// - [child] (`Widget`, required): The widget below this widget in the tree.
class ChatConstrainedBox extends SingleChildRenderObjectWidget {
  /// The fraction of the available width that the child should occupy.
  final double widthFactor;

  /// The alignment of the child within the available space.
  final AxisAlignmentGeometry alignment;

  /// Creates a [ChatConstrainedBox].
  const ChatConstrainedBox({
    required this.widthFactor,
    required this.alignment,
    required super.child,
    super.key,
  });

  @override
  RenderChatConstrainedBox createRenderObject(BuildContext context) {
    return RenderChatConstrainedBox(
      widthFactor: widthFactor,
      alignment: alignment
          .resolve(Directionality.maybeOf(context) ?? TextDirection.ltr),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderChatConstrainedBox renderObject) {
    renderObject
      ..widthFactor = widthFactor
      ..alignment = alignment
          .resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);
  }
}

/// A render object that constrains the width of its child and aligns it.
///
/// This render object implements the layout logic for [ChatConstrainedBox].
class RenderChatConstrainedBox extends RenderShiftedBox {
  double _widthFactor;
  AxisAlignment _alignment;

  /// Creates a [RenderChatConstrainedBox].
  ///
  /// Parameters:
  /// - [widthFactor] (`double`, required): The fraction of the available width that the child should occupy.
  /// - [alignment] (`AxisAlignment`, required): The alignment of the child within the available space.
  /// - [child] (`RenderBox?`, optional): The child render object.
  RenderChatConstrainedBox({
    required double widthFactor,
    required AxisAlignment alignment,
    RenderBox? child,
  })  : _widthFactor = widthFactor,
        _alignment = alignment,
        super(child);

  /// The fraction of the available width that the child should occupy.
  double get widthFactor => _widthFactor;

  /// The alignment of the child within the available space.
  AxisAlignment get alignment => _alignment;

  /// Sets the width factor.
  set widthFactor(double value) {
    if (_widthFactor != value) {
      _widthFactor = value;
      markNeedsLayout();
    }
  }

  /// Sets the alignment.
  set alignment(AxisAlignment value) {
    if (_alignment != value) {
      _alignment = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    if (child == null) {
      size = this.constraints.smallest;
      return;
    }
    var constraints = this.constraints;
    var newMaxWidth = constraints.maxWidth * _widthFactor;
    constraints = constraints.copyWith(maxWidth: newMaxWidth, minWidth: 0);
    child!.layout(constraints, parentUsesSize: true);
    size = this
        .constraints
        .constrain(Size(this.constraints.maxWidth, child!.size.height));
    double x = _alignment.alongValue(
        Axis.horizontal, this.constraints.maxWidth - child!.size.width);
    final data = child!.parentData as BoxParentData;
    data.offset = Offset(x, 0);
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    if (child == null) {
      return constraints.smallest;
    }
    var newMaxWidth = constraints.maxWidth * _widthFactor;
    var newConstraints =
        constraints.copyWith(maxWidth: newMaxWidth, minWidth: 0);
    Size childSize = child!.getDryLayout(newConstraints);
    return constraints.constrain(Size(constraints.maxWidth, childSize.height));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return super.computeMaxIntrinsicHeight(width * _widthFactor);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return super.computeMinIntrinsicHeight(width * _widthFactor);
  }
}

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
  const ChatGroupTheme({
    this.spacing,
    this.avatarAlignment,
    this.avatarSpacing,
  });

  /// Creates a copy of this theme with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing value.
  /// - [avatarAlignment] (`ValueGetter<AxisAlignmentGeometry?>?`, optional): New avatar alignment value.
  /// - [avatarSpacing] (`ValueGetter<double?>?`, optional): New avatar spacing value.
  ///
  /// Returns:
  /// A new [ChatGroupTheme] with the specified values updated.
  ChatGroupTheme copyWith({
    ValueGetter<double?>? spacing,
    ValueGetter<AxisAlignmentGeometry?>? avatarAlignment,
    ValueGetter<double?>? avatarSpacing,
  }) {
    return ChatGroupTheme(
      spacing: spacing == null ? this.spacing : spacing(),
      avatarAlignment:
          avatarAlignment == null ? this.avatarAlignment : avatarAlignment(),
      avatarSpacing:
          avatarSpacing == null ? this.avatarSpacing : avatarSpacing(),
    );
  }

  @override
  String toString() {
    return 'ChatGroupTheme(spacing: $spacing, avatarAlignment: $avatarAlignment, avatarSpacing: $avatarSpacing)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatGroupTheme &&
        other.spacing == spacing &&
        other.avatarAlignment == avatarAlignment &&
        other.avatarSpacing == avatarSpacing;
  }

  @override
  int get hashCode {
    return Object.hash(spacing, avatarAlignment, avatarSpacing);
  }
}

/// Defines the theme for [ChatBubble]s.
class ChatTheme extends ComponentThemeData {
  /// The background color of the chat bubble.
  final Color? color;

  /// The alignment of the chat bubble.
  final AxisAlignmentGeometry? alignment;

  /// The type of the chat bubble (e.g., plain, tailed).
  final ChatBubbleType? type;

  /// The border radius of the chat bubble.
  final BorderRadiusGeometry? borderRadius;

  /// The padding inside the chat bubble.
  final EdgeInsetsGeometry? padding;

  /// The border of the chat bubble.
  final BorderSide? border;

  /// The width factor of the chat bubble.
  final double? widthFactor;

  /// Creates a [ChatTheme].
  ///
  /// Parameters:
  /// - [color] (`Color?`, optional): The background color of the chat bubble.
  /// - [alignment] (`AxisAlignmentGeometry?`, optional): The alignment of the chat bubble.
  /// - [type] (`ChatBubbleType?`, optional): The type of the chat bubble (e.g., plain, tailed).
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the chat bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the chat bubble.
  /// - [border] (`BorderSide?`, optional): The border of the chat bubble.
  /// - [widthFactor] (`double?`, optional): The width factor of the chat bubble.
  const ChatTheme({
    this.color,
    this.alignment,
    this.type,
    this.borderRadius,
    this.padding,
    this.border,
    this.widthFactor,
  });

  /// Creates a copy of this theme with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [color] (`ValueGetter<Color?>?`, optional): New color value.
  /// - [alignment] (`ValueGetter<AxisAlignmentGeometry?>?`, optional): New alignment value.
  /// - [type] (`ValueGetter<ChatBubbleType?>?`, optional): New type value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): New border radius value.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding value.
  /// - [border] (`ValueGetter<BorderSide?>?`, optional): New border value.
  ///
  /// Returns:
  /// A new [ChatTheme] with the specified values updated.
  ChatTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<AxisAlignmentGeometry?>? alignment,
    ValueGetter<ChatBubbleType?>? type,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<BorderSide?>? border,
    ValueGetter<double?>? widthFactor,
  }) {
    return ChatTheme(
      color: color == null ? this.color : color(),
      alignment: alignment == null ? this.alignment : alignment(),
      type: type == null ? this.type : type(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      border: border == null ? this.border : border(),
      widthFactor: widthFactor == null ? this.widthFactor : widthFactor(),
    );
  }

  @override
  String toString() {
    return 'ChatTheme(color: $color, alignment: $alignment, type: $type, borderRadius: $borderRadius, padding: $padding, border: $border, widthFactor: $widthFactor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatTheme &&
        other.color == color &&
        other.alignment == alignment &&
        other.type == type &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.border == border &&
        other.widthFactor == widthFactor;
  }

  @override
  int get hashCode {
    return Object.hash(
        color, alignment, type, borderRadius, padding, border, widthFactor);
  }
}

/// A widget that groups multiple [ChatBubble]s together.
///
/// This widget handles the layout and styling of a group of chat bubbles,
/// including avatar positioning and spacing.
///
/// Example:
/// ```dart
/// ChatGroup(
///   avatarPrefix: Avatar(child: Text('A')),
///   children: [
///     ChatBubble(child: Text('Hello')),
///     ChatBubble(child: Text('How are you?')),
///   ],
/// )
/// ```
class ChatGroup extends StatelessWidget {
  /// The widget to display before the chat bubbles (e.g., an avatar).
  final Widget? avatarPrefix;

  /// The widget to display after the chat bubbles.
  final Widget? avatarSuffix;

  /// The list of chat bubbles to display.
  final List<Widget> children;

  /// The alignment of the chat bubbles within the group.
  final AxisAlignmentGeometry? alignment;

  /// The background color of the chat bubbles.
  final Color? color;

  /// The type of the chat bubbles.
  final ChatBubbleType? type;

  /// The border radius of the chat bubbles.
  final BorderRadiusGeometry? borderRadius;

  /// The padding inside the chat bubbles.
  final EdgeInsetsGeometry? padding;

  /// The border of the chat bubbles.
  final BorderSide? border;

  /// The spacing between chat bubbles.
  final double? spacing;

  /// The alignment of the avatar.
  final AxisAlignmentGeometry? avatarAlignment;

  /// The spacing between the avatar and the chat bubbles.
  final double? avatarSpacing;

  /// Creates a [ChatGroup].
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): The list of chat bubbles to display.
  /// - [alignment] (`AxisAlignmentGeometry?`, optional): The alignment of the chat bubbles within the group.
  /// - [color] (`Color?`, optional): The background color of the chat bubbles.
  /// - [type] (`ChatBubbleType?`, optional): The type of the chat bubbles.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the chat bubbles.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the chat bubbles.
  /// - [border] (`BorderSide?`, optional): The border of the chat bubbles.
  /// - [spacing] (`double?`, optional): The spacing between chat bubbles.
  /// - [avatarPrefix] (`Widget?`, optional): The widget to display before the chat bubbles.
  /// - [avatarSuffix] (`Widget?`, optional): The widget to display after the chat bubbles.
  /// - [avatarAlignment] (`AxisAlignmentGeometry?`, optional): The alignment of the avatar.
  /// - [avatarSpacing] (`double?`, optional): The spacing between the avatar and the chat bubbles.
  const ChatGroup({
    super.key,
    required this.children,
    this.alignment,
    this.color,
    this.type,
    this.borderRadius,
    this.padding,
    this.border,
    this.spacing,
    this.avatarPrefix,
    this.avatarSuffix,
    this.avatarAlignment,
    this.avatarSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChatTheme>(context);
    final color = styleValue(
        widgetValue: this.color,
        themeValue: compTheme?.color,
        defaultValue: theme.colorScheme.primary);
    final type = styleValue(
        widgetValue: this.type,
        themeValue: compTheme?.type,
        defaultValue: ChatBubbleType.tail);
    final groupTheme = ComponentTheme.maybeOf<ChatGroupTheme>(context);
    final avatarAlignment = styleValue(
      widgetValue: this.avatarAlignment,
      themeValue: groupTheme?.avatarAlignment,
      defaultValue: AxisAlignmentDirectional.end,
    )
        .resolve(Directionality.maybeOf(context) ?? TextDirection.ltr)
        .asVerticalAlignment(AxisAlignment.center);
    return ComponentTheme<ChatTheme>(
      data: compTheme?.copyWith(
            alignment: alignment == null ? null : () => alignment,
            border: border == null ? null : () => border,
            borderRadius: borderRadius == null ? null : () => borderRadius,
            color: this.color == null ? null : () => this.color,
            padding: padding == null ? null : () => padding,
            type: this.type == null ? null : () => this.type,
          ) ??
          ChatTheme(
            alignment: alignment,
            border: border,
            borderRadius: borderRadius,
            color: color,
            padding: padding,
            type: type,
          ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: styleValue(
              widgetValue: avatarSpacing,
              themeValue: groupTheme?.avatarSpacing,
              defaultValue: 8 * theme.scaling),
          children: [
            if (avatarPrefix != null)
              Align(
                alignment: avatarAlignment,
                child: avatarPrefix!,
              ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: styleValue(
                    widgetValue: spacing,
                    themeValue: groupTheme?.spacing,
                    defaultValue: 2 * theme.scaling),
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < children.length; i++)
                    Data.inherit(
                      data: ChatBubbleData(
                        index: i,
                        length: children.length,
                      ),
                      child: children[i],
                    )
                ],
              ),
            ),
            if (avatarSuffix != null)
              Align(
                alignment: avatarAlignment,
                child: avatarSuffix!,
              ),
          ],
        ),
      ),
    );
  }
}

/// Defines the type of a [ChatBubble].
///
/// This abstract class allows for different visual styles of chat bubbles,
/// such as plain bubbles or bubbles with tails.
abstract class ChatBubbleType {
  /// A plain bubble with no tail.
  static const plain = PlainChatBubbleType();

  /// A bubble with an external triangular tail.
  static const tail = TailChatBubbleType();

  /// A bubble with one sharp corner instead of rounded.
  static const sharpCorner = SharpCornerChatBubbleType();

  /// Creates a [ChatBubbleType].
  const ChatBubbleType();

  /// Wraps the child widget with the bubble styling.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [child] (`Widget`, required): The child widget to wrap.
  /// - [data] (`ChatBubbleData`, required): The data associated with the bubble.
  /// - [chat] (`ChatBubble`, required): The chat bubble widget itself.
  ///
  /// Returns:
  /// A [Widget] that wraps the child with the bubble styling.
  Widget wrap(
      BuildContext context, Widget child, ChatBubbleData data, ChatBubble chat);
}

/// Defines the corner of a [ChatBubble] where a tail might be attached.
enum ChatBubbleCorner {
  /// The top-left corner.
  topLeft,

  /// The top-right corner.
  topRight,

  /// The bottom-left corner.
  bottomLeft,

  /// The bottom-right corner.
  bottomRight;
}

/// Defines the directional corner of a [ChatBubble].
///
/// This is used to support RTL languages by defining corners in terms of
/// start and end instead of left and right.
enum ChatBubbleCornerDirectional {
  /// The top-start corner (top-left in LTR, top-right in RTL).
  topStart,

  /// The top-end corner (top-right in LTR, top-left in RTL).
  topEnd,

  /// The bottom-start corner (bottom-left in LTR, bottom-right in RTL).
  bottomStart,

  /// The bottom-end corner (bottom-right in LTR, bottom-left in RTL).
  bottomEnd;

  /// Resolves the directional corner to a concrete [ChatBubbleCorner] based on the text direction.
  ChatBubbleCorner resolve(TextDirection direction) {
    return switch ((this, direction)) {
      (ChatBubbleCornerDirectional.topStart, TextDirection.ltr) =>
        ChatBubbleCorner.topLeft,
      (ChatBubbleCornerDirectional.topStart, TextDirection.rtl) =>
        ChatBubbleCorner.topRight,
      (ChatBubbleCornerDirectional.topEnd, TextDirection.ltr) =>
        ChatBubbleCorner.topRight,
      (ChatBubbleCornerDirectional.topEnd, TextDirection.rtl) =>
        ChatBubbleCorner.topLeft,
      (ChatBubbleCornerDirectional.bottomStart, TextDirection.ltr) =>
        ChatBubbleCorner.bottomLeft,
      (ChatBubbleCornerDirectional.bottomStart, TextDirection.rtl) =>
        ChatBubbleCorner.bottomRight,
      (ChatBubbleCornerDirectional.bottomEnd, TextDirection.ltr) =>
        ChatBubbleCorner.bottomRight,
      (ChatBubbleCornerDirectional.bottomEnd, TextDirection.rtl) =>
        ChatBubbleCorner.bottomLeft,
    };
  }
}

/// A [ChatBubbleType] that makes one corner sharp instead of rounded.
///
/// This style modifies the border radius of one corner to create a pointed
/// corner effect, similar to a speech bubble tail.
class SharpCornerChatBubbleType extends ChatBubbleType {
  /// The corner where the tail should be applied.
  final ChatBubbleCornerDirectional? corner;

  /// The border radius of the bubble.
  final BorderRadiusGeometry? borderRadius;

  /// The padding inside the bubble.
  final EdgeInsetsGeometry? padding;

  /// The behavior determining when to show the tail.
  final TailBehavior? tailBehavior;

  /// Creates a [SharpCornerChatBubbleType].
  ///
  /// Parameters:
  /// - [corner] (`ChatBubbleCornerDirectional?`, optional): The corner that should be sharp.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the bubble.
  /// - [tailBehavior] (`TailBehavior?`, optional): The behavior determining when to show the sharp corner.
  const SharpCornerChatBubbleType({
    this.corner,
    this.borderRadius,
    this.padding,
    this.tailBehavior,
  });

  /// Creates a copy of this bubble type with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [corner] (`ValueGetter<ChatBubbleCornerDirectional?>?`, optional): New corner value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): New border radius value.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding value.
  /// - [tailBehavior] (`ValueGetter<TailBehavior?>?`, optional): New tail behavior value.
  ///
  /// Returns:
  /// A new [SharpCornerChatBubbleType] with the specified values updated.
  SharpCornerChatBubbleType copyWith({
    ValueGetter<ChatBubbleCornerDirectional?>? corner,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<TailBehavior?>? tailBehavior,
  }) {
    return SharpCornerChatBubbleType(
      corner: corner == null ? this.corner : corner(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      tailBehavior: tailBehavior == null ? this.tailBehavior : tailBehavior(),
    );
  }

  @override
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data,
      ChatBubble chat) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChatTheme>(context);
    final compTailTheme = ComponentTheme.maybeOf<ChatTailTheme>(context);
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final padding = styleValue(
      widgetValue: this.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(
        horizontal: 12 * theme.scaling,
        vertical: 8 * theme.scaling,
      ),
    );
    final color = styleValue(
        widgetValue: chat.color,
        themeValue: compTheme?.color,
        defaultValue: theme.colorScheme.primary);
    var radius = styleValue(
      widgetValue: borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: theme.borderRadiusLg,
    ).resolve(textDirection);
    final tailBehavior = styleValue(
        widgetValue: this.tailBehavior,
        themeValue: compTailTheme?.tailBehavior,
        defaultValue: TailBehavior.last);
    if (tailBehavior.wrapWithTail(data)) {
      ChatBubbleCorner? corner = this.corner?.resolve(textDirection);
      if (corner == null) {
        // guess corner based on alignment
        final alignment = styleValue(
          widgetValue: chat.alignment,
          themeValue: compTheme?.alignment,
          defaultValue: AxisAlignmentDirectional.end,
        ).resolve(textDirection);
        if (alignment.value > 0) {
          corner = ChatBubbleCorner.bottomRight;
        } else {
          corner = ChatBubbleCorner.bottomLeft;
        }
      }
      switch (corner) {
        case ChatBubbleCorner.topLeft:
          radius = radius.copyWith(topLeft: Radius.zero);
          break;
        case ChatBubbleCorner.topRight:
          radius = radius.copyWith(topRight: Radius.zero);
          break;
        case ChatBubbleCorner.bottomLeft:
          radius = radius.copyWith(bottomLeft: Radius.zero);
          break;
        case ChatBubbleCorner.bottomRight:
          radius = radius.copyWith(bottomRight: Radius.zero);
          break;
      }
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: color,
      ),
      padding: padding,
      child: child,
    );
  }
}

/// A simple [ChatBubbleType] with no tail.
class PlainChatBubbleType extends ChatBubbleType {
  /// The border radius of the bubble.
  final BorderRadiusGeometry? borderRadius;

  /// The border of the bubble.
  final BorderSide? border;

  /// The padding inside the bubble.
  final EdgeInsetsGeometry? padding;

  /// Creates a [PlainChatBubbleType].
  ///
  /// Parameters:
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble.
  /// - [border] (`BorderSide?`, optional): The border of the bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the bubble.
  const PlainChatBubbleType({
    this.borderRadius,
    this.border,
    this.padding,
  });
  @override
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data,
      ChatBubble chat) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChatTheme>(context);
    final border = styleValue(
      widgetValue: this.border,
      themeValue: compTheme?.border,
      defaultValue: null,
    );
    final padding = styleValue(
      widgetValue: this.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(
        horizontal: 12 * theme.scaling,
        vertical: 8 * theme.scaling,
      ),
    );
    final color = styleValue(
        widgetValue: chat.color,
        themeValue: compTheme?.color,
        defaultValue: theme.colorScheme.primary);
    return Container(
      decoration: BoxDecoration(
        borderRadius: styleValue(
          widgetValue: borderRadius,
          themeValue: compTheme?.borderRadius,
          defaultValue: theme.borderRadiusLg,
        ),
        border: border == null
            ? null
            : Border.all(
                color: border.color,
                width: border.width,
                strokeAlign: border.strokeAlign,
                style: border.style),
        color: color,
      ),
      padding: padding,
      child: child,
    );
  }
}

/// Defines when a tail should be shown on a [ChatBubble].
abstract class TailBehavior {
  /// Shows a tail on the first bubble in a group.
  static const first = _ChatTailBehavior(_first);

  /// Shows a tail on the middle bubble in a group.
  static const middle = _ChatTailBehavior(_middle);

  /// Shows a tail on the last bubble in a group.
  static const last = _ChatTailBehavior(_last);
  static bool _first(ChatBubbleData data) => data.index == 0;
  static bool _middle(ChatBubbleData data) =>
      data.index == (data.length - 1) ~/ 2;
  static bool _last(ChatBubbleData data) => data.index == data.length - 1;

  /// Determines whether the bubble at the given index should have a tail.
  bool wrapWithTail(ChatBubbleData data);
}

class _ChatTailBehavior implements TailBehavior {
  final bool Function(ChatBubbleData data) shouldHaveTail;
  const _ChatTailBehavior(this.shouldHaveTail);
  @override
  bool wrapWithTail(ChatBubbleData data) {
    return shouldHaveTail(data);
  }
}

/// Defines the theme for the tail of a [ChatBubble].
class ChatTailTheme extends ComponentThemeData {
  /// The position of the tail relative to the bubble.
  final AxisDirectional? position;

  /// The size of the tail.
  final Size? size;

  /// The border radius of the bubble when a tail is present.
  final BorderRadiusGeometry? borderRadius;

  /// The radius of the tail's curve.
  final double? tailRadius;

  /// The behavior determining when to show the tail.
  final TailBehavior? tailBehavior;

  /// Creates a [ChatTailTheme].
  ///
  /// Parameters:
  /// - [position] (`AxisDirectional?`, optional): The position of the tail relative to the bubble.
  /// - [size] (`Size?`, optional): The size of the tail.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble when a tail is present.
  /// - [tailRadius] (`double?`, optional): The radius of the tail's curve.
  /// - [tailBehavior] (`TailBehavior?`, optional): The behavior determining when to show the tail.
  const ChatTailTheme({
    this.position,
    this.size,
    this.borderRadius,
    this.tailRadius,
    this.tailBehavior,
  });
  @override
  String toString() {
    return 'ChatTailTheme(position: $position, size: $size, borderRadius: $borderRadius, tailRadius: $tailRadius, tailBehavior: $tailBehavior)';
  }

  /// Creates a copy of this theme with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [position] (`ValueGetter<AxisDirectional>?`, optional): New position value.
  /// - [size] (`ValueGetter<Size>?`, optional): New size value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry>?`, optional): New border radius value.
  /// - [tailRadius] (`ValueGetter<double>?`, optional): New tail radius value.
  /// - [tailBehavior] (`ValueGetter<TailBehavior>?`, optional): New tail behavior value.
  ///
  /// Returns:
  /// A new [ChatTailTheme] with the specified values updated.
  ChatTailTheme copyWith({
    ValueGetter<AxisDirectional>? position,
    ValueGetter<Size>? size,
    ValueGetter<BorderRadiusGeometry>? borderRadius,
    ValueGetter<double>? tailRadius,
    ValueGetter<TailBehavior>? tailBehavior,
  }) {
    return ChatTailTheme(
      position: position?.call() ?? this.position,
      size: size?.call() ?? this.size,
      borderRadius: borderRadius?.call() ?? this.borderRadius,
      tailRadius: tailRadius?.call() ?? this.tailRadius,
      tailBehavior: tailBehavior?.call() ?? this.tailBehavior,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatTailTheme &&
        other.position == position &&
        other.size == size &&
        other.borderRadius == borderRadius &&
        other.tailRadius == tailRadius &&
        other.tailBehavior == tailBehavior;
  }

  @override
  int get hashCode {
    return Object.hash(
      position,
      size,
      borderRadius,
      tailRadius,
      tailBehavior,
    );
  }
}

/// A [ChatBubbleType] that draws an external triangular tail.
class TailChatBubbleType extends ChatBubbleType {
  /// The alignment of the tail along the bubble's edge.
  final AxisAlignmentGeometry? tailAlignment;

  /// The position of the tail relative to the bubble.
  final AxisDirectional? position;

  /// The size of the tail.
  final Size? size;

  /// The border radius of the bubble.
  final BorderRadiusGeometry? borderRadius;

  /// The radius of the tail's curve.
  final double? tailRadius;

  /// The behavior determining when to show the tail.
  final TailBehavior? tailBehavior;

  /// The padding inside the bubble.
  final EdgeInsetsGeometry? padding;

  /// Creates a [TailChatBubbleType].
  ///
  /// Parameters:
  /// - [tailAlignment] (`AxisAlignmentGeometry?`, optional): The alignment of the tail along the bubble's edge.
  /// - [position] (`AxisDirectional?`, optional): The position of the tail relative to the bubble.
  /// - [size] (`Size?`, optional): The size of the tail.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the bubble.
  /// - [tailRadius] (`double?`, optional): The radius of the tail's curve.
  /// - [tailBehavior] (`TailBehavior?`, optional): The behavior determining when to show the tail.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the bubble.
  const TailChatBubbleType({
    this.tailAlignment,
    this.position,
    this.size,
    this.borderRadius,
    this.tailRadius,
    this.tailBehavior,
    this.padding,
  });

  /// Creates a copy of this bubble type with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [tailAlignment] (`ValueGetter<AxisAlignmentGeometry>?`, optional): New tail alignment value.
  /// - [position] (`ValueGetter<AxisDirectional>?`, optional): New position value.
  /// - [size] (`ValueGetter<Size>?`, optional): New size value.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry>?`, optional): New border radius value.
  /// - [tailRadius] (`ValueGetter<double>?`, optional): New tail radius value.
  /// - [tailBehavior] (`ValueGetter<TailBehavior>?`, optional): New tail behavior value.
  ///
  /// Returns:
  /// A new [TailChatBubbleType] with the specified values updated.
  TailChatBubbleType copyWith({
    ValueGetter<AxisAlignmentGeometry>? tailAlignment,
    ValueGetter<AxisDirectional>? position,
    ValueGetter<Size>? size,
    ValueGetter<BorderRadiusGeometry>? borderRadius,
    ValueGetter<double>? tailRadius,
    ValueGetter<TailBehavior>? tailBehavior,
  }) {
    return TailChatBubbleType(
      tailAlignment: tailAlignment?.call() ?? this.tailAlignment,
      position: position?.call() ?? this.position,
      size: size?.call() ?? this.size,
      borderRadius: borderRadius?.call() ?? this.borderRadius,
      tailRadius: tailRadius?.call() ?? this.tailRadius,
      tailBehavior: tailBehavior?.call() ?? this.tailBehavior,
    );
  }

  @override
  Widget wrap(BuildContext context, Widget child, ChatBubbleData data,
      ChatBubble chat) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChatTailTheme>(context);
    final chatTheme = ComponentTheme.maybeOf<ChatTheme>(context);
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final tailBehavior = styleValue(
        widgetValue: this.tailBehavior,
        themeValue: compTheme?.tailBehavior,
        defaultValue: TailBehavior.last);
    final color = styleValue(
        widgetValue: chat.color,
        themeValue: chatTheme?.color,
        defaultValue: theme.colorScheme.primary);
    final radius = styleValue(
            widgetValue: borderRadius,
            themeValue: chatTheme?.borderRadius,
            defaultValue: theme.borderRadiusLg)
        .resolve(textDirection);
    child = Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: color,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12 * theme.scaling,
        vertical: 8 * theme.scaling,
      ),
      child: child,
    );

    double leftPadding;
    double rightPadding;
    double topPadding;
    double bottomPadding;
    final size = styleValue(
        widgetValue: this.size,
        themeValue: compTheme?.size,
        defaultValue: const Size(8, 8));
    final position = styleValue(
            widgetValue: this.position,
            themeValue: compTheme?.position,
            defaultValue: AxisDirectional.end)
        .resolve(textDirection);
    bool wrapWithTail = tailBehavior.wrapWithTail(data);
    switch ((position, wrapWithTail)) {
      case (AxisDirection.left, _):
        topPadding = 0;
        leftPadding = size.width;
        rightPadding = 0;
        bottomPadding = 0;
        break;
      case (AxisDirection.right, _):
        topPadding = 0;
        leftPadding = 0;
        rightPadding = size.width;
        bottomPadding = 0;
        break;
      case (AxisDirection.up, true):
        topPadding = size.height;
        leftPadding = 0;
        rightPadding = 0;
        bottomPadding = 0;
        break;
      case (AxisDirection.down, true):
        topPadding = 0;
        leftPadding = 0;
        rightPadding = 0;
        bottomPadding = size.height;
        break;
      case (_, _):
        topPadding = 0;
        leftPadding = 0;
        rightPadding = 0;
        bottomPadding = 0;
        break;
    }

    if (tailBehavior.wrapWithTail(data)) {
      final color = styleValue(
          widgetValue: chat.color,
          themeValue: chatTheme?.color,
          defaultValue: theme.colorScheme.primary);

      final tailSize = styleValue(
          widgetValue: size,
          themeValue: compTheme?.size,
          defaultValue: const Size(8, 8));
      final tailRadius = styleValue(
          widgetValue: this.tailRadius,
          themeValue: compTheme?.tailRadius,
          defaultValue: theme.radiusSm);
      final tailAlignment = styleValue(
              widgetValue: this.tailAlignment,
              themeValue: chatTheme?.alignment,
              defaultValue: AxisAlignmentDirectional.end)
          .resolve(textDirection);
      final position = styleValue(
              widgetValue: this.position,
              themeValue: compTheme?.position,
              defaultValue: AxisDirectional.down)
          .resolve(textDirection);
      child = CustomPaint(
        painter: _TailPainter(
          color: color,
          radius: radius,
          tailSize: tailSize,
          position: position,
          tailAlignment: tailAlignment,
          tailRadius: tailRadius,
        ),
        child: child,
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        left: leftPadding,
        right: rightPadding,
        bottom: bottomPadding,
      ),
      child: child,
    );
  }
}

class _TailPainter extends CustomPainter {
  final Color color;
  final BorderRadius radius;
  final Size tailSize;
  final AxisDirection position;
  final AxisAlignment tailAlignment;
  final double tailRadius;
  const _TailPainter({
    required this.color,
    required this.radius,
    required this.tailSize,
    required this.position,
    required this.tailAlignment,
    required this.tailRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    // create tail shape
    Axis axis = switch (position) {
      AxisDirection.up => Axis.vertical,
      AxisDirection.down => Axis.vertical,
      AxisDirection.left => Axis.horizontal,
      AxisDirection.right => Axis.horizontal,
    };

    double horizontalOffset = tailAlignment.alongValue(axis, size.width) -
        tailAlignment.alongValue(axis, tailSize.width);
    double verticalOffset = tailAlignment.alongValue(axis, size.height) -
        tailAlignment.alongValue(axis, tailSize.height);
    double alignVal = tailAlignment.resolveValue(axis);
    double t = (alignVal + 1) / 2;

    Offset base1, base2, tip;

    // Get corner radius - the bubble extends beyond the painter bounds
    double cornerRadius = switch (position) {
      AxisDirection.up => max(radius.topLeft.y, radius.topRight.y),
      AxisDirection.down => max(radius.bottomLeft.y, radius.bottomRight.y),
      AxisDirection.left => max(radius.topLeft.x, radius.bottomLeft.x),
      AxisDirection.right => max(radius.topRight.x, radius.bottomRight.x),
    };

    // Calculate initial base positions at the edge
    Offset initialBase1, initialBase2;
    switch (position) {
      case AxisDirection.up:
        initialBase1 = Offset(horizontalOffset, 0);
        initialBase2 = Offset(horizontalOffset + tailSize.width, 0);
        tip = Offset(horizontalOffset + t * tailSize.width, -tailSize.height);
        break;
      case AxisDirection.down:
        initialBase1 = Offset(horizontalOffset, size.height);
        initialBase2 = Offset(horizontalOffset + tailSize.width, size.height);
        tip = Offset(horizontalOffset + t * tailSize.width,
            size.height + tailSize.height);
        break;
      case AxisDirection.left:
        initialBase1 = Offset(0, verticalOffset);
        initialBase2 = Offset(0, verticalOffset + tailSize.height);
        tip = Offset(-tailSize.width, verticalOffset + t * tailSize.height);
        break;
      case AxisDirection.right:
        initialBase1 = Offset(size.width, verticalOffset);
        initialBase2 = Offset(size.width, verticalOffset + tailSize.height);
        tip = Offset(
            size.width + tailSize.width, verticalOffset + t * tailSize.height);
        break;
    }

    // Extend base points along the tail-to-base vectors by cornerRadius
    Offset v1 = initialBase1 - tip;
    Offset v2 = initialBase2 - tip;
    double d1 = v1.distance;
    double d2 = v2.distance;

    // Move base1 and base2 outward along their respective vectors
    base1 = d1 == 0 ? initialBase1 : tip + v1 * ((d1 + cornerRadius) / d1);
    base2 = d2 == 0 ? initialBase2 : tip + v2 * ((d2 + cornerRadius) / d2);

    // Recalculate vectors for the rounded tip
    v1 = base1 - tip;
    v2 = base2 - tip;
    d1 = v1.distance;
    d2 = v2.distance;

    Offset pathBeforeTail =
        d1 == 0 ? tip : tip + v1 * (min(d1, tailRadius) / d1);
    Offset pathAfterTail =
        d2 == 0 ? tip : tip + v2 * (min(d2, tailRadius) / d2);

    path.moveTo(base1.dx, base1.dy);
    path.lineTo(pathBeforeTail.dx, pathBeforeTail.dy);
    path.quadraticBezierTo(tip.dx, tip.dy, pathAfterTail.dx, pathAfterTail.dy);
    path.lineTo(base2.dx, base2.dy);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _TailPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.tailSize != tailSize ||
        oldDelegate.position != position ||
        oldDelegate.tailAlignment != tailAlignment;
  }
}

/// Data associated with a [ChatBubble] within a [ChatGroup].
class ChatBubbleData {
  /// The index of the bubble in the group.
  final int index;

  /// The total number of bubbles in the group.
  final int length;

  /// Creates a [ChatBubbleData].
  ///
  /// Parameters:
  /// - [index] (`int`, required): The index of the bubble in the group.
  /// - [length] (`int`, required): The total number of bubbles in the group.
  const ChatBubbleData({
    required this.index,
    required this.length,
  });

  /// Creates a copy of this data with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [index] (`int?`, optional): New index value.
  /// - [length] (`int?`, optional): New length value.
  ///
  /// Returns:
  /// A new [ChatBubbleData] with the specified values updated.
  ChatBubbleData copyWith({
    int? index,
    int? length,
  }) {
    return ChatBubbleData(
      index: index ?? this.index,
      length: length ?? this.length,
    );
  }

  @override
  String toString() {
    return 'ChatBubbleData(index: $index, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatBubbleData &&
        other.index == index &&
        other.length == length;
  }

  @override
  int get hashCode {
    return Object.hash(index, length);
  }
}

/// A widget that displays a single chat message or content.
///
/// This widget renders a chat bubble with customizable styling, including
/// background color, alignment, and tail behavior.
///
/// Example:
/// ```dart
/// ChatBubble(
///   child: Text('Hello World'),
///   alignment: AxisAlignment.right,
///   color: Colors.blue,
/// )
/// ```
class ChatBubble extends StatelessWidget {
  /// The content of the chat bubble.
  final Widget child;

  /// The type of the chat bubble.
  final ChatBubbleType? type;

  /// The background color of the chat bubble.
  final Color? color;

  /// The alignment of the chat bubble.
  final AxisAlignmentGeometry? alignment;

  /// The border of the chat bubble.
  final BorderSide? border;

  /// The padding inside the chat bubble.
  final EdgeInsetsGeometry? padding;

  /// The border radius of the chat bubble.
  final BorderRadiusGeometry? borderRadius;

  /// The width factor of the chat bubble.
  final double? widthFactor;

  /// Creates a [ChatBubble].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): The content of the chat bubble.
  /// - [type] (`ChatBubbleType?`, optional): The type of the chat bubble.
  /// - [color] (`Color?`, optional): The background color of the chat bubble.
  /// - [alignment] (`AxisAlignmentGeometry?`, optional): The alignment of the chat bubble.
  /// - [border] (`BorderSide?`, optional): The border of the chat bubble.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): The padding inside the chat bubble.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): The border radius of the chat bubble.
  /// - [widthFactor] (`double?`, optional): The width factor of the chat bubble.
  const ChatBubble({
    super.key,
    required this.child,
    this.type,
    this.color,
    this.alignment,
    this.border,
    this.padding,
    this.borderRadius,
    this.widthFactor,
  });

  @override
  Widget build(BuildContext context) {
    final chatTheme = ComponentTheme.maybeOf<ChatTheme>(context);
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    final alignment = styleValue(
      widgetValue: this.alignment,
      themeValue: chatTheme?.alignment,
      defaultValue: AxisAlignmentDirectional.end,
    ).resolve(textDirection);
    final type = styleValue(
      widgetValue: this.type,
      themeValue: chatTheme?.type,
      defaultValue: ChatBubbleType.tail,
    );
    final effectiveData = (Data.maybeOf<ChatBubbleData>(context) ??
        ChatBubbleData(
          index: 0,
          length: 1,
        ));
    final widthFactor = styleValue(
      widgetValue: this.widthFactor,
      themeValue: chatTheme?.widthFactor,
      defaultValue: 0.5,
    );
    return ChatConstrainedBox(
      widthFactor: widthFactor,
      alignment: alignment,
      child: ComponentTheme(
        data: chatTheme?.copyWith(
              color: color == null ? null : () => color,
              type: () => type,
              alignment: () => alignment,
              border: border == null ? null : () => border,
              padding: padding == null ? null : () => padding,
              borderRadius: borderRadius == null ? null : () => borderRadius,
              widthFactor: widthFactor == 0.5 ? null : () => widthFactor,
            ) ??
            ChatTheme(
              color: color,
              type: type,
              alignment: alignment,
              border: border,
              padding: padding,
              borderRadius: borderRadius,
              widthFactor: widthFactor,
            ),
        child: Builder(builder: (context) {
          return type.wrap(context, child, effectiveData, this);
        }),
      ),
    );
  }
}
