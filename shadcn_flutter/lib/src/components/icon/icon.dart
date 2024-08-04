import '../../../shadcn_flutter.dart';

extension IconExtension on Widget {
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

  Widget iconMuted() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.mutedForeground),
        child: this);
  }

  Widget iconDestructive() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.destructiveForeground),
        child: this);
  }
}

typedef WrappedIconDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);

class WrappedIcon extends StatelessWidget {
  final WrappedIconDataBuilder<IconThemeData> data;
  final Widget child;

  const WrappedIcon({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = data(context, theme);
    return AnimatedIconTheme.merge(
      data: iconTheme,
      child: child,
      duration: kDefaultDuration,
    );
  }

  WrappedIcon copyWith({
    WrappedIconDataBuilder<IconThemeData>? data,
  }) {
    return WrappedIcon(
      data: data ?? this.data,
      child: child,
    );
  }
}
