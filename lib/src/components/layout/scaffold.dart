import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing [Scaffold] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Scaffold] widgets, including background colors for different sections,
/// loading spark behavior, and keyboard avoidance settings. These properties
/// can be set at the theme level to provide consistent styling across the application.
class ScaffoldTheme {
  /// Background color of the scaffold body.
  final Color? backgroundColor;

  /// Background color of the header section.
  final Color? headerBackgroundColor;

  /// Background color of the footer section.
  final Color? footerBackgroundColor;

  /// Whether to show loading sparks by default.
  final bool? showLoadingSparks;

  /// Whether the scaffold should resize for the onscreen keyboard.
  final bool? resizeToAvoidBottomInset;

  /// Creates a [ScaffoldTheme].
  const ScaffoldTheme({
    this.backgroundColor,
    this.headerBackgroundColor,
    this.footerBackgroundColor,
    this.showLoadingSparks,
    this.resizeToAvoidBottomInset,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ScaffoldTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? headerBackgroundColor,
    ValueGetter<Color?>? footerBackgroundColor,
    ValueGetter<bool?>? showLoadingSparks,
    ValueGetter<bool?>? resizeToAvoidBottomInset,
  }) {
    return ScaffoldTheme(
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      headerBackgroundColor: headerBackgroundColor == null
          ? this.headerBackgroundColor
          : headerBackgroundColor(),
      footerBackgroundColor: footerBackgroundColor == null
          ? this.footerBackgroundColor
          : footerBackgroundColor(),
      showLoadingSparks: showLoadingSparks == null
          ? this.showLoadingSparks
          : showLoadingSparks(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset == null
          ? this.resizeToAvoidBottomInset
          : resizeToAvoidBottomInset(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ScaffoldTheme &&
      other.backgroundColor == backgroundColor &&
      other.headerBackgroundColor == headerBackgroundColor &&
      other.footerBackgroundColor == footerBackgroundColor &&
      other.showLoadingSparks == showLoadingSparks &&
      other.resizeToAvoidBottomInset == resizeToAvoidBottomInset;

  @override
  int get hashCode => Object.hash(backgroundColor, headerBackgroundColor,
      footerBackgroundColor, showLoadingSparks, resizeToAvoidBottomInset);

  @override
  String toString() =>
      'ScaffoldTheme(background: $backgroundColor, header: $headerBackgroundColor, footer: $footerBackgroundColor, showLoadingSparks: $showLoadingSparks, resizeToAvoidBottomInset: $resizeToAvoidBottomInset)';
}

/// A fundamental layout widget that provides the basic structure for screen layouts.
///
/// [Scaffold] serves as the foundation for most screen layouts in the shadcn_flutter
/// design system. It provides a structured approach to organizing content with
/// dedicated areas for headers, main content, and footers. The scaffold manages
/// layout responsibilities, loading states, and provides a consistent framework
/// for building complex interfaces.
///
/// Key features:
/// - Flexible header and footer management with multiple widget support
/// - Main content area with automatic layout management
/// - Loading progress indication with optional sparks animation
/// - Floating header/footer modes for overlay positioning
/// - Independent background color control for each section
/// - Keyboard avoidance behavior for input accessibility
/// - Responsive layout adjustments
/// - Integration with the shadcn_flutter theme system
///
/// Layout structure:
/// - Headers: Optional top section for navigation, titles, toolbars
/// - Main content: Central area containing the primary interface
/// - Footers: Optional bottom section for actions, navigation, status
///
/// The scaffold supports both fixed and floating positioning modes:
/// - Fixed mode: Headers/footers take layout space and push content
/// - Floating mode: Headers/footers overlay content without affecting layout
///
/// Loading states are elegantly handled with:
/// - Progress indication through [loadingProgress]
/// - Optional animated sparks for enhanced visual feedback
/// - Indeterminate loading support for unknown duration tasks
///
/// Example:
/// ```dart
/// Scaffold(
///   headers: [
///     AppBar(title: Text('My App')),
///   ],
///   child: Center(
///     child: Text('Main content area'),
///   ),
///   footers: [
///     BottomNavigationBar(
///       items: [
///         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///         BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
///       ],
///     ),
///   ],
///   loadingProgress: isLoading ? null : 0.0, // null for indeterminate
///   showLoadingSparks: true,
/// );
/// ```
class Scaffold extends StatefulWidget {
  /// Header widgets displayed at the top of the scaffold.
  final List<Widget> headers;

  /// Footer widgets displayed at the bottom of the scaffold.
  final List<Widget> footers;

  /// Main content widget.
  final Widget child;

  /// Loading progress value (0.0 to 1.0).
  final double? loadingProgress;

  /// Whether loading indicator shows indeterminate progress.
  final bool loadingProgressIndeterminate;

  /// Whether header floats above content (takes no layout space).
  final bool floatingHeader;

  /// Whether footer floats above content (takes no layout space).
  final bool floatingFooter;

  /// Background color for header section.
  final Color? headerBackgroundColor;

  /// Background color for footer section.
  final Color? footerBackgroundColor;

  /// Background color for the scaffold.
  final Color? backgroundColor;

  /// Whether to show loading sparks effect.
  final bool? showLoadingSparks;

  /// Whether to resize when keyboard appears.
  final bool? resizeToAvoidBottomInset;

  /// Creates a [Scaffold].
  const Scaffold({
    super.key,
    required this.child,
    this.headers = const [],
    this.footers = const [],
    this.loadingProgress,
    this.loadingProgressIndeterminate = false,
    this.floatingHeader = false,
    this.floatingFooter = false,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.footerBackgroundColor,
    this.showLoadingSparks,
    this.resizeToAvoidBottomInset,
  });

  @override
  State<Scaffold> createState() => ScaffoldState();
}

/// Data class for identifying scaffold bar (header/footer) positioning.
///
/// Provides context about a bar's position within the scaffold layout,
/// including whether it's a header or footer and its index among siblings.
class ScaffoldBarData {
  /// Whether this bar is in the header section (vs footer).
  final bool isHeader;

  /// Zero-based index of this child bar.
  final int childIndex;

  /// Total number of children in this section.
  final int childrenCount;

  /// Creates [ScaffoldBarData].
  const ScaffoldBarData({
    this.isHeader = true,
    required this.childIndex,
    required this.childrenCount,
  });
}

/// State class for [Scaffold] widget.
///
/// Manages the scaffold's layout state and provides methods for building
/// header, footer, and body sections with proper theming and constraints.
class ScaffoldState extends State<Scaffold> {
  /// Builds the header section of the scaffold.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  ///
  /// Returns: Widget tree for the header.
  Widget buildHeader(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<ScaffoldTheme>(context);
    return RepaintBoundary(
      child: Container(
        color: widget.headerBackgroundColor ?? compTheme?.headerBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              verticalDirection: VerticalDirection.up,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.loadingProgress != null ||
                    widget.loadingProgressIndeterminate)
                  SizedBox(
                    // to make it float
                    height: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                            value: widget.loadingProgressIndeterminate
                                ? null
                                : widget.loadingProgress,
                            showSparks: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < widget.headers.length; i++)
                        Data.inherit(
                          data: ScaffoldBarData(
                            childIndex: i,
                            childrenCount: widget.headers.length,
                          ),
                          child: widget.headers[i],
                        ),
                    ]),
              ],
            ),
            if (widget.loadingProgress != null &&
                (widget.showLoadingSparks ??
                    compTheme?.showLoadingSparks ??
                    false))
              SizedBox(
                // to make it float
                height: 0,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.passthrough,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        value: widget.loadingProgressIndeterminate
                            ? null
                            : widget.loadingProgress,
                        showSparks: true,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the footer section of the scaffold.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  /// - [viewInsets] (`EdgeInsets`, required): View insets (e.g., keyboard).
  ///
  /// Returns: Widget tree for the footer.
  Widget buildFooter(BuildContext context, EdgeInsets viewInsets) {
    final compTheme = ComponentTheme.maybeOf<ScaffoldTheme>(context);
    return Offstage(
      offstage: viewInsets.bottom > 0,
      child: RepaintBoundary(
        child: Container(
          color:
              widget.footerBackgroundColor ?? compTheme?.footerBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < widget.footers.length; i++)
                Data.inherit(
                  data: ScaffoldBarData(
                    isHeader: false,
                    childIndex: i,
                    childrenCount: widget.footers.length,
                  ),
                  child: widget.footers[i],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ScaffoldTheme>(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    return DrawerOverlay(
      child: Container(
        color: widget.backgroundColor ??
            compTheme?.backgroundColor ??
            theme.colorScheme.background,
        child: _ScaffoldFlex(
          floatingHeader: widget.floatingHeader,
          floatingFooter: widget.floatingFooter,
          children: [
            buildHeader(context),
            LayoutBuilder(builder: (context, constraints) {
              Widget child = (widget.resizeToAvoidBottomInset ??
                      compTheme?.resizeToAvoidBottomInset ??
                      true)
                  ? Container(
                      padding: EdgeInsets.only(
                        bottom: viewInsets.bottom,
                      ),
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          viewInsets: viewInsets.copyWith(
                            bottom: 0,
                          ),
                        ),
                        child: ToastLayer(child: widget.child),
                      ),
                    )
                  : ToastLayer(child: widget.child);
              if (constraints is ScaffoldBoxConstraints &&
                  (widget.floatingHeader || widget.floatingFooter)) {
                final currentMediaQuery = MediaQuery.of(context);
                EdgeInsets padding = currentMediaQuery.padding;
                if (widget.floatingHeader) {
                  padding += EdgeInsets.only(top: constraints.headerHeight);
                }
                if (widget.floatingFooter) {
                  padding += EdgeInsets.only(bottom: constraints.footerHeight);
                }
                child = MediaQuery(
                  data: currentMediaQuery.copyWith(
                    padding: padding,
                  ),
                  child: RepaintBoundary(
                    child: child,
                  ),
                );
              }
              return child;
            }),
            buildFooter(context, viewInsets),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: _buildContent,
        ),
      ],
    );
  }
}

/// Storage for scaffold padding values.
///
/// Holds padding values for all four sides of the scaffold content area.
class ScaffoldPaddingStorage {
  /// Top padding value.
  double top;

  /// Left padding value.
  double left;

  /// Right padding value.
  double right;

  /// Bottom padding value.
  double bottom;

  /// Creates a [ScaffoldPaddingStorage].
  ///
  /// Parameters:
  /// - [top] (`double`, required): Top padding.
  /// - [left] (`double`, required): Left padding.
  /// - [right] (`double`, required): Right padding.
  /// - [bottom] (`double`, required): Bottom padding.
  ScaffoldPaddingStorage({
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
  });
}

/// Box constraints with additional header and footer height information.
///
/// Extends [BoxConstraints] to include scaffold-specific layout measurements.
class ScaffoldBoxConstraints extends BoxConstraints {
  /// Height of the header section.
  final double headerHeight;

  /// Height of the footer section.
  final double footerHeight;

  /// Creates [ScaffoldBoxConstraints].
  ///
  /// Parameters:
  /// - [headerHeight] (`double`, required): Header height.
  /// - [footerHeight] (`double`, required): Footer height.
  /// - Additional [BoxConstraints] parameters.
  const ScaffoldBoxConstraints({
    required this.headerHeight,
    required this.footerHeight,
    super.minWidth,
    super.maxWidth,
    super.minHeight,
    super.maxHeight,
  });

  /// Creates [ScaffoldBoxConstraints] from existing [BoxConstraints].
  ///
  /// Parameters:
  /// - [constraints] (`BoxConstraints`, required): Base constraints.
  /// - [headerHeight] (`double`, required): Header height.
  /// - [footerHeight] (`double`, required): Footer height.
  ///
  /// Returns: New [ScaffoldBoxConstraints] with scaffold-specific data.
  factory ScaffoldBoxConstraints.fromBoxConstraints({
    required BoxConstraints constraints,
    required double headerHeight,
    required double footerHeight,
  }) {
    return ScaffoldBoxConstraints(
      headerHeight: headerHeight,
      footerHeight: footerHeight,
      minWidth: constraints.minWidth,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  ScaffoldBoxConstraints copyWith({
    double? headerHeight,
    double? footerHeight,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ScaffoldBoxConstraints(
      headerHeight: headerHeight ?? this.headerHeight,
      footerHeight: footerHeight ?? this.footerHeight,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScaffoldBoxConstraints) return false;
    return other.headerHeight == headerHeight &&
        other.footerHeight == footerHeight &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth &&
        other.minHeight == minHeight &&
        other.maxHeight == maxHeight;
  }

  @override
  int get hashCode {
    return Object.hash(
      headerHeight,
      footerHeight,
      minWidth,
      maxWidth,
      minHeight,
      maxHeight,
    );
  }

  @override
  String toString() {
    return 'ScaffoldBoxConstraints(headerHeight: $headerHeight, footerHeight: $footerHeight, minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight)';
  }
}

/// A customizable application bar component for layout headers.
///
/// Provides a flexible top-level navigation and branding component that
/// typically appears at the top of screens or content areas. The app bar
/// supports leading and trailing widget areas, title content, optional
/// header/subtitle elements, and comprehensive styling customization.
///
/// The component automatically handles safe area considerations, background
/// effects, and responsive layout behaviors. Leading and trailing areas
/// support multiple widgets with configurable spacing, while the center
/// area can contain titles, custom content, or complex layouts.
///
/// Integrates with the theme system for consistent appearance and supports
/// surface blur effects, background customization, and flexible sizing
/// constraints to adapt to various layout requirements.
///
/// Example:
/// ```dart
/// AppBar(
///   leading: [
///     IconButton(icon: Icon(Icons.menu), onPressed: _openDrawer),
///   ],
///   title: Text('My Application'),
///   subtitle: Text('Dashboard'),
///   trailing: [
///     IconButton(icon: Icon(Icons.search), onPressed: _openSearch),
///     IconButton(icon: Icon(Icons.more_vert), onPressed: _showMenu),
///   ],
///   backgroundColor: Colors.blue.shade50,
/// )
/// ```
class AppBar extends StatefulWidget {
  /// List of widgets to display in the trailing (right) area of the app bar.
  ///
  /// Typically contains action buttons, menus, or other interactive elements.
  /// Items are arranged horizontally with appropriate spacing based on the
  /// [trailingGap] setting.
  final List<Widget> trailing;

  /// List of widgets to display in the leading (left) area of the app bar.
  ///
  /// Commonly includes back buttons, menu buttons, or branding elements.
  /// Items are arranged horizontally with spacing controlled by [leadingGap].
  final List<Widget> leading;

  /// Optional main content widget displayed in the center area.
  ///
  /// When provided, this widget takes precedence over [title], [header],
  /// and [subtitle] for the central content area. Useful for custom layouts.
  final Widget? child;

  /// Primary title text or widget for the app bar.
  ///
  /// Displayed prominently in the center area when [child] is not provided.
  /// Should clearly identify the current screen or application section.
  final Widget? title;

  /// Optional small widget placed above the title.
  ///
  /// Provides additional context or branding above the main title.
  /// Typically used for breadcrumbs, status indicators, or secondary labels.
  final Widget? header;

  /// Optional small widget placed below the title.
  ///
  /// Provides supplementary information below the main title.
  /// Commonly used for descriptions, status text, or secondary navigation.
  final Widget? subtitle;

  /// Whether the trailing area should expand to fill available space.
  ///
  /// When true, the trailing area expands instead of the main content area,
  /// useful for toolbars or action-heavy interfaces where trailing content
  /// needs maximum space allocation.
  final bool trailingExpanded;

  /// Alignment of content within the app bar.
  ///
  /// Controls how the central content (title, header, subtitle, or child)
  /// is positioned within its available space. Default centers the content.
  final AlignmentGeometry alignment;

  /// Background color for the app bar surface.
  ///
  /// When null, uses the theme's default app bar background color.
  /// The background provides visual separation from underlying content.
  final Color? backgroundColor;

  /// Spacing between leading widgets.
  ///
  /// Controls the horizontal gap between adjacent widgets in the leading area.
  /// When null, uses theme-appropriate default spacing.
  final double? leadingGap;

  /// Spacing between trailing widgets.
  ///
  /// Controls the horizontal gap between adjacent widgets in the trailing area.
  /// When null, uses theme-appropriate default spacing.
  final double? trailingGap;

  /// Internal padding applied within the app bar.
  ///
  /// Provides space around all app bar content, creating breathing room
  /// from the edges and ensuring proper spacing from screen boundaries.
  final EdgeInsetsGeometry? padding;

  /// Fixed height for the app bar.
  ///
  /// When specified, constrains the app bar to this exact height.
  /// When null, the app bar sizes itself based on content and theme defaults.
  final double? height;

  /// Whether to account for system safe areas (status bar, notch).
  ///
  /// When true, automatically adds padding to avoid system UI intrusions.
  /// Typically enabled for top-level app bars in full-screen contexts.
  final bool useSafeArea;

  /// Blur intensity for surface background effects.
  ///
  /// Controls backdrop blur effects behind the app bar surface.
  /// Higher values create more pronounced blur effects.
  final double? surfaceBlur;

  /// Opacity level for surface background effects.
  ///
  /// Controls transparency of background blur and overlay effects.
  /// Values range from 0.0 (transparent) to 1.0 (opaque).
  final double? surfaceOpacity;

  /// Creates an [AppBar] with the specified content and configuration.
  ///
  /// All parameters are optional with sensible defaults. The app bar
  /// automatically handles layout, spacing, and theming while providing
  /// extensive customization options for complex interface requirements.
  ///
  /// Content can be provided through individual title/header/subtitle parameters
  /// or by using the [child] parameter for complete custom layouts. Leading
  /// and trailing areas support multiple widgets with automatic spacing.
  ///
  /// Parameters:
  /// - [leading] (`List<Widget>`, default: []): Leading area widgets (left side)
  /// - [trailing] (`List<Widget>`, default: []): Trailing area widgets (right side)
  /// - [title] (Widget?, optional): Primary title content
  /// - [header] (Widget?, optional): Secondary content above title
  /// - [subtitle] (Widget?, optional): Secondary content below title
  /// - [child] (Widget?, optional): Custom content (overrides title components)
  /// - [alignment] (AlignmentGeometry, default: center): Content alignment
  /// - [trailingExpanded] (bool, default: false): Whether trailing area expands
  /// - [useSafeArea] (bool, default: depends on context): Handle system intrusions
  ///
  /// Example:
  /// ```dart
  /// AppBar(
  ///   leading: [BackButton()],
  ///   title: Text('Settings'),
  ///   trailing: [
  ///     IconButton(icon: Icon(Icons.help), onPressed: _showHelp),
  ///     PopupMenuButton(items: menuItems),
  ///   ],
  ///   backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  /// )
  /// ```
  const AppBar({
    super.key,
    this.trailing = const [],
    this.leading = const [],
    this.title,
    this.header,
    this.subtitle,
    this.child,
    this.trailingExpanded = false,
    this.alignment = Alignment.center,
    this.padding,
    this.backgroundColor,
    this.leadingGap,
    this.trailingGap,
    this.height,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.useSafeArea = true,
  }) : assert(
          child == null || title == null,
          'Cannot provide both child and title',
        );

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final barData = Data.maybeOf<ScaffoldBarData>(context);
    var surfaceBlur = widget.surfaceBlur ?? theme.surfaceBlur;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    return FocusTraversalGroup(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: surfaceBlur ?? 0,
            sigmaY: surfaceBlur ?? 0,
          ),
          child: Container(
            color: widget.backgroundColor ??
                theme.colorScheme.card.scaleAlpha(surfaceOpacity ?? 1),
            alignment: widget.alignment,
            padding: widget.padding ??
                (const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ) *
                    scaling),
            child: SafeArea(
              top: widget.useSafeArea &&
                  barData?.isHeader == true &&
                  barData?.childIndex == 0,
              right: widget.useSafeArea,
              left: widget.useSafeArea,
              bottom: widget.useSafeArea &&
                  barData?.isHeader == false &&
                  barData?.childIndex == (barData?.childrenCount ?? 0) - 1,
              child: SizedBox(
                height: widget.height,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.leading.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: widget.leading,
                        ).gap(widget.leadingGap ?? (4 * scaling)),
                      Flexible(
                        fit: widget.trailingExpanded
                            ? FlexFit.loose
                            : FlexFit.tight,
                        child: widget.child ??
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.header != null)
                                  KeyedSubtree(
                                    key: const ValueKey('header'),
                                    child: widget.header!.muted().small(),
                                  ),
                                if (widget.title != null)
                                  KeyedSubtree(
                                    key: const ValueKey('title'),
                                    child: widget.title!.large().medium(),
                                  ),
                                if (widget.subtitle != null)
                                  KeyedSubtree(
                                    key: const ValueKey('subtitle'),
                                    child: widget.subtitle!.muted().small(),
                                  ),
                              ],
                            ),
                      ),
                      if (widget.trailing.isNotEmpty)
                        if (!widget.trailingExpanded)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widget.trailing,
                          ).gap(widget.trailingGap ?? (4 * scaling))
                        else
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: widget.trailing,
                            ).gap(widget.trailingGap ?? (4 * scaling)),
                          ),
                    ],
                  ).gap(18 * scaling),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScaffoldFlex extends MultiChildRenderObjectWidget {
  final bool floatingHeader;
  final bool floatingFooter;
  const _ScaffoldFlex({
    super.children,
    required this.floatingHeader,
    required this.floatingFooter,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ScaffoldRenderFlex(
      floatingHeader: floatingHeader,
      floatingFooter: floatingFooter,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _ScaffoldRenderFlex renderObject) {
    bool needsLayout = false;
    if (renderObject._floatingHeader != floatingHeader) {
      renderObject._floatingHeader = floatingHeader;
      needsLayout = true;
    }
    if (renderObject._floatingFooter != floatingFooter) {
      renderObject._floatingFooter = floatingFooter;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class _ScaffoldParentData extends ContainerBoxParentData<RenderBox> {}

class _ScaffoldRenderFlex extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _ScaffoldParentData> {
  _ScaffoldRenderFlex({
    required bool floatingHeader,
    required bool floatingFooter,
  })  : _floatingHeader = floatingHeader,
        _floatingFooter = floatingFooter;

  bool _floatingHeader = false;
  bool _floatingFooter = false;

  final ValueNotifier<double> _headerSize = ValueNotifier(0);
  final ValueNotifier<double> _footerSize = ValueNotifier(0);

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _ScaffoldParentData) {
      child.parentData = _ScaffoldParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // There is gonna be only 3 children
    // 1. header
    // 2. content
    // 3. footer
    // By default, the paint order is 1, 2, 3
    // but with this custom implementation, we can change the order to 2, 1, 3
    // which means the header will be painted after the content
    // and the footer will be painted after the header
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    context.paintChild(
        content, (content.parentData as BoxParentData).offset + offset);
    context.paintChild(
        header, (header.parentData as BoxParentData).offset + offset);
    context.paintChild(
        footer, (footer.parentData as BoxParentData).offset + offset);
  }

  bool _hitTestBox(BoxHitTestResult result, RenderBox child, Offset position) {
    final BoxParentData childParentData = child.parentData as BoxParentData;
    final bool isHit = result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        assert(transformed == position - childParentData.offset);
        return child.hitTest(result, position: transformed);
      },
    );
    return isHit;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    if (_hitTestBox(result, header, position)) {
      return true;
    }
    if (_hitTestBox(result, footer, position)) {
      return true;
    }
    if (_hitTestBox(result, content, position)) {
      return true;
    }
    return false;
  }

  @override
  void performLayout() {
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    final constraints = this.constraints;
    header.layout(constraints, parentUsesSize: true);
    footer.layout(constraints, parentUsesSize: true);
    BoxConstraints contentConstraints;
    Offset contentOffset;
    double footerSize = footer.getMaxIntrinsicHeight(double.infinity);
    double headerSize = header.getMaxIntrinsicHeight(double.infinity);
    switch ((_floatingHeader, _floatingFooter)) {
      case (true, true): // floating header and footer
        contentConstraints = constraints;
        contentOffset = Offset.zero;
        break;
      case (true, false): // floating header
        contentConstraints = constraints.deflate(
          EdgeInsets.only(bottom: footerSize),
        );
        contentOffset = Offset.zero;
        break;
      case (false, true): // floating footer
        contentConstraints = constraints.deflate(
          EdgeInsets.only(top: headerSize),
        );
        contentOffset = Offset(0, headerSize);
        break;
      case (false, false):
        contentConstraints = constraints.deflate(
          EdgeInsets.only(
            top: headerSize,
            bottom: footerSize,
          ),
        );
        contentOffset = Offset(0, headerSize);
        break;
    }
    content.layout(ScaffoldBoxConstraints.fromBoxConstraints(
      constraints: contentConstraints,
      headerHeight: headerSize,
      footerHeight: footerSize,
    ));
    size = constraints.biggest;
    (content.parentData as BoxParentData).offset = contentOffset;
    (footer.parentData as BoxParentData).offset = Offset(
      0,
      constraints.biggest.height - footerSize,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _headerSize.value = headerSize;
      _footerSize.value = footerSize;
    });
  }
}

/// Widget that applies header-aware padding to its child.
///
/// Automatically adjusts padding based on scaffold header height.
class ScaffoldHeaderPadding extends SingleChildRenderObjectWidget {
  /// Creates [ScaffoldHeaderPadding].
  const ScaffoldHeaderPadding({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(
      paddingType: _ScaffoldPaddingType.header,
    );
  }
}

/// Widget that applies footer-aware padding to its child.
///
/// Automatically adjusts padding based on scaffold footer height.
class ScaffoldFooterPadding extends SingleChildRenderObjectWidget {
  /// Creates [ScaffoldFooterPadding].
  const ScaffoldFooterPadding({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(
      paddingType: _ScaffoldPaddingType.footer,
    );
  }
}

enum _ScaffoldPaddingType {
  header,
  footer,
}

class _RenderScaffoldPadding extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ScaffoldParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ScaffoldParentData> {
  final _ScaffoldPaddingType _paddingType;

  _RenderScaffoldPadding({
    _ScaffoldPaddingType paddingType = _ScaffoldPaddingType.header,
  }) : _paddingType = paddingType;

  _ScaffoldRenderFlex? findParent() {
    RenderObject? parent = this;
    while (parent != null) {
      if (parent is _ScaffoldRenderFlex) {
        return parent;
      }
      parent = parent.parent;
    }
    return null;
  }

  _ScaffoldRenderFlex? currentParent;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    var scaffoldParent = findParent();
    currentParent = scaffoldParent;
    scaffoldParent?._headerSize.addListener(markNeedsLayout);
    scaffoldParent?._footerSize.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    var scaffoldParent = currentParent;
    scaffoldParent?._headerSize.removeListener(markNeedsLayout);
    scaffoldParent?._footerSize.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void performLayout() {
    _ScaffoldRenderFlex? parentData = findParent();
    assert(parentData != null, 'Must be a child of a Scaffold');
    BoxConstraints constraints;
    switch (_paddingType) {
      case _ScaffoldPaddingType.header:
        constraints = this.constraints.copyWith(
              minHeight: parentData!._headerSize.value,
              maxHeight: parentData._headerSize.value,
            );
        break;
      case _ScaffoldPaddingType.footer:
        constraints = this.constraints.copyWith(
              minHeight: parentData!._footerSize.value,
              maxHeight: parentData._footerSize.value,
            );
        break;
    }
    final child = firstChild;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child.size);
      (child.parentData as BoxParentData).offset = Offset.zero;
    } else {
      size = constraints.biggest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
