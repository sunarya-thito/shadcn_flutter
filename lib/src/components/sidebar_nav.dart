import 'package:shadcn_flutter/shadcn_flutter.dart';

class SidebarSection extends StatelessWidget {
  final Widget header;
  final List<Widget> children;

  const SidebarSection({
    Key? key,
    required this.header,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header.small().semiBold().withPadding(vertical: 4, horizontal: 8),
        gap(4),
        ...children,
      ],
    );
  }
}

class SidebarButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool selected;

  const SidebarButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Theme.of(context);
    if (selected) {
      data = data.copyWith(
        colorScheme: data.colorScheme.copyWith(
          mutedForeground: data.colorScheme.primary,
        ),
      );
    }
    return Theme(
      data: data,
      child: Button(
        onPressed: onPressed,
        alignment: Alignment.centerLeft,
        style: ButtonVariance.text.copyWith(
          padding: (context, states, value) {
            return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
          },
        ),
        child: child,
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool selected;

  const NavigationButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Theme.of(context);
    if (!selected) {
      data = data.copyWith(
        colorScheme: data.colorScheme.copyWith(
          foreground: data.colorScheme.mutedForeground,
        ),
      );
    }
    return Theme(
      data: data,
      child: Button(
        onPressed: onPressed,
        alignment: Alignment.centerLeft,
        style: ButtonVariance.link.copyWith(
          padding: (context, states, value) {
            return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
          },
        ),
        child: child,
      ),
    );
  }
}

class SidebarNav extends StatelessWidget {
  final List<Widget> children;

  const SidebarNav({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: join(children, gap(16)).toList(),
        ),
      ),
    );
  }
}
