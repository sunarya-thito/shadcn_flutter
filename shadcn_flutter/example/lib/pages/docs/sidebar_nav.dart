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
        Gap(4),
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
          mutedForeground: data.colorScheme.secondaryForeground,
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
          textStyle: (context, states, value) {
            return value.copyWith(
              fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
            );
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
  final Widget? trailing;

  const NavigationButton({
    Key? key,
    this.trailing,
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
        trailing: trailing,
        trailingExpanded: true,
        style: ButtonVariance.link.copyWith(
          padding: (context, states, value) {
            return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
          },
          textStyle: (context, states, value) {
            return value.copyWith(
              fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
            );
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
          children: join(children, Gap(16)).toList(),
        ),
      ),
    );
  }
}
