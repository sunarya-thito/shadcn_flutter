import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [NavigationMenu] components.
///
/// Defines visual properties for navigation menu popovers including
/// surface appearance, positioning, and spacing. This theme controls
/// how navigation menu content is displayed when triggered.
///
/// The theme can be applied through [ComponentTheme] or passed directly
/// to individual [NavigationMenu] widgets for customization.
class NavigationMenuTheme {
  /// Opacity of the popover surface.
  final double? surfaceOpacity;

  /// Blur amount of the popover surface.
  final double? surfaceBlur;

  /// Margin applied to the popover.
  final EdgeInsetsGeometry? margin;

  /// Offset for the popover relative to the trigger.
  final Offset? offset;

  /// Creates a [NavigationMenuTheme] with the specified appearance properties.
  ///
  /// All parameters are optional and will fall back to default values
  /// when not provided. This allows for partial customization while
  /// maintaining consistent defaults.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (double?, optional): Opacity level for popover background
  /// - [surfaceBlur] (double?, optional): Blur effect intensity for popover
  /// - [margin] (EdgeInsetsGeometry?, optional): Space around the popover
  /// - [offset] (Offset?, optional): Position offset relative to trigger
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuTheme(
  ///   surfaceOpacity: 0.9,
  ///   surfaceBlur: 8.0,
  ///   margin: EdgeInsets.all(16.0),
  ///   offset: Offset(0, 8),
  /// )
  /// ```
  const NavigationMenuTheme({
    this.surfaceOpacity,
    this.surfaceBlur,
    this.margin,
    this.offset,
  });

  /// Returns a copy of this theme with the given fields replaced.
  NavigationMenuTheme copyWith({
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<EdgeInsetsGeometry?>? margin,
    ValueGetter<Offset?>? offset,
  }) {
    return NavigationMenuTheme(
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      margin: margin == null ? this.margin : margin(),
      offset: offset == null ? this.offset : offset(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavigationMenuTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.margin == margin &&
        other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(surfaceOpacity, surfaceBlur, margin, offset);
}

/// An individual menu item within a [NavigationMenu].
///
/// Represents a single interactive element in a navigation menu structure.
/// Each item can function as either a standalone action button or a trigger
/// for displaying additional content in a popover. When content is provided,
/// the item shows a chevron indicator and triggers the popover on interaction.
///
/// The item automatically integrates with its parent [NavigationMenu] to
/// manage popover state, hover interactions, and visual feedback. Items
/// with content become active when hovered or clicked, displaying their
/// associated content in the navigation menu's popover.
///
/// Example:
/// ```dart
/// NavigationMenuItem(
///   onPressed: () => print('Item pressed'),
///   content: NavigationMenuContent(
///     title: Text('Products'),
///     content: Text('Browse our product catalog'),
///   ),
///   child: Text('Products'),
/// )
/// ```
class NavigationMenuItem extends StatefulWidget {
  /// Callback invoked when this menu item is pressed.
  ///
  /// Called when the user taps or clicks on the menu item. This action
  /// is independent of content display - items with content can still
  /// have onPressed callbacks for additional behavior like navigation.
  final VoidCallback? onPressed;

  /// The content to display in the navigation menu popover.
  ///
  /// When provided, this widget is rendered in the navigation menu's
  /// popover when the item is activated. The item shows a chevron
  /// indicator and responds to hover/click interactions to display
  /// this content. If null, the item functions as a simple action button.
  final Widget? content;

  /// The main visual content of the menu item.
  ///
  /// This widget is always displayed as the item's label or trigger.
  /// It should clearly represent the item's purpose or destination
  /// and is typically a [Text] widget or icon combination.
  final Widget child;

  /// Creates a [NavigationMenuItem] with the specified properties.
  ///
  /// The [child] parameter is required as it provides the visible
  /// content for the menu item. Either [onPressed] or [content]
  /// should be provided to make the item interactive.
  ///
  /// Parameters:
  /// - [onPressed] (VoidCallback?, optional): Action when item is pressed
  /// - [content] (Widget?, optional): Content for navigation popover
  /// - [child] (Widget, required): The visible menu item content
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuItem(
  ///   onPressed: _handleNavigation,
  ///   child: Row(
  ///     children: [Icon(Icons.home), Text('Home')],
  ///   ),
  /// )
  /// ```
  const NavigationMenuItem(
      {super.key, this.onPressed, this.content, required this.child});

  @override
  State<NavigationMenuItem> createState() => NavigationMenuItemState();
}

/// State class for [NavigationMenuItem] widget.
///
/// Manages the lifecycle and interaction of a single navigation menu item.
class NavigationMenuItemState extends State<NavigationMenuItem> {
  NavigationMenuState? _menuState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newMenuState = Data.maybeOf<NavigationMenuState>(context);
    assert(newMenuState != null,
        'NavigationItem must be a descendant of NavigationMenu');
    if (_menuState != newMenuState) {
      _menuState = newMenuState;
      if (widget.content != null) {
        _menuState!._attachContentBuilder(
          this,
          (context) {
            return widget.content!;
          },
        );
      }
    }
  }

  @override
  void didUpdateWidget(covariant NavigationMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.content != oldWidget.content) {
      if (widget.content != null) {
        _menuState!._attachContentBuilder(
          this,
          (context) {
            return widget.content!;
          },
        );
      } else {
        _menuState!._contentBuilders.remove(this);
      }
    }
  }

  @override
  void dispose() {
    if (widget.content != null) {
      _menuState!._contentBuilders.remove(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: Listenable.merge(
            [_menuState!._activeIndex, _menuState!._popoverController]),
        builder: (context, child) {
          return Button(
            style: const ButtonStyle.ghost().copyWith(
              decoration: (context, states, value) {
                if (_menuState!.isActive(this)) {
                  return (value as BoxDecoration).copyWith(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    color: theme.colorScheme.muted.scaleAlpha(0.8),
                  );
                }
                return value;
              },
            ),
            trailing: widget.content != null
                ? AnimatedRotation(
                    duration: kDefaultDuration,
                    turns: _menuState!.isActive(this) ? 0.5 : 0,
                    child: const Icon(
                      RadixIcons.chevronDown,
                    ).iconXSmall(),
                  )
                : null,
            onHover: (hovered) {
              if (hovered) {
                _menuState!._activate(this);
              }
            },
            onPressed: widget.onPressed != null || widget.content != null
                ? () {
                    if (widget.onPressed != null) {
                      widget.onPressed!();
                    }
                    if (widget.content != null) {
                      _menuState!._activate(this);
                    }
                  }
                : null,
            child: widget.child,
          );
        });
  }
}

/// A content item displayed within a navigation menu popover.
///
/// Provides a structured layout for navigation menu content with support
/// for titles, descriptions, leading/trailing widgets, and interactive behavior.
/// This widget is designed to be used within [NavigationMenuItem] content
/// to create rich, informative menu options.
///
/// The content displays as a button with optional leading icon, title text,
/// descriptive content, and trailing elements. When pressed, it can trigger
/// custom actions while maintaining the navigation menu's visual consistency.
///
/// Example:
/// ```dart
/// NavigationMenuContent(
///   leading: Icon(Icons.dashboard),
///   title: Text('Dashboard'),
///   content: Text('View project analytics and metrics'),
///   onPressed: () => Navigator.pushNamed(context, '/dashboard'),
/// )
/// ```
class NavigationMenuContent extends StatelessWidget {
  /// The primary title text for this content item.
  ///
  /// Displayed prominently as the main label for this navigation option.
  /// Should clearly indicate the destination or action this item represents.
  final Widget title;

  /// Optional descriptive content shown below the title.
  ///
  /// Provides additional context or explanation for the navigation option.
  /// Rendered in a muted text style to maintain visual hierarchy.
  final Widget? content;

  /// Optional widget displayed before the title.
  ///
  /// Commonly used for icons or other visual indicators that help
  /// identify the navigation option at a glance.
  final Widget? leading;

  /// Optional widget displayed after the title and content.
  ///
  /// Can be used for badges, indicators, or additional actions
  /// related to this navigation option.
  final Widget? trailing;

  /// Callback invoked when this content item is pressed.
  ///
  /// Called when the user taps or clicks on the content item.
  /// Typically used for navigation or other actions.
  final VoidCallback? onPressed;

  /// Creates a [NavigationMenuContent] with the specified properties.
  ///
  /// The [title] parameter is required as it provides the primary
  /// label for the navigation option. All other parameters are
  /// optional and enhance the content's functionality and appearance.
  ///
  /// Parameters:
  /// - [title] (Widget, required): The primary title text
  /// - [content] (Widget?, optional): Descriptive text below title
  /// - [leading] (Widget?, optional): Icon or widget before title
  /// - [trailing] (Widget?, optional): Widget after title and content
  /// - [onPressed] (VoidCallback?, optional): Action when item is pressed
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuContent(
  ///   leading: Icon(Icons.settings),
  ///   title: Text('Settings'),
  ///   content: Text('Manage application preferences'),
  ///   trailing: Icon(Icons.arrow_forward_ios, size: 16),
  ///   onPressed: _openSettings,
  /// )
  /// ```
  const NavigationMenuContent({
    super.key,
    required this.title,
    this.content,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Button(
      style: ButtonVariance.ghost.copyWith(
        padding: (context, states, value) {
          return const EdgeInsets.all(12) * scaling;
        },
      ),
      onPressed: onPressed,
      alignment: Alignment.topLeft,
      child: Basic(
        title: title.medium(),
        content: content?.muted(),
        trailing: trailing,
        leading: leading,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    ).constrained(maxWidth: 16 * 16 * scaling);
  }
}

/// A grid layout container for organizing navigation menu content items.
///
/// Provides flexible grid-based layout for multiple [NavigationMenuContent]
/// items within a navigation menu popover. The layout arranges items in
/// columns and rows with customizable spacing and supports responsive
/// organization of navigation options.
///
/// The grid layout adapts to the number of items and specified column count,
/// creating a structured presentation for complex navigation menus with
/// multiple categories or sections of content.
///
/// Example:
/// ```dart
/// NavigationMenuContentList(
///   crossAxisCount: 2,
///   spacing: 16.0,
///   runSpacing: 12.0,
///   children: [
///     NavigationMenuContent(title: Text('Dashboard'), onPressed: _openDashboard),
///     NavigationMenuContent(title: Text('Analytics'), onPressed: _openAnalytics),
///     NavigationMenuContent(title: Text('Settings'), onPressed: _openSettings),
///   ],
/// )
/// ```
class NavigationMenuContentList extends StatelessWidget {
  /// The list of widgets to arrange in the grid layout.
  ///
  /// Typically contains [NavigationMenuContent] items or other
  /// navigation-related widgets that should be organized in a grid.
  final List<Widget> children;

  /// Number of items to display in each row of the grid.
  ///
  /// Controls the grid's column count and affects how items are
  /// distributed across rows. Default value is 3 columns.
  final int crossAxisCount;

  /// Spacing between items within the same row.
  ///
  /// Controls horizontal spacing between grid items. If not specified,
  /// uses a default value based on the theme's scaling factor.
  final double? spacing;

  /// Spacing between rows in the grid.
  ///
  /// Controls vertical spacing between grid rows. If not specified,
  /// uses a default value based on the theme's scaling factor.
  final double? runSpacing;

  /// Whether to reverse the order of columns in each row.
  ///
  /// When true, items are arranged in reverse order within their rows.
  /// This can be useful for RTL layouts or specific design requirements.
  final bool reverse;

  /// Creates a [NavigationMenuContentList] with the specified layout properties.
  ///
  /// The [children] parameter is required and should contain the items
  /// to be arranged in the grid. The layout properties control the
  /// grid's appearance and spacing.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): Items to arrange in grid
  /// - [crossAxisCount] (int, default: 3): Number of columns per row
  /// - [spacing] (double?, optional): Horizontal spacing between items
  /// - [runSpacing] (double?, optional): Vertical spacing between rows
  /// - [reverse] (bool, default: false): Whether to reverse column order
  ///
  /// Example:
  /// ```dart
  /// NavigationMenuContentList(
  ///   crossAxisCount: 2,
  ///   spacing: 20.0,
  ///   children: menuItems,
  /// )
  /// ```
  const NavigationMenuContentList({
    super.key,
    required this.children,
    this.crossAxisCount = 3,
    this.spacing,
    this.runSpacing,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> columns = [];
    List<Widget> rows = [];
    var spacing = this.spacing ?? (12 * scaling);
    var runSpacing = this.runSpacing ?? (12 * scaling);
    for (final child in children) {
      columns.add(Expanded(child: child));
      if (columns.length == crossAxisCount) {
        rows.add(IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: columns.joinSeparator(SizedBox(height: spacing)),
          ),
        ));
        columns = [];
      }
    }
    if (columns.isNotEmpty) {
      rows.add(IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: columns.joinSeparator(SizedBox(height: runSpacing)),
        ),
      ));
    }
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (reverse ? rows.reversed.toList() : rows)
              .joinSeparator(SizedBox(width: spacing)),
        ),
      ),
    );
  }
}

/// A horizontal navigation menu with dropdown content support.
///
/// Provides a sophisticated navigation component that displays menu items
/// in a horizontal layout with support for dropdown content. When menu items
/// have associated content, hovering or clicking reveals a popover with
/// additional navigation options or information.
///
/// The navigation menu manages popover state, hover interactions, and smooth
/// transitions between different content sections. It supports both simple
/// action items and complex content-rich dropdown menus with animated
/// transitions and responsive behavior.
///
/// The menu uses a popover overlay to display content, which automatically
/// positions itself relative to the trigger and handles edge cases for
/// viewport constraints and user interactions.
///
/// Example:
/// ```dart
/// NavigationMenu(
///   surfaceOpacity: 0.95,
///   surfaceBlur: 8.0,
///   children: [
///     NavigationMenuItem(
///       child: Text('Products'),
///       content: NavigationMenuContentList(
///         children: [
///           NavigationMenuContent(title: Text('Web Apps')),
///           NavigationMenuContent(title: Text('Mobile Apps')),
///         ],
///       ),
///     ),
///     NavigationMenuItem(
///       child: Text('About'),
///       onPressed: () => Navigator.pushNamed(context, '/about'),
///     ),
///   ],
/// )
/// ```
class NavigationMenu extends StatefulWidget {
  /// Opacity level for the popover surface background.
  ///
  /// Controls the transparency of the dropdown content's background.
  /// Values range from 0.0 (fully transparent) to 1.0 (fully opaque).
  /// If not specified, uses the theme's default surface opacity.
  final double? surfaceOpacity;

  /// Blur effect intensity for the popover surface.
  ///
  /// Controls the backdrop blur effect applied behind the dropdown content.
  /// Higher values create more blur. If not specified, uses the theme's
  /// default surface blur setting.
  final double? surfaceBlur;

  /// The list of menu items to display in the navigation menu.
  ///
  /// Each item should be a [NavigationMenuItem] that defines the
  /// menu's structure and behavior. Items can have content for
  /// dropdown functionality or simple press actions.
  final List<Widget> children;

  /// Creates a [NavigationMenu] with the specified items and appearance.
  ///
  /// The [children] parameter is required and should contain
  /// [NavigationMenuItem] widgets that define the menu structure.
  /// Appearance properties are optional and will use theme defaults.
  ///
  /// Parameters:
  /// - [surfaceOpacity] (double?, optional): Popover background opacity
  /// - [surfaceBlur] (double?, optional): Popover backdrop blur intensity
  /// - [children] (`List<Widget>`, required): Menu items to display
  ///
  /// Example:
  /// ```dart
  /// NavigationMenu(
  ///   surfaceOpacity: 0.9,
  ///   children: [
  ///     NavigationMenuItem(child: Text('Home'), onPressed: _goHome),
  ///     NavigationMenuItem(child: Text('About'), onPressed: _showAbout),
  ///   ],
  /// )
  /// ```
  const NavigationMenu({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  @override
  State<NavigationMenu> createState() => NavigationMenuState();
}

/// State class for [NavigationMenu] managing menu interactions and timing.
///
/// Handles hover debouncing, popover control, active menu item tracking,
/// and content builder management for navigation menu items.
class NavigationMenuState extends State<NavigationMenu> {
  /// Debounce duration for hover interactions to prevent flickering.
  static const Duration kDebounceDuration = Duration(milliseconds: 200);
  // final GlobalKey<PopoverAnchorState> _popoverKey = GlobalKey();
  // final ValueNotifier<bool> _visible = ValueNotifier(false);
  final PopoverController _popoverController = PopoverController();
  final ValueNotifier<int> _activeIndex = ValueNotifier(0);
  final Map<NavigationMenuItemState, WidgetBuilder> _contentBuilders = {};

  int _hoverCount = 0;

  void _attachContentBuilder(
      NavigationMenuItemState key, WidgetBuilder builder) {
    _contentBuilders[key] = builder;
  }

  /// Checks if the given menu item is currently active.
  ///
  /// Parameters:
  /// - [item] (`NavigationMenuItemState`, required): the menu item to check
  ///
  /// Returns: `bool` — true if the item is active and popover is open
  bool isActive(NavigationMenuItemState item) {
    return _popoverController.hasOpenPopover &&
        widget.children[_activeIndex.value] == item.widget;
  }

  @override
  void dispose() {
    _activeIndex.dispose();
    _popoverController.dispose();
    super.dispose();
  }

  void _show(BuildContext context) {
    if (_popoverController.hasOpenPopover) {
      _popoverController.anchorContext = context;
      return;
    }
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<NavigationMenuTheme>(context);
    _popoverController.show(
      context: context,
      alignment: Alignment.topCenter,
      regionGroupId: this,
      offset: compTheme?.offset ?? const Offset(0, 4) * scaling,
      builder: buildPopover,
      modal: false,
      margin: requestMargin() ??
          compTheme?.margin ??
          (const EdgeInsets.all(8) * scaling),
      allowInvertHorizontal: false,
      allowInvertVertical: false,
      onTickFollow: (value) {
        value.margin = requestMargin() ??
            compTheme?.margin ??
            (const EdgeInsets.all(8) * scaling);
      },
    );
  }

  void _activate(NavigationMenuItemState item) {
    if (item.widget.content == null) {
      close();
      return;
    }
    final index = widget.children.indexOf(item.widget);
    _activeIndex.value = index;
    _show(item.context);
  }

  /// Finds a navigation menu item state by its widget.
  ///
  /// Parameters:
  /// - [widget] (`Widget`, required): the widget to search for
  ///
  /// Returns: `NavigationMenuItemState?` — the state if found, null otherwise
  NavigationMenuItemState? findByWidget(Widget widget) {
    return _contentBuilders.keys
        .where((key) => key.widget == widget)
        .firstOrNull;
  }

  /// Builds the content for the menu item at the given index.
  ///
  /// Parameters:
  /// - [index] (`int`, required): index of the menu item
  ///
  /// Returns: `Widget` — the content widget
  Widget buildContent(int index) {
    NavigationMenuItemState? item = findByWidget(widget.children[index]);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    if (item != null) {
      return Data<NavigationMenuState>.boundary(
        child: Padding(
          padding: const EdgeInsets.all(12.0) * scaling,
          child: _contentBuilders[item]!(context),
        ),
      );
    }
    return Container();
  }

  /// Closes the currently open popover menu.
  void close() {
    _popoverController.close();
  }

  /// Builds the popover widget for the navigation menu.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): build context
  ///
  /// Returns: `Widget` — the popover widget
  Widget buildPopover(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<NavigationMenuTheme>(context);
    final surfaceOpacity = widget.surfaceOpacity ??
        compTheme?.surfaceOpacity ??
        theme.surfaceOpacity;
    final surfaceBlur =
        widget.surfaceBlur ?? compTheme?.surfaceBlur ?? theme.surfaceBlur;
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (_) {
        _hoverCount++;
      },
      onExit: (event) {
        int currentHoverCount = ++_hoverCount;
        Future.delayed(kDebounceDuration, () {
          if (currentHoverCount == _hoverCount && mounted) {
            close();
          }
        });
      },
      child: AnimatedBuilder(
          animation: _activeIndex,
          builder: (context, child) {
            return AnimatedValueBuilder<double>(
              value: _activeIndex.value.toDouble(),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                int currentIndex = _activeIndex.value;
                List<Widget> children = [];
                if (currentIndex - 1 >= 0) {
                  children.add(
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Opacity(
                        opacity: (1 + value - currentIndex).clamp(0.0, 1.0),
                        child: FractionalTranslation(
                          translation: Offset(-value + currentIndex - 1, 0),
                          child: buildContent(currentIndex - 1),
                        ),
                      ),
                    ),
                  );
                }
                if (currentIndex + 1 < widget.children.length) {
                  children.add(
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Opacity(
                        opacity: (1 - value + currentIndex).clamp(0.0, 1.0),
                        child: FractionalTranslation(
                          translation: Offset(-value + currentIndex + 1, 0),
                          child: buildContent(currentIndex + 1),
                        ),
                      ),
                    ),
                  );
                }
                return OutlinedContainer(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: theme.borderRadiusMd,
                  surfaceOpacity: surfaceOpacity,
                  surfaceBlur: surfaceBlur,
                  child: Stack(
                    children: [
                      ...children,
                      FractionalTranslation(
                        translation: Offset(-value + currentIndex, 0),
                        child: buildContent(currentIndex),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  /// Calculates the margin for the popover based on current widget position.
  ///
  /// Returns: `EdgeInsets?` — calculated margin or null if render box not available
  EdgeInsets? requestMargin() {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset globalPosition = box.localToGlobal(Offset.zero);
      Size size = box.size;
      return EdgeInsets.only(
          left: globalPosition.dx,
          top: globalPosition.dy + size.height,
          right: 8,
          bottom: 8);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      groupId: this,
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (_) {
          _hoverCount++;
        },
        onExit: (_) {
          int currentHoverCount = ++_hoverCount;
          Future.delayed(kDebounceDuration, () {
            if (currentHoverCount == _hoverCount && mounted) {
              close();
            }
          });
        },
        child: IntrinsicHeight(
          child: Data.inherit(
            data: this,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
