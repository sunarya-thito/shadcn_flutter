import 'package:shadcn_flutter/shadcn_flutter.dart';

class WebLayout extends StatelessWidget {
  static const double defaultSidebarWidth = 240;
  static const double defaultMinBodyWidth = 600;
  final Widget? header;
  final Widget? footer;
  final Widget body;
  final Widget? sidebar;
  final Widget? secondarySidebar;
  final double sidebarWidth;
  final double minBodyWidth;

  const WebLayout({
    Key? key,
    required this.header,
    required this.footer,
    required this.body,
    required this.sidebar,
    required this.secondarySidebar,
    this.sidebarWidth =
        defaultSidebarWidth, // applies to both sidebars, main sidebar can be hidden to drawer if body width is less than minBodyWidth
    this.minBodyWidth = defaultMinBodyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StageContainer(
      builder: (context, padding) {
        return LayoutBuilder(builder: (context, constraints) {
          EdgeInsets bodyPadding = padding;
          bool showSidebar = false;
          bool showSecondarySidebar = false;
          if (sidebar != null) {
            double contentWidth =
                constraints.maxWidth - sidebarWidth - bodyPadding.horizontal;
            if (contentWidth >= minBodyWidth) {
              // still enough space for sidebar
              bodyPadding += EdgeInsets.only(left: sidebarWidth);
              showSidebar = true;
            }
          }
          if (secondarySidebar != null) {
            double contentWidth =
                constraints.maxWidth - sidebarWidth - bodyPadding.horizontal;
            if (contentWidth >= minBodyWidth) {
              // still enough space for sidebar
              bodyPadding += EdgeInsets.only(right: sidebarWidth);
              showSecondarySidebar = true;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (header != null) header!,
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: bodyPadding,
                              child: body,
                            ),
                            if (footer != null) footer!,
                          ],
                        ),
                      ),
                    ),
                    if (showSidebar)
                      Positioned(
                        top: 0,
                        height: constraints.maxHeight,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: padding.left),
                          child: sidebar!,
                        ),
                      ),
                    if (showSecondarySidebar)
                      Positioned(
                        top: 0,
                        height: constraints.maxHeight,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.only(right: padding.right),
                          child: secondarySidebar!,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
