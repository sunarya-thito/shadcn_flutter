import '../../../shadcn_flutter.dart';

/// Extension on [Widget] providing convenient icon theme utilities.
///
/// Provides methods to wrap icons with predefined size and color themes,
/// making it easy to apply consistent styling to icon widgets throughout
/// an application.
extension IconExtension on Widget {
  /// Wraps the icon with extra-extra-extra-extra small size theme.
  WrappedIcon get iconX4Small {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x4Small, child: this);
  }

  /// Wraps the icon with extra-extra-extra small size theme.
  WrappedIcon get iconX3Small {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x3Small, child: this);
  }

  /// Wraps the icon with extra-extra small size theme.
  WrappedIcon get iconX2Small {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x2Small, child: this);
  }

  /// Wraps the icon with extra small size theme.
  WrappedIcon get iconXSmall {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.xSmall, child: this);
  }

  /// Wraps the icon with small size theme.
  WrappedIcon get iconSmall {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.small, child: this);
  }

  /// Wraps the icon with medium size theme.
  WrappedIcon get iconMedium {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.medium, child: this);
  }

  /// Wraps the icon with large size theme.
  WrappedIcon get iconLarge {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.large, child: this);
  }

  /// Wraps the icon with extra large size theme.
  WrappedIcon get iconXLarge {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.xLarge, child: this);
  }

  /// Wraps the icon with extra-extra large size theme.
  WrappedIcon get iconX2Large {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x2Large, child: this);
  }

  /// Wraps the icon with extra-extra-extra large size theme.
  WrappedIcon get iconX3Large {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x3Large, child: this);
  }

  /// Wraps the icon with extra-extra-extra-extra large size theme.
  WrappedIcon get iconX4Large {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x4Large, child: this);
  }

  /// Wraps the icon with muted foreground color.
  ///
  /// Applies a subdued color suitable for secondary or less prominent icons.
  WrappedIcon get iconMutedForeground {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.mutedForeground),
        child: this);
  }

  /// Wraps the icon with destructive foreground color.
  ///
  /// Deprecated: Use alternative color scheme methods instead.
  @Deprecated('Legacy color')
  WrappedIcon get iconDestructiveForeground {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.destructiveForeground),
        child: this);
  }

  /// Wraps the icon with primary foreground color.
  ///
  /// Typically used for icons on primary-colored backgrounds.
  WrappedIcon get iconPrimaryForeground {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.primaryForeground),
        child: this);
  }

  /// Wraps the icon with primary color.
  ///
  /// Applies the theme's primary accent color to the icon.
  WrappedIcon get iconPrimary {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.primary),
        child: this);
  }

  /// Wraps the icon with secondary color.
  ///
  /// Applies the theme's secondary accent color to the icon.
  WrappedIcon get iconSecondary {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.secondary),
        child: this);
  }

  /// Wraps the icon with secondary foreground color.
  ///
  /// Typically used for icons on secondary-colored backgrounds.
  WrappedIcon get iconSecondaryForeground {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.secondaryForeground),
        child: this);
  }
}

/// Builder function for creating icon theme data.
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [theme] (`ThemeData`): Current theme data.
///
/// Returns: `T` — typically [IconThemeData].
typedef WrappedIconDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);

/// A widget that wraps an icon with custom theme data.
///
/// Applies icon theme styling to a child icon widget using a builder
/// function that can access the current context and theme. Useful for
/// applying dynamic icon styles based on theme values.
///
/// Example:
/// ```dart
/// WrappedIcon(
///   data: (context, theme) => IconThemeData(
///     size: 24,
///     color: theme.colorScheme.primary,
///   ),
///   child: Icon(Icons.star),
/// )
/// ```
class WrappedIcon extends StatelessWidget {
  /// Builder function that creates the icon theme data.
  final WrappedIconDataBuilder<IconThemeData> data;

  /// The child icon widget to apply the theme to.
  final Widget child;

  /// Creates a [WrappedIcon].
  ///
  /// Parameters:
  /// - [data] (`WrappedIconDataBuilder<IconThemeData>`, required): Theme builder.
  /// - [child] (`Widget`, required): Icon widget to wrap.
  const WrappedIcon({
    super.key,
    required this.data,
    required this.child,
  });

  /// Returns this widget (callable syntax support).
  ///
  /// Allows using the wrapped icon as a callable function.
  Widget call() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = data(context, theme);
    return IconTheme.merge(
      data: iconTheme,
      child: child,
    );
  }

  /// Creates a copy of this wrapped icon with modified icon theme data.
  ///
  /// Parameters:
  /// - [data] (`WrappedIconDataBuilder<IconThemeData>?`, optional): New icon theme data builder.
  ///
  /// Returns: A new [WrappedIcon] with merged theme data.
  WrappedIcon copyWith({
    WrappedIconDataBuilder<IconThemeData>? data,
  }) {
    return WrappedIcon(
      data: (context, theme) {
        return data?.call(context, theme).merge(this.data(context, theme)) ??
            this.data(context, theme);
      },
      child: child,
    );
  }
}
