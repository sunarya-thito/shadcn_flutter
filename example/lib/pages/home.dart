import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Home extends StatefulWidget {
  final void Function(ColorScheme colorScheme) onColorSchemeChanged;
  final ColorScheme colorScheme;
  final double radius;
  final void Function(double radius) onRadiusChanged;
  // const Home({Key? key}) : super(key: key);

  const Home({
    Key? key,
    required this.onColorSchemeChanged,
    required this.colorScheme,
    required this.radius,
    required this.onRadiusChanged,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CheckboxState _checked = CheckboxState.unchecked;
  CheckboxState _checked2 = CheckboxState.checked;
  SliderValue _sliderValue = SliderValue.single(50);
  SliderValue _sliderValue2 = SliderValue.ranged(0.25, 0.75);

  Widget buildColorSchemeButton(String name, ColorScheme scheme) {
    return Button(
      child: Basic(
        leading: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: scheme.secondary,
              width: 1,
            ),
          ),
        ),
        title: Text(name),
      ),
      onPressed: () {
        widget.onColorSchemeChanged(scheme);
      },
    );
  }

  final Map<String, ColorScheme> availableColorSchemes = {
    'Light Zync': ColorSchemes.lightZync(),
    'Dark Zync': ColorSchemes.darkZync(),
    'Light Blue': ColorSchemes.lightBlue(),
    'Dark Blue': ColorSchemes.darkBlue(),
    'Light Red': ColorSchemes.lightRed(),
    'Dark Red': ColorSchemes.darkRed(),
    'Light Green': ColorSchemes.lightGreen(),
    'Dark Green': ColorSchemes.darkGreen(),
    'Light Yellow': ColorSchemes.lightYellow(),
    'Dark Yellow': ColorSchemes.darkYellow(),
    'Light Slate': ColorSchemes.lightSlate(),
    'Dark Slate': ColorSchemes.darkSlate(),
    'Light Stone': ColorSchemes.lightStone(),
    'Dark Stone': ColorSchemes.darkStone(),
    'Light Gray': ColorSchemes.lightGray(),
    'Dark Gray': ColorSchemes.darkGray(),
    'Light Neutral': ColorSchemes.lightNeutral(),
    'Dark Neutral': ColorSchemes.darkNeutral(),
    'Light Rose': ColorSchemes.lightRose(),
    'Dark Rose': ColorSchemes.darkRose(),
    'Light Violet': ColorSchemes.lightViolet(),
    'Dark Violet': ColorSchemes.darkViolet(),
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headline1(child: Text('Shadcn Flutter')),
              Headline2(child: Text('Color Scheme')),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: availableColorSchemes.entries
                    .map((entry) =>
                        buildColorSchemeButton(entry.key, entry.value))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Radius')),
              const SizedBox(height: 8),
              Slider(
                min: 0,
                max: 2,
                value: SliderValue.single(widget.radius),
                onChanged: (value) {
                  widget.onRadiusChanged(value.value);
                },
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Accordion')),
              Accordion(
                items: [
                  AccordionItem(
                    trigger: AccordionTrigger(child: Text('Hello World')),
                    content: Text('Lorem ipsum dolor sit amet'),
                  ),
                  AccordionItem(
                    trigger: AccordionTrigger(child: Text('Hello World')),
                    content: Text('Lorem ipsum dolor sit amet'),
                  ),
                  AccordionItem(
                    trigger: AccordionTrigger(child: Text('Hello World')),
                    content: Text('Lorem ipsum dolor sit amet'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Alert')),
              const SizedBox(height: 8),
              Alert(
                leading: Icon(Icons.rocket),
                title: Text('Hello World'),
                content: Text('Lorem ipsum dolor sit amet'),
                trailing: Center(child: Icon(Icons.close)),
              ),
              const SizedBox(height: 8),
              Alert(
                leading: Icon(Icons.rocket),
                title: Text('Hello World'),
                content: Text('Lorem ipsum dolor sit amet'),
                trailing: Center(
                  child: Icon(Icons.close),
                ),
                destructive: true,
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Button')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Button(
                    child: Text('Hello World'),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    onPressed: () {},
                    type: ButtonType.secondary,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    onPressed: () {},
                    type: ButtonType.destructive,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    onPressed: () {},
                    type: ButtonType.outline,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    onPressed: () {},
                    type: ButtonType.ghost,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    onPressed: () {},
                    type: ButtonType.link,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Button(
                    child: Text('Hello World'),
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    type: ButtonType.secondary,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    type: ButtonType.destructive,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    type: ButtonType.outline,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    type: ButtonType.ghost,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Text('Hello World'),
                    type: ButtonType.link,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // icon button
              Row(
                children: [
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    onPressed: () {},
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    onPressed: () {},
                    type: ButtonType.secondary,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    onPressed: () {},
                    type: ButtonType.destructive,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    onPressed: () {},
                    type: ButtonType.outline,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    onPressed: () {},
                    type: ButtonType.ghost,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    onPressed: () {},
                    type: ButtonType.link,
                    size: ButtonSize.icon,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    type: ButtonType.secondary,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    type: ButtonType.destructive,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    type: ButtonType.outline,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    type: ButtonType.ghost,
                    size: ButtonSize.icon,
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: Icon(Icons.rocket_outlined),
                    type: ButtonType.link,
                    size: ButtonSize.icon,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Alert Dialog')),
              const SizedBox(height: 8),
              Button(
                child: Text('Show Alert Dialog'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: AlertDialog(
                          title: Text('Hello World'),
                          content: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
                          actions: [
                            Button(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              type: ButtonType.outline,
                            ),
                            Button(
                              child: Text('Continue'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Badge')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Badge(
                    child: Text('Hello World'),
                  ),
                  const SizedBox(width: 8),
                  Badge(
                    child: Text('Hello World'),
                    type: ButtonType.secondary,
                  ),
                  const SizedBox(width: 8),
                  Badge(
                    child: Text('Hello World'),
                    type: ButtonType.destructive,
                  ),
                  const SizedBox(width: 8),
                  Badge(
                    child: Text('Hello World'),
                    type: ButtonType.outline,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Checkbox')),
              const SizedBox(height: 8),
              Checkbox(
                state: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = value;
                  });
                },
                label: Basic(
                  title: Text('Hello World'),
                  subtitle: Text('Lorem ipsum dolor sit amet'),
                ),
              ),
              const SizedBox(height: 8),
              Checkbox(
                state: _checked2,
                onChanged: (value) {
                  setState(() {
                    _checked2 = value;
                  });
                },
                tristate: true,
                label: Text('Hello World'),
              ),
              const SizedBox(height: 16),
              Headline2(child: Text('Slider')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      min: 20,
                      max: 80,
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(_sliderValue.value.toStringAsFixed(2)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _sliderValue2,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue2 = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                      '${_sliderValue2.start.toStringAsFixed(2)} - ${_sliderValue2.end.toStringAsFixed(2)}'),
                ],
              ),
            ],
          )),
    );
  }
}
