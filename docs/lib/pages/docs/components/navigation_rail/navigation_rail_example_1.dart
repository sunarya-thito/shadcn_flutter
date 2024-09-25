import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationRailExample1 extends StatefulWidget {
  const NavigationRailExample1({super.key});

  @override
  State<NavigationRailExample1> createState() => _NavigationRailExample1State();
}

class _NavigationRailExample1State extends State<NavigationRailExample1> {
  int selected = 0;

  NavigationRailAlignment alignment = NavigationRailAlignment.start;
  NavigationLabelType labelType = NavigationLabelType.none;
  bool customButtonStyle = false;

  NavigationButton buildButton(String label, IconData icon) {
    return NavigationButton(
      style: customButtonStyle
          ? const ButtonStyle.muted(density: ButtonDensity.icon)
          : null,
      selectedStyle: customButtonStyle
          ? const ButtonStyle.fixed(density: ButtonDensity.icon)
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            alignment: alignment,
            labelType: labelType,
            index: selected,
            onSelected: (index) {
              setState(() {
                selected = index;
              });
            },
            children: [
              buildButton('Home', BootstrapIcons.house),
              buildButton('Explore', BootstrapIcons.compass),
              buildButton('Library', BootstrapIcons.musicNoteList),
              const NavigationDivider(),
              const NavigationLabel(child: Text('Settings')),
              buildButton('Profile', BootstrapIcons.person),
              buildButton('App', BootstrapIcons.appIndicator),
              const NavigationDivider(),
              const NavigationGap(12),
              const NavigationWidget(
                child: FlutterLogo(),
              ),
            ],
          ),
          const VerticalDivider(),
          Expanded(
            child: Container(
              color: Colors.primaries[Colors.primaries.length - selected - 1],
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    Select<NavigationRailAlignment>(
                      value: alignment,
                      itemBuilder:
                          (BuildContext context, NavigationRailAlignment item) {
                        return Text(item.name);
                      },
                      popupWidthConstraint: PopoverConstraint.anchorFixedSize,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            alignment = value;
                          });
                        }
                      },
                      children: [
                        for (var value in NavigationRailAlignment.values)
                          SelectItemButton(
                            value: value,
                            child: Text(value.name),
                          ),
                      ],
                    ),
                    Select<NavigationLabelType>(
                      value: labelType,
                      itemBuilder:
                          (BuildContext context, NavigationLabelType item) {
                        return Text(item.name);
                      },
                      popupConstraints:
                          BoxConstraints.tight(const Size(200, 200)),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            labelType = value;
                          });
                        }
                      },
                      children: [
                        for (var value in NavigationLabelType.values)
                          // expanded is used for the navigation sidebar
                          if (value != NavigationLabelType.expanded)
                            SelectItemButton(
                              value: value,
                              child: Text(value.name),
                            ),
                      ],
                    ),
                    Checkbox(
                      state: customButtonStyle
                          ? CheckboxState.checked
                          : CheckboxState.unchecked,
                      onChanged: (value) {
                        setState(() {
                          customButtonStyle = value == CheckboxState.checked;
                        });
                      },
                      trailing: const Text('Custom Button Style'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
