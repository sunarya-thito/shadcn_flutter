import '../../../shadcn_flutter.dart';

/// Theme configuration for [Alert] components.
///
/// Provides visual styling properties for alert components including padding,
/// background color, and border color. These properties can be overridden at
/// the widget level or applied globally via [ComponentTheme].
///
/// The theme integrates with the overall design system by using appropriate
/// color schemes and scaling factors from [ThemeData].
class AlertTheme {
  /// The internal padding around the alert content.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses default padding based on scaling.
  /// Controls the spacing between the alert border and its content elements.
  final EdgeInsetsGeometry? padding;

  /// The background color of the alert container.
  ///
  /// Type: `Color?`. If null, uses [ColorScheme.card] from the current theme.
  /// Applied to the [OutlinedContainer] that wraps the alert content.
  final Color? backgroundColor;

  /// The border color of the alert outline.
  ///
  /// Type: `Color?`. If null, uses the default border color from [OutlinedContainer].
  /// Defines the visual boundary around the alert.
  final Color? borderColor;

  /// Creates an [AlertTheme].
  ///
  /// All parameters are optional and can be null to use default values.
  ///
  /// Example:
  /// ```dart
  /// const AlertTheme(
  ///   padding: EdgeInsets.all(16.0),
  ///   backgroundColor: Colors.blue,
  ///   borderColor: Colors.blueAccent,
  /// );
  /// ```
  const AlertTheme({this.padding, this.backgroundColor, this.borderColor});

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional replacement of values.
  /// If a getter function is null, the original value is preserved.
  ///
  /// Returns:
  /// A new [AlertTheme] instance with updated values.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = theme.copyWith(
  ///   backgroundColor: () => Colors.red,
  /// );
  /// ```
  AlertTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
  }) {
    return AlertTheme(
      padding: padding == null ? this.padding : padding(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AlertTheme &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hash(padding, backgroundColor, borderColor);
}

/// A versatile alert component for displaying important messages or notifications.
///
/// The Alert widget provides a flexible layout for presenting information to users
/// with optional leading icons, title text, content description, and trailing actions.
/// Supports both normal and destructive styling modes for different message types.
///
/// The component uses a [Basic] layout internally and wraps content in an
/// [OutlinedContainer] for consistent visual presentation. Text and icon colors
/// automatically adapt based on the destructive mode and current theme.
///
/// Key features:
/// - Flexible content layout with optional elements
/// - Destructive styling for error/warning messages
/// - Theme integration with customizable styling
/// - Responsive scaling based on theme configuration
/// - Automatic color adaptation for text and icons
///
/// Example:
/// ```dart
/// Alert(
///   leading: Icon(Icons.info),
///   title: Text('Information'),
///   content: Text('This is an informational alert message.'),
///   trailing: IconButton(
///     icon: Icon(Icons.close),
///     onPressed: () {},
///   ),
/// );
/// ```
class Alert extends StatelessWidget {
  /// Optional leading widget, typically an icon.
  ///
  /// Type: `Widget?`. Displayed at the start of the alert layout.
  /// In destructive mode, inherits the destructive color from the theme.
  final Widget? leading;

  /// Optional title widget for the alert header.
  ///
  /// Type: `Widget?`. Usually contains the main alert message or heading.
  /// Positioned after the leading widget in the layout flow.
  final Widget? title;

  /// Optional content widget for detailed alert information.
  ///
  /// Type: `Widget?`. Provides additional context or description below the title.
  /// Can contain longer text or complex content layouts.
  final Widget? content;

  /// Optional trailing widget, typically for actions or dismissal.
  ///
  /// Type: `Widget?`. Displayed at the end of the alert layout.
  /// Common use cases include close buttons or action controls.
  final Widget? trailing;

  /// Whether to apply destructive styling to the alert.
  ///
  /// Type: `bool`, default: `false`. When true, applies destructive color
  /// scheme to text and icons for error or warning messages.
  final bool destructive;

  /// Creates an [Alert] with standard styling.
  ///
  /// All content parameters are optional, allowing for flexible layouts
  /// from simple text alerts to complex multi-element notifications.
  ///
  /// Parameters:
  /// - [leading] (Widget?, optional): Icon or widget at the start
  /// - [title] (Widget?, optional): Main heading or message
  /// - [content] (Widget?, optional): Detailed description or body
  /// - [trailing] (Widget?, optional): Action buttons or dismissal controls
  /// - [destructive] (bool, default: false): Whether to use destructive styling
  ///
  /// Example:
  /// ```dart
  /// Alert(
  ///   title: Text('Success'),
  ///   content: Text('Operation completed successfully.'),
  /// );
  /// ```
  const Alert(
      {super.key,
      this.leading,
      this.title,
      this.content,
      this.trailing,
      this.destructive = false});

  /// Creates an [Alert] with destructive styling pre-configured.
  ///
  /// This is a convenience constructor that sets [destructive] to true,
  /// applying error/warning colors to text and icons automatically.
  ///
  /// Parameters:
  /// - [leading] (Widget?, optional): Icon or widget at the start
  /// - [title] (Widget?, optional): Main heading or message
  /// - [content] (Widget?, optional): Detailed description or body
  /// - [trailing] (Widget?, optional): Action buttons or dismissal controls
  ///
  /// Example:
  /// ```dart
  /// Alert.destructive(
  ///   leading: Icon(Icons.error),
  ///   title: Text('Error'),
  ///   content: Text('Something went wrong. Please try again.'),
  /// );
  /// ```
  const Alert.destructive({
    super.key,
    this.leading,
    this.title,
    this.content,
    this.trailing,
  }) : destructive = true;

  @override
  Widget build(BuildContext context) {
    if (destructive) {
      var destructive2 = Theme.of(context).colorScheme.destructive;
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: destructive2,
        ),
        child: IconTheme.merge(
          data: IconThemeData(
            color: destructive2,
          ),
          child: _build(context),
        ),
      );
    }
    return _build(context);
  }

  Widget _build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AlertTheme>(context);
    final scaling = theme.scaling;
    var scheme = theme.colorScheme;
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(
          horizontal: 16 * scaling, vertical: 12 * scaling),
    );
    final backgroundColor = styleValue(
      themeValue: compTheme?.backgroundColor,
      defaultValue: scheme.card,
    );

    return OutlinedContainer(
      backgroundColor: backgroundColor,
      child: Container(
        padding: padding,
        child: Basic(
          leading: leading,
          title: title,
          content: content,
          trailing: trailing,
        ),
      ),
    );
  }
}
