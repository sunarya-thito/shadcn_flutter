import '../../../shadcn_flutter.dart';

const kLayoutTitle = #appBarTitle;
const kLayoutHeader = #appBarHeader;
const kLayoutFooter = #appBarFooter;
const kLayoutLeading = #appBarLeading;
const kLayoutActions = #appBarTrailing;
const kLayoutBackground = #appBarBackground;

abstract class SliverAppBarLayout extends MultiChildLayoutDelegate {
  void resolve(BuildContext context);
}

const double kToolbarHeight = 56.0;
const kAppBarFooterHeight = 24.0;
const kAppBarHeaderHeight = 24.0;

abstract class AppBarChild {
  const AppBarChild();
}

class AppBarComponentChild extends AppBarChild {}

double _getDefaultCollapsedHeight(bool hasHeader, bool hasFooter) {
  switch ((hasHeader, hasFooter)) {
    case (true, true):
      return kToolbarHeight + kAppBarHeaderHeight + kAppBarFooterHeight;
    case (true, false):
      return kToolbarHeight + kAppBarHeaderHeight;
    case (false, true):
      return kToolbarHeight + kAppBarFooterHeight;
    default:
      return kToolbarHeight;
  }
}

class SliverAppBar extends StatelessWidget {
  final SliverAppBarLayout collapsedLayout;
  final SliverAppBarLayout? expandedLayout;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? header;
  final Widget? footer;
  final Widget? background;
  final double? expandedHeight;
  final double? collapsedHeight;

  const SliverAppBar({
    Key? key,
    required this.collapsedLayout,
    this.expandedLayout,
    this.title,
    this.leading,
    this.trailing,
    this.header,
    this.footer,
    this.background,
    this.expandedHeight,
    this.collapsedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverAppBarHeaderDelegate(this),
    );
  }
}

class SliverAppBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final SliverAppBarLayout collapsedLayout;
  final SliverAppBarLayout? expandedLayout;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? header;
  final Widget? footer;
  final Widget? background;
  final double? expandedHeight;
  final double? collapsedHeight;

  SliverAppBarHeaderDelegate(SliverAppBar appBar)
      : collapsedLayout = appBar.collapsedLayout,
        expandedLayout = appBar.expandedLayout,
        title = appBar.title,
        leading = appBar.leading,
        trailing = appBar.trailing,
        header = appBar.header,
        footer = appBar.footer,
        background = appBar.background,
        expandedHeight = appBar.expandedHeight,
        collapsedHeight = appBar.collapsedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (expandedLayout == null) {
      collapsedLayout.resolve(context);
      return CustomMultiChildLayout(delegate: collapsedLayout);
    }
    collapsedLayout.resolve(context);
    expandedLayout!.resolve(context);
    double progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return CrossFadeLayout(
      from: collapsedLayout,
      to: expandedLayout!,
      progress: progress,
    );
  }

  @override
  double get maxExtent {
    return expandedHeight ?? minExtent;
  }

  @override
  double get minExtent {
    return collapsedHeight ??
        _getDefaultCollapsedHeight(header != null, footer != null);
  }

  @override
  bool shouldRebuild(covariant SliverAppBarHeaderDelegate oldDelegate) {
    return collapsedLayout != oldDelegate.collapsedLayout ||
        expandedLayout != oldDelegate.expandedLayout ||
        title != oldDelegate.title ||
        leading != oldDelegate.leading ||
        trailing != oldDelegate.trailing ||
        header != oldDelegate.header ||
        footer != oldDelegate.footer ||
        background != oldDelegate.background ||
        expandedHeight != oldDelegate.expandedHeight ||
        collapsedHeight != oldDelegate.collapsedHeight;
  }
}

class CollapsedAppBarLayout extends SliverAppBarLayout {
  final AlignmentGeometry titleAlignment;

  CollapsedAppBarLayout({this.titleAlignment = Alignment.center});

  late Alignment _resolvedTitleAlignment;

  @override
  void resolve(BuildContext context) {
    _resolvedTitleAlignment =
        titleAlignment.resolve(Directionality.of(context));
  }

  @override
  void performLayout(Size size) {}

  @override
  bool shouldRelayout(covariant CollapsedAppBarLayout oldDelegate) {
    return titleAlignment != oldDelegate.titleAlignment;
  }
}
