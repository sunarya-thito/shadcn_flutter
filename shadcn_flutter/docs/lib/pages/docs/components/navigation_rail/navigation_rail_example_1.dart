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

  Widget buildButton(int i, String label, IconData icon) {
    return NavigationButton(
      style: customButtonStyle
          ? const ButtonStyle.muted(density: ButtonDensity.icon)
          : null,
      selectedStyle: customButtonStyle
          ? const ButtonStyle.fixed(density: ButtonDensity.icon)
          : null,
      onChanged: (value) {
        setState(() {
          selected = i;
        });
      },
      label: Text(label),
      selected: selected == i,
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
            children: [
              buildButton(0, 'Home', BootstrapIcons.house),
              buildButton(1, 'Explore', BootstrapIcons.compass),
              buildButton(2, 'Library', BootstrapIcons.musicNoteList),
              NavigationDivider(),
              NavigationLabel(child: Text('Settings')),
              buildButton(3, 'Profile', BootstrapIcons.person),
              buildButton(4, 'App', BootstrapIcons.appIndicator),
              NavigationDivider(),
              NavigationGap(12),
              FlutterLogo(),
            ],
          ),
          const VerticalDivider(),
          Expanded(
            child: Container(
              color: Colors.primaries[Colors.primaries.length - selected - 1],
              padding: EdgeInsets.all(24),
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
                      popupConstraints:
                          BoxConstraints.tight(const Size(200, 200)),
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
                      trailing: Text('Custom Button Style'),
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
