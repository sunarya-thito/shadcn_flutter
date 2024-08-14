import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationBarExample1 extends StatefulWidget {
  @override
  State<NavigationBarExample1> createState() => _NavigationBarExample1State();
}

class _NavigationBarExample1State extends State<NavigationBarExample1> {
  int selected = 0;

  NavigationBarAlignment alignment = NavigationBarAlignment.spaceAround;
  bool expands = true;
  NavigationLabelType labelType = NavigationLabelType.none;
  bool customButtonStyle = true;

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
    return OutlinedContainer(
      width: 500,
      height: 400,
      child: Scaffold(
        footers: [
          const Divider(),
          NavigationBar(
            alignment: alignment,
            labelType: labelType,
            expands: expands,
            children: [
              buildButton(0, 'Home', BootstrapIcons.house),
              buildButton(1, 'Explore', BootstrapIcons.compass),
              buildButton(2, 'Library', BootstrapIcons.musicNoteList),
              buildButton(3, 'Profile', BootstrapIcons.person),
              buildButton(4, 'App', BootstrapIcons.appIndicator),
            ],
          ),
        ],
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
                Select<NavigationBarAlignment>(
                  value: alignment,
                  itemBuilder:
                      (BuildContext context, NavigationBarAlignment item) {
                    return Text(item.name);
                  },
                  popupConstraints: BoxConstraints.tight(const Size(200, 200)),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        alignment = value;
                      });
                    }
                  },
                  children: [
                    for (var value in NavigationBarAlignment.values)
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
                  popupConstraints: BoxConstraints.tight(const Size(200, 200)),
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
                  state:
                      expands ? CheckboxState.checked : CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      expands = value == CheckboxState.checked;
                    });
                  },
                  trailing: Text('Expands'),
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
    );
  }
}
