import '../../../shadcn_flutter.dart';

extension IconExtension on Widget {
  Widget iconX4Small() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x4Small, child: this);
  }

  Widget iconX3Small() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x3Small, child: this);
  }

  Widget iconX2Small() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x2Small, child: this);
  }

  Widget iconXSmall() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.xSmall, child: this);
  }

  Widget iconSmall() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.small, child: this);
  }

  Widget iconMedium() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.medium, child: this);
  }

  Widget iconLarge() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.large, child: this);
  }

  Widget iconXLarge() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.xLarge, child: this);
  }

  Widget iconX2Large() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x2Large, child: this);
  }

  Widget iconX3Large() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x3Large, child: this);
  }

  Widget iconX4Large() {
    return WrappedIcon(
        data: (context, theme) => theme.iconTheme.x4Large, child: this);
  }

  Widget iconMutedForeground() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.mutedForeground),
        child: this);
  }

  Widget iconDestructiveForeground() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.destructiveForeground),
        child: this);
  }

  Widget iconPrimaryForeground() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.primaryForeground),
        child: this);
  }

  Widget iconPrimary() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.primary),
        child: this);
  }

  Widget iconSecondary() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.secondary),
        child: this);
  }

  Widget iconSecondaryForeground() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.secondaryForeground),
        child: this);
  }
}

typedef WrappedIconDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);

class WrappedIcon extends StatelessWidget {
  final WrappedIconDataBuilder<IconThemeData> data;
  final Widget child;

  const WrappedIcon({
    super.key,
    required this.data,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = data(context, theme);
    return IconTheme.merge(
      data: iconTheme,
      child: child,
    );
  }

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
