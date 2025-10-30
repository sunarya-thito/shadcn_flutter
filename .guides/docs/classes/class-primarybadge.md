---
title: "Class: PrimaryBadge"
description: "A primary style badge widget for highlighting important information or status."
---

```dart
/// A primary style badge widget for highlighting important information or status.
///
/// [PrimaryBadge] displays content in a prominent badge format using the primary
/// color scheme. It's designed for high-importance status indicators, labels,
/// and interactive elements that need to draw attention. The badge supports
/// leading and trailing widgets for icons or additional content.
///
/// Key features:
/// - Primary color styling with emphasis and contrast
/// - Optional tap handling for interactive badges
/// - Support for leading and trailing widgets (icons, counters, etc.)
/// - Customizable button styling through theme integration
/// - Compact size optimized for badge display
/// - Consistent visual hierarchy with other badge variants
///
/// The badge uses button-like styling but in a compact form factor suitable
/// for status displays, labels, and small interactive elements. It integrates
/// with the theme system to maintain visual consistency.
///
/// Common use cases:
/// - Status indicators (active, new, featured)
/// - Notification counts and alerts
/// - Category labels and tags
/// - Interactive filter chips
/// - Achievement or ranking displays
///
/// Example:
/// ```dart
/// PrimaryBadge(
///   child: Text('NEW'),
///   leading: Icon(Icons.star, size: 16),
///   onPressed: () => _showNewItems(),
/// );
/// 
/// // Non-interactive status badge
/// PrimaryBadge(
///   child: Text('5'),
///   trailing: Icon(Icons.notifications, size: 14),
/// );
/// ```
class PrimaryBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;
  /// Optional callback when the badge is pressed, making it interactive.
  ///
  /// If `null`, the badge is non-interactive.
  final VoidCallback? onPressed;
  /// Optional widget displayed before the child content.
  final Widget? leading;
  /// Optional widget displayed after the child content.
  final Widget? trailing;
  /// Optional custom style override for the badge.
  ///
  /// If `null`, uses theme's primary badge style or default primary styling.
  final AbstractButtonStyle? style;
  /// Creates a primary badge.
  const PrimaryBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});
  Widget build(BuildContext context);
}
```
