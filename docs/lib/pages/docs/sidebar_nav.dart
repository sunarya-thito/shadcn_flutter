import 'package:shadcn_flutter/shadcn_flutter.dart';

class SidebarSection extends StatelessWidget {
  final Widget header;
  final List<Widget> children;

  const SidebarSection({
    super.key,
    required this.header,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header.small().semiBold().withPadding(vertical: 4, horizontal: 8),
        const Gap(4),
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
    super.key,
    required this.child,
    required this.onPressed,
    required this.selected,
  });

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
        alignment: AlignmentDirectional.centerStart,
        style: ButtonVariance.text.copyWith(
          padding: (context, states, value) {
            return const EdgeInsets.symmetric(vertical: 4, horizontal: 8) *
                data.scaling;
          },
          textStyle: (context, states, value) {
            return value.copyWith(
              fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
            );
          },
        ),
        child: child.small(),
      ),
    );
  }
}

class DocsNavigationButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool selected;
  final Widget? trailing;

  const DocsNavigationButton({
    super.key,
    this.trailing,
    required this.child,
    required this.onPressed,
    required this.selected,
  });

  @override
  State<DocsNavigationButton> createState() => _DocsNavigationButtonState();
}

class _DocsNavigationButtonState extends State<DocsNavigationButton> {
  EdgeInsetsGeometry _padding(
      BuildContext context, Set<WidgetState> states, EdgeInsetsGeometry value) {
    return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  }

  TextStyle _textStyle(
      BuildContext context, Set<WidgetState> states, TextStyle value) {
    return value.copyWith(
      fontWeight: widget.selected ? FontWeight.w500 : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = Theme.of(context);
    if (!widget.selected) {
      data = data.copyWith(
        colorScheme: data.colorScheme.copyWith(
          foreground: data.colorScheme.mutedForeground,
        ),
      );
    }
    return Theme(
      data: data,
      child: Button(
        onPressed: widget.onPressed,
        alignment: AlignmentDirectional.centerStart,
        style: ButtonVariance.link.copyWith(
          padding: _padding,
          textStyle: _textStyle,
        ),
        child: Row(
          children: [
            widget.child.small(),
            if (widget.trailing != null) const Gap(8),
            if (widget.trailing != null) widget.trailing!,
          ],
        ),
      ),
    );
  }
}

class SidebarNav extends StatefulWidget {
  final List<Widget> children;

  const SidebarNav({super.key, required this.children});

  @override
  State<SidebarNav> createState() => _SidebarNavState();
}

class _SidebarNavState extends State<SidebarNav> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = join(widget.children, const Gap(16)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
  }
}
