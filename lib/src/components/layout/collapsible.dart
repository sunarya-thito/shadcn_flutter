import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [Collapsible], [CollapsibleTrigger], and [CollapsibleContent] widgets.
///
/// [CollapsibleTheme] provides styling options for collapsible components including
/// padding, iconography, and layout alignment. It enables consistent collapsible
/// styling across an application while allowing per-instance customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<CollapsibleTheme>(
///   data: CollapsibleTheme(
///     padding: 12.0,
///     iconExpanded: Icons.keyboard_arrow_up,
///     iconCollapsed: Icons.keyboard_arrow_down,
///     iconGap: 8.0,
///     crossAxisAlignment: CrossAxisAlignment.start,
///   ),
///   child: MyCollapsibleWidget(),
/// );
/// ```
class CollapsibleTheme {
  /// Horizontal padding applied around [CollapsibleTrigger] content.
  ///
  /// Controls the internal spacing within the trigger area. If null,
  /// defaults to 16 logical pixels scaled by theme.
  final double? padding;

  /// Icon displayed in the trigger when the collapsible is expanded.
  ///
  /// If null, defaults to [Icons.unfold_less].
  final IconData? iconExpanded;

  /// Icon displayed in the trigger when the collapsible is collapsed.
  ///
  /// If null, defaults to [Icons.unfold_more].
  final IconData? iconCollapsed;

  /// Cross-axis alignment for children in the [Collapsible] column.
  ///
  /// Controls how children are aligned perpendicular to the main axis.
  /// If null, defaults to [CrossAxisAlignment.stretch].
  final CrossAxisAlignment? crossAxisAlignment;

  /// Main-axis alignment for children in the [Collapsible] column.
  ///
  /// Controls how children are aligned along the main axis.
  /// If null, defaults to [MainAxisAlignment.start].
  final MainAxisAlignment? mainAxisAlignment;

  /// Horizontal spacing between trigger content and expand/collapse icon.
  ///
  /// Controls the gap between the trigger child and the action button.
  /// If null, defaults to 16 logical pixels scaled by theme.
  final double? iconGap;

  /// Creates a [CollapsibleTheme] with the specified styling options.
  ///
  /// All parameters are optional and will fall back to component defaults
  /// when not specified.
  ///
  /// Parameters:
  /// - [padding] (double?, optional): Horizontal padding for trigger content.
  /// - [iconExpanded] (IconData?, optional): Icon shown when expanded.
  /// - [iconCollapsed] (IconData?, optional): Icon shown when collapsed.
  /// - [crossAxisAlignment] (CrossAxisAlignment?, optional): Cross-axis alignment of children.
  /// - [mainAxisAlignment] (MainAxisAlignment?, optional): Main-axis alignment of children.
  /// - [iconGap] (double?, optional): Space between trigger content and icon.
  const CollapsibleTheme({
    this.padding,
    this.iconExpanded,
    this.iconCollapsed,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.iconGap,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   padding: () => 20.0,
  ///   iconGap: () => 12.0,
  /// );
  /// ```
  CollapsibleTheme copyWith({
    ValueGetter<double?>? padding,
    ValueGetter<IconData?>? iconExpanded,
    ValueGetter<IconData?>? iconCollapsed,
    ValueGetter<CrossAxisAlignment?>? crossAxisAlignment,
    ValueGetter<MainAxisAlignment?>? mainAxisAlignment,
    ValueGetter<double?>? iconGap,
  }) {
    return CollapsibleTheme(
      padding: padding == null ? this.padding : padding(),
      iconExpanded: iconExpanded == null ? this.iconExpanded : iconExpanded(),
      iconCollapsed:
          iconCollapsed == null ? this.iconCollapsed : iconCollapsed(),
      crossAxisAlignment: crossAxisAlignment == null
          ? this.crossAxisAlignment
          : crossAxisAlignment(),
      mainAxisAlignment: mainAxisAlignment == null
          ? this.mainAxisAlignment
          : mainAxisAlignment(),
      iconGap: iconGap == null ? this.iconGap : iconGap(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollapsibleTheme &&
        other.padding == padding &&
        other.iconExpanded == iconExpanded &&
        other.iconCollapsed == iconCollapsed &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.iconGap == iconGap;
  }

  @override
  int get hashCode =>
      padding.hashCode ^
      iconExpanded.hashCode ^
      iconCollapsed.hashCode ^
      crossAxisAlignment.hashCode ^
      mainAxisAlignment.hashCode ^
      iconGap.hashCode;
}

/// A container widget that can show or hide its content with a collapsible interface.
///
/// [Collapsible] provides a simple expand/collapse pattern where content can be
/// toggled between visible and hidden states. Unlike [Accordion], multiple
/// collapsible widgets can be expanded simultaneously, making them ideal for
/// independent sections that users might want to view concurrently.
///
/// ## Key Features
/// - **Independent State**: Each collapsible manages its own expansion state
/// - **Flexible Control**: Can be controlled or uncontrolled
/// - **Custom Layout**: Configurable alignment for trigger and content
/// - **Instant Toggle**: Uses visibility toggling rather than animated transitions
/// - **Composable**: Works with [CollapsibleTrigger] and [CollapsibleContent]
///
/// ## Usage Patterns
/// The collapsible can operate in two modes:
/// - **Uncontrolled**: Manages its own state internally
/// - **Controlled**: State managed externally via [onExpansionChanged]
///
/// Example:
/// ```dart
/// Collapsible(
///   isExpanded: false,
///   children: [
///     CollapsibleTrigger(
///       child: Row(
///         children: [
///           Icon(Icons.settings),
///           SizedBox(width: 8),
///           Text('Advanced Settings'),
///         ],
///       ),
///     ),
///     CollapsibleContent(
///       child: Padding(
///         padding: EdgeInsets.all(16),
///         child: Column(
///           children: [
///             CheckboxListTile(title: Text('Option 1'), value: false, onChanged: null),
///             CheckboxListTile(title: Text('Option 2'), value: true, onChanged: null),
///           ],
///         ),
///       ),
///     ),
///   ],
/// );
/// ```
///
/// For more information, visit: https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible
class Collapsible extends StatefulWidget {
  /// The child widgets to display in the collapsible container.
  ///
  /// Typically includes a [CollapsibleTrigger] as the first child, followed by
  /// one or more [CollapsibleContent] widgets. The widgets are arranged in
  /// a vertical column with configurable alignment.
  final List<Widget> children;

  /// Initial expansion state when operating in uncontrolled mode.
  ///
  /// If null, defaults to false (collapsed). This value is only used when
  /// [onExpansionChanged] is null, indicating uncontrolled mode.
  final bool? isExpanded;

  /// Callback invoked when the expansion state should change.
  ///
  /// When provided, the collapsible operates in controlled mode and the parent
  /// widget is responsible for managing the expansion state. Called with the
  /// current expansion state when the user triggers a state change.
  final ValueChanged<bool>? onExpansionChanged;

  /// Creates a [Collapsible] widget with the specified children.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): Widgets to display in the collapsible container.
  /// - [isExpanded] (bool?, optional): Initial expansion state for uncontrolled mode.
  /// - [onExpansionChanged] (`ValueChanged<bool>?`, optional): Callback for controlled mode.
  ///
  /// ## Mode Selection
  /// - **Uncontrolled Mode**: When [onExpansionChanged] is null, the widget manages
  ///   its own state using [isExpanded] as the initial value.
  /// - **Controlled Mode**: When [onExpansionChanged] is provided, the parent must
  ///   manage state and update [isExpanded] accordingly.
  ///
  /// Example (Uncontrolled):
  /// ```dart
  /// Collapsible(
  ///   isExpanded: true,
  ///   children: [
  ///     CollapsibleTrigger(child: Text('Toggle Me')),
  ///     CollapsibleContent(child: Text('Hidden content')),
  ///   ],
  /// );
  /// ```
  ///
  /// Example (Controlled):
  /// ```dart
  /// bool _expanded = false;
  ///
  /// Collapsible(
  ///   isExpanded: _expanded,
  ///   onExpansionChanged: (expanded) => setState(() => _expanded = !_expanded),
  ///   children: [
  ///     CollapsibleTrigger(child: Text('Toggle Me')),
  ///     CollapsibleContent(child: Text('Hidden content')),
  ///   ],
  /// );
  /// ```
  ///
  /// For more information, visit: https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible
  const Collapsible({
    super.key,
    required this.children,
    this.isExpanded,
    this.onExpansionChanged,
  });

  @override
  State<Collapsible> createState() => CollapsibleState();
}

/// State class for [Collapsible] widget.
///
/// Manages the expansion/collapse animation state and handles transitions
/// between expanded and collapsed states.
class CollapsibleState extends State<Collapsible> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? false;
  }

  @override
  void didUpdateWidget(covariant Collapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != null) {
      _isExpanded = widget.isExpanded!;
    }
  }

  void _handleTap() {
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);

    return Data.inherit(
      data:
          CollapsibleStateData(isExpanded: _isExpanded, handleTap: _handleTap),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment:
              compTheme?.crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisAlignment:
              compTheme?.mainAxisAlignment ?? MainAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}

/// Internal data structure for sharing collapsible state between child widgets.
///
/// [CollapsibleStateData] provides a communication mechanism between the
/// [Collapsible] parent and its child widgets like [CollapsibleTrigger] and
/// [CollapsibleContent]. It exposes the current expansion state and a
/// callback for triggering state changes.
class CollapsibleStateData {
  /// Callback to trigger expansion state changes.
  ///
  /// When called, triggers the collapsible to toggle its expansion state.
  /// This function handles both controlled and uncontrolled modes appropriately.
  final VoidCallback handleTap;

  /// Current expansion state of the collapsible.
  ///
  /// True when the collapsible is expanded and content should be visible,
  /// false when collapsed and content should be hidden.
  final bool isExpanded;

  /// Creates a [CollapsibleStateData] with the specified state and callback.
  ///
  /// This constructor is used internally by [Collapsible] to share state
  /// with its child widgets.
  const CollapsibleStateData({
    required this.isExpanded,
    required this.handleTap,
  });
}

/// A trigger widget that controls the expansion state of its parent [Collapsible].
///
/// [CollapsibleTrigger] provides a consistent interface for toggling collapsible
/// content. It automatically displays the appropriate expand/collapse icon and
/// handles user interaction to trigger state changes.
///
/// ## Features
/// - **Automatic Icons**: Shows different icons for expanded/collapsed states
/// - **Integrated Button**: Uses [GhostButton] for consistent interaction styling
/// - **Responsive Layout**: Automatically sizes and spaces content and icon
/// - **Theme Integration**: Respects [CollapsibleTheme] configuration
///
/// The trigger must be used as a direct child of a [Collapsible] widget to
/// function properly, as it relies on inherited state data.
///
/// Example:
/// ```dart
/// CollapsibleTrigger(
///   child: Row(
///     children: [
///       Icon(Icons.folder),
///       SizedBox(width: 8),
///       Text('Project Files'),
///       Spacer(),
///       Badge(child: Text('12')),
///     ],
///   ),
/// );
/// ```
class CollapsibleTrigger extends StatelessWidget {
  /// The content widget to display within the trigger.
  ///
  /// Typically contains text, icons, or other UI elements that describe what
  /// will be expanded or collapsed. The child is automatically styled and
  /// positioned alongside the expand/collapse icon.
  final Widget child;

  /// Creates a [CollapsibleTrigger] with the specified child content.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The content to display in the trigger.
  ///
  /// The trigger automatically provides:
  /// - Expand/collapse icon based on current state
  /// - Click handling to toggle the parent collapsible
  /// - Proper spacing and layout with theme-aware styling
  /// - Integration with parent [Collapsible] state
  ///
  /// Example:
  /// ```dart
  /// CollapsibleTrigger(
  ///   child: Text('Click to toggle content'),
  /// );
  /// ```
  const CollapsibleTrigger({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final state = Data.of<CollapsibleStateData>(context);

    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);

    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(child: child.small().semiBold()),
      Gap(compTheme?.iconGap ?? 16 * scaling),
      GhostButton(
        onPressed: state.handleTap,
        child: Icon(
          state.isExpanded
              ? compTheme?.iconExpanded ?? Icons.unfold_less
              : compTheme?.iconCollapsed ?? Icons.unfold_more,
        ).iconXSmall(),
      ),
    ]).withPadding(horizontal: compTheme?.padding ?? 16 * scaling);
  }
}

/// A content widget that shows or hides based on the parent [Collapsible] state.
///
/// [CollapsibleContent] automatically manages its visibility based on the
/// expansion state of its parent [Collapsible]. It uses [Offstage] to
/// completely remove the content from the layout when collapsed, providing
/// efficient performance.
///
/// ## Key Features
/// - **Automatic Visibility**: Shows/hides based on parent expansion state
/// - **Layout Efficiency**: Uses [Offstage] for true layout removal when collapsed
/// - **Optional Control**: Can be configured to ignore collapsible state
/// - **Flexible Content**: Supports any widget as child content
///
/// Example:
/// ```dart
/// CollapsibleContent(
///   child: Container(
///     padding: EdgeInsets.all(16),
///     decoration: BoxDecoration(
///       border: Border.all(color: Colors.grey.shade300),
///       borderRadius: BorderRadius.circular(8),
///     ),
///     child: Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Additional Details'),
///         SizedBox(height: 8),
///         Text('This content is only visible when expanded.'),
///       ],
///     ),
///   ),
/// );
/// ```
class CollapsibleContent extends StatelessWidget {
  /// Whether this content should respond to the collapsible state.
  ///
  /// When true (default), the content shows/hides based on the parent
  /// [Collapsible] expansion state. When false, the content is always visible
  /// regardless of the collapsible state.
  final bool collapsible;

  /// The widget to show or hide based on expansion state.
  ///
  /// This can be any widget content including text, images, forms, or complex
  /// layouts. The child is completely removed from the layout when collapsed.
  final Widget child;

  /// Creates a [CollapsibleContent] with the specified child widget.
  ///
  /// Parameters:
  /// - [collapsible] (bool, default: true): Whether to respond to collapsible state.
  /// - [child] (Widget, required): The content widget to show/hide.
  ///
  /// ## Behavior
  /// - When [collapsible] is true and parent is collapsed: Content is hidden via [Offstage]
  /// - When [collapsible] is true and parent is expanded: Content is visible
  /// - When [collapsible] is false: Content is always visible regardless of parent state
  ///
  /// Example:
  /// ```dart
  /// CollapsibleContent(
  ///   collapsible: true,
  ///   child: Padding(
  ///     padding: EdgeInsets.symmetric(vertical: 16),
  ///     child: Text('This content can be collapsed'),
  ///   ),
  /// );
  /// ```
  const CollapsibleContent({
    super.key,
    this.collapsible = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final state = Data.of<CollapsibleStateData>(context);
    return Offstage(
      offstage: !state.isExpanded && collapsible,
      child: child,
    );
  }
}
