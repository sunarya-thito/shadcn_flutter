import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Theme configuration for skeleton loading effects.
///
/// Provides styling properties for skeleton loading animations including pulse
/// timing, colors, and animation behavior. These properties integrate with the
/// shadcn design system and work with the underlying Skeletonizer package.
///
/// The theme enables consistent skeleton styling across the application while
/// allowing for customization of animation characteristics and visual appearance.
class SkeletonTheme extends ComponentThemeData {
  /// The duration of one complete pulse animation cycle.
  ///
  /// Type: `Duration?`. If null, defaults to 1 second for a natural breathing
  /// effect. Controls the speed of the fade in/out pulse animation.
  final Duration? duration;

  /// The starting color of the pulse animation.
  ///
  /// Type: `Color?`. If null, uses primary color with 5% opacity from theme.
  /// Represents the lightest state of the skeleton shimmer effect.
  final Color? fromColor;

  /// The ending color of the pulse animation.
  ///
  /// Type: `Color?`. If null, uses primary color with 10% opacity from theme.
  /// Represents the darkest state of the skeleton shimmer effect.
  final Color? toColor;

  /// Whether to enable smooth transitions when switching between skeleton states.
  ///
  /// Type: `bool?`. If null, defaults to true. When enabled, provides smooth
  /// fade transitions when toggling skeleton visibility on/off.
  final bool? enableSwitchAnimation;

  /// Creates a [SkeletonTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// that integrate with the current theme's color scheme and design system.
  ///
  /// Example:
  /// ```dart
  /// const SkeletonTheme(
  ///   duration: Duration(milliseconds: 800),
  ///   fromColor: Colors.grey.withOpacity(0.1),
  ///   toColor: Colors.grey.withOpacity(0.2),
  ///   enableSwitchAnimation: true,
  /// );
  /// ```
  const SkeletonTheme({
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
  });

  /// Returns a copy of this theme with the given fields replaced.
  SkeletonTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Color?>? fromColor,
    ValueGetter<Color?>? toColor,
    ValueGetter<bool?>? enableSwitchAnimation,
  }) {
    return SkeletonTheme(
      duration: duration == null ? this.duration : duration(),
      fromColor: fromColor == null ? this.fromColor : fromColor(),
      toColor: toColor == null ? this.toColor : toColor(),
      enableSwitchAnimation: enableSwitchAnimation == null
          ? this.enableSwitchAnimation
          : enableSwitchAnimation(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SkeletonTheme &&
        other.duration == duration &&
        other.fromColor == fromColor &&
        other.toColor == toColor &&
        other.enableSwitchAnimation == enableSwitchAnimation;
  }

  @override
  int get hashCode =>
      Object.hash(duration, fromColor, toColor, enableSwitchAnimation);

  @override
  String toString() =>
      'SkeletonTheme(duration: $duration, fromColor: $fromColor, toColor: $toColor, enableSwitchAnimation: $enableSwitchAnimation)';
}

/// Configures Skeletonizer to follow the shadcn theme.
///
/// Bridges the shadcn theme system and the Skeletonizer package so skeleton
/// loading effects match the rest of the design system. Resolves values from
/// [SkeletonTheme] and falls back to defaults derived from the ambient
/// [ThemeData] — the pulse runs between the primary color at 5% and 10% alpha.
///
/// `ShadcnApp` does not install this itself; `shadcn_flutter` has no dependency
/// on Skeletonizer. Wrap the app to make [SkeletonExtension] work everywhere:
///
/// ```dart
/// ShadcnApp(
///   surfaceBuilder: (context, child) => SkeletonizerLayer(child: child),
///   home: const HomePage(),
/// );
/// ```
///
/// Use `surfaceBuilder` rather than `builder` so the configuration also covers
/// shadcn overlays — toasts, dialogs and popovers build outside `builder`.
class SkeletonizerLayer extends StatefulWidget
    implements Styleable<SkeletonTheme> {
  /// The subtree that skeleton effects apply to.
  final Widget child;

  /// Override duration for the pulse animation cycle.
  ///
  /// Type: `Duration?`. If provided, overrides theme and default duration
  /// values for this specific configuration layer.
  final Duration? duration;

  /// Override starting color for the pulse animation.
  ///
  /// Type: `Color?`. If provided, overrides theme and default color
  /// values for the lightest pulse state.
  final Color? fromColor;

  /// Override ending color for the pulse animation.
  ///
  /// Type: `Color?`. If provided, overrides theme and default color
  /// values for the darkest pulse state.
  final Color? toColor;

  /// Override switch animation behavior.
  ///
  /// Type: `bool?`. If provided, overrides theme and default animation
  /// behavior when toggling skeleton visibility.
  final bool? enableSwitchAnimation;

  /// {@macro shadcn_flutter.Styleable.theme}
  @override
  final SkeletonTheme? theme;

  /// Creates a [SkeletonizerLayer] around [child].
  ///
  /// Example:
  /// ```dart
  /// SkeletonizerLayer(
  ///   duration: const Duration(milliseconds: 1200),
  ///   child: MyContentWidget(),
  /// );
  /// ```
  const SkeletonizerLayer({
    super.key,
    required this.child,
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
    this.theme,
  });

  @override
  State<SkeletonizerLayer> createState() => _SkeletonizerLayerState();
}

class _SkeletonizerLayerState extends State<SkeletonizerLayer> {
  PulseEffect? _effect;
  EffectResolver? _effectResolver;

  /// Returns a resolver for [effect], reusing the previous one while the
  /// effect is unchanged.
  ///
  /// [SkeletonizerConfigData] compares resolvers by identity, so a fresh
  /// closure on every build would notify every skeleton below this layer.
  EffectResolver _resolverFor(PulseEffect effect) {
    if (effect != _effect) {
      _effect = effect;
      _effectResolver = (_) => effect;
    }
    return _effectResolver!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme =
        widget.theme ?? ComponentTheme.maybeOf<SkeletonTheme>(context);
    final durationValue = styleValue(
      widgetValue: widget.duration,
      themeValue: compTheme?.duration,
      defaultValue: const Duration(seconds: 1),
    );
    final fromValue = styleValue(
      widgetValue: widget.fromColor,
      themeValue: compTheme?.fromColor,
      defaultValue: theme.colorScheme.primary.scaleAlpha(0.05),
    );
    final toValue = styleValue(
      widgetValue: widget.toColor,
      themeValue: compTheme?.toColor,
      defaultValue: theme.colorScheme.primary.scaleAlpha(0.1),
    );
    final enableSwitchAnimationValue = styleValue(
      widgetValue: widget.enableSwitchAnimation,
      themeValue: compTheme?.enableSwitchAnimation,
      defaultValue: true,
    );
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effectResolver: _resolverFor(
          PulseEffect(duration: durationValue, from: fromValue, to: toValue),
        ),
        brightness: theme.brightness,
        enableSwitchAnimation: enableSwitchAnimationValue,
      ),
      child: widget.child,
    );
  }
}

/// Extension methods for adding skeleton loading effects to any widget.
///
/// SkeletonExtension provides convenient methods to transform regular widgets
/// into skeleton loading states with proper animation and theming integration.
/// These methods work with the underlying Skeletonizer package while ensuring
/// consistency with the shadcn design system.
///
/// The extension handles common use cases including content loading, image
/// placeholders, form field loading, and complex layout skeletonization.
/// Different skeleton modes (sliver, leaf, unite, replace) provide flexibility
/// for various UI patterns and performance requirements.
///
/// Methods automatically detect certain widget types (Avatar, Image) and apply
/// appropriate skeleton handling to avoid common rendering issues.
///
/// Put a [SkeletonizerLayer] above the widgets these are used on so the pulse
/// follows the shadcn theme.
extension SkeletonExtension on Widget {
  /// Converts the widget to a skeleton suitable for sliver layouts.
  ///
  /// Creates a [Skeletonizer] wrapper that works within [CustomScrollView]
  /// and other sliver-based layouts. The [ignoreContainers] parameter is
  /// set to false for consistent skeleton appearance in scroll contexts.
  ///
  /// Parameters:
  /// - [enabled] (bool, default: true): Whether skeleton effect is active
  ///
  /// Returns:
  /// A [Skeletonizer] widget configured for sliver layout compatibility.
  ///
  /// Example:
  /// ```dart
  /// ListView.builder(
  ///   itemBuilder: (context, index) => ListTile(
  ///     title: Text('Item $index'),
  ///   ).asSkeletonSliver(enabled: isLoading),
  /// );
  /// ```
  Widget asSkeletonSliver({bool enabled = true}) {
    return Skeletonizer(enabled: enabled, ignoreContainers: false, child: this);
  }

  /// Converts the widget to a skeleton with advanced configuration options.
  ///
  /// Provides comprehensive skeleton transformation with multiple modes and
  /// automatic handling of problematic widget types. Supports [AsyncSnapshot]
  /// integration for automatic skeleton state management based on data loading.
  ///
  /// Special handling:
  /// - Avatar and Image widgets use [Skeleton.leaf] to avoid rendering issues
  /// - [snapshot] parameter automatically enables/disables based on data state
  /// - Various skeleton modes (leaf, unite, replace) for different use cases
  ///
  /// Parameters:
  /// - [enabled] (bool, default: true): Whether skeleton effect is active
  /// - [leaf] (bool, default: false): Use leaf mode for simple widgets
  /// - [replacement] (Widget?, optional): Custom replacement widget in replace mode
  /// - [unite] (bool, default: false): Use unite mode for complex layouts
  /// - [snapshot] (AsyncSnapshot?, optional): Auto-enable based on data loading state
  ///
  /// Returns:
  /// A skeleton-wrapped widget with appropriate configuration for the specified mode.
  ///
  /// Example:
  /// ```dart
  /// FutureBuilder<String>(
  ///   future: loadData(),
  ///   builder: (context, snapshot) => Text(snapshot.data ?? 'Loading...').asSkeleton(
  ///     snapshot: snapshot,
  ///   ),
  /// );
  /// ```
  Widget asSkeleton({
    bool enabled = true,
    bool leaf = false,
    Widget? replacement,
    bool unite = false,
    AsyncSnapshot? snapshot,
  }) {
    if (snapshot != null) {
      enabled = !snapshot.hasData;
    }
    if (this is Avatar || this is Image) {
      // https://github.com/Milad-Akarie/skeletonizer/issues/17
      return Skeleton.leaf(enabled: enabled, child: this);
    }
    if (unite) {
      return Skeleton.unite(unite: enabled, child: this);
    }
    if (replacement != null) {
      return Skeleton.replace(replace: enabled, child: replacement);
    }
    if (leaf) {
      return Skeleton.leaf(enabled: enabled, child: this);
    }
    return Skeletonizer(enabled: enabled, child: this);
  }

  /// Excludes the widget from skeleton effects in its parent skeleton context.
  ///
  /// Wraps the widget with [Skeleton.ignore] to prevent skeleton transformation
  /// even when placed within a skeleton-enabled parent. Useful for preserving
  /// interactive elements or dynamic content within skeleton layouts.
  ///
  /// Returns:
  /// A [Skeleton.ignore] wrapper that prevents skeleton effects on this widget.
  ///
  /// Example:
  /// ```dart
  /// Column(children: [
  ///   Text('Loading content...'),
  ///   Button(
  ///     onPressed: () {},
  ///     child: Text('Cancel'),
  ///   ).ignoreSkeleton(), // Button remains interactive
  /// ]).asSkeleton();
  /// ```
  Widget ignoreSkeleton() {
    return Skeleton.ignore(child: this);
  }

  /// Controls whether the widget should be preserved in skeleton mode.
  ///
  /// Wraps the widget with [Skeleton.keep] to conditionally preserve the
  /// original widget appearance when skeleton effects are active. When [exclude]
  /// is true, the widget maintains its normal appearance instead of being skeletonized.
  ///
  /// Parameters:
  /// - [exclude] (bool, default: true): Whether to exclude from skeleton effects
  ///
  /// Returns:
  /// A [Skeleton.keep] wrapper that conditionally preserves the widget's appearance.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [
  ///   Text('Data: $value'),
  ///   Icon(LucideIcons.star).excludeSkeleton(exclude: isImportant),
  /// ]).asSkeleton();
  /// ```
  Widget excludeSkeleton({bool exclude = true}) {
    return Skeleton.keep(keep: exclude, child: this);
  }
}
