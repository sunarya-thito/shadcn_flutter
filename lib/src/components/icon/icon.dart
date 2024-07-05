import '../../../shadcn_flutter.dart';

extension IconExtension on Widget {
  Widget iconXSmall() {
    return AnimatedIconTheme.merge(
      data: const IconThemeData(size: 12),
      child: this,
      duration: kDefaultDuration,
    );
  }

  Widget iconSmall() {
    return AnimatedIconTheme.merge(
      data: const IconThemeData(size: 16),
      child: this,
      duration: kDefaultDuration,
    );
  }

  Widget iconMedium() {
    return AnimatedIconTheme.merge(
      data: const IconThemeData(size: 20),
      child: this,
      duration: kDefaultDuration,
    );
  }

  Widget iconLarge() {
    return AnimatedIconTheme.merge(
      data: const IconThemeData(size: 24),
      child: this,
      duration: kDefaultDuration,
    );
  }

  Widget iconXLarge() {
    return AnimatedIconTheme.merge(
      data: const IconThemeData(size: 32),
      child: this,
      duration: kDefaultDuration,
    );
  }

  Widget iconMuted() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return IconTheme(
          data: IconThemeData(color: theme.colorScheme.mutedForeground),
          child: this,
        );
      },
    );
  }
}
