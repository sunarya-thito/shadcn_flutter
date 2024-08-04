import '../../../shadcn_flutter.dart';

extension IconExtension on Widget {
  Widget iconXSmall() {
    return WrappedIcon(data: (context, theme) => theme.iconTheme.xSmall);
  }

  Widget iconSmall() {
    return WrappedIcon(data: (context, theme) => theme.iconTheme.small);
  }

  Widget iconMedium() {
    return WrappedIcon(data: (context, theme) => theme.iconTheme.medium);
  }

  Widget iconLarge() {
    return WrappedIcon(data: (context, theme) => theme.iconTheme.large);
  }

  Widget iconXLarge() {
    return WrappedIcon(data: (context, theme) => theme.iconTheme.xLarge);
  }

  Widget iconMuted() {
    return WrappedIcon(
        data: (context, theme) =>
            IconThemeData(color: theme.colorScheme.mutedForeground));
  }
}

typedef WrappedIconDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);

class WrappedIcon extends StatelessWidget {
  final WrappedIconDataBuilder<IconThemeData> data;

  const WrappedIcon({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = data(context, theme);
    return AnimatedIconTheme.merge(
      data: iconTheme,
      child: const Icon(Icons.ac_unit),
      duration: kDefaultDuration,
    );
  }

  WrappedIcon copyWith({
    WrappedIconDataBuilder<IconThemeData>? data,
  }) {
    return WrappedIcon(
      data: data ?? this.data,
    );
  }
}
