# Switcher

A swipeable container that transitions between multiple child widgets.

## Usage

### Switcher Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/switcher/switcher_example_1.dart';
import 'package:docs/pages/docs/components/switcher/switcher_example_2.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherExample extends StatelessWidget {
  const SwitcherExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'switcher',
      description:
          'A Switcher widget allows you to switch between different widgets with a transition effect.',
      displayName: 'Switcher',
      children: [
        WidgetUsageExample(
          title: 'Switcher Example 1',
          path: 'lib/pages/docs/components/switcher/switcher_example_1.dart',
          child: SwitcherExample1(),
        ),
        WidgetUsageExample(
          title: 'Switcher Example 2',
          path: 'lib/pages/docs/components/switcher/switcher_example_2.dart',
          child: SwitcherExample2(),
        ),
      ],
    );
  }
}

```

### Switcher Example 1
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherExample1 extends StatefulWidget {
  const SwitcherExample1({super.key});

  @override
  State<SwitcherExample1> createState() => _SwitcherExample1State();
}

class _SwitcherExample1State extends State<SwitcherExample1> {
  List<AxisDirection> directions = const [
    AxisDirection.up,
    AxisDirection.down,
    AxisDirection.left,
    AxisDirection.right,
  ];
  List<Size> sizes = const [
    Size(200, 300),
    Size(300, 200),
  ];
  int directionIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
            child: Text(
                'Switch Direction (${directions[directionIndex % directions.length]})'),
            onPressed: () {
              setState(() {
                directionIndex++;
              });
            }),
        gap(8),
        PrimaryButton(
            child: const Text('Next Item'),
            onPressed: () {
              setState(() {
                index++;
              });
            }),
        gap(24),
        ClipRect(
          child: Switcher(
            // The index selects which child is visible; transitions are directional.
            index: index,
            direction: directions[directionIndex % directions.length],
            onIndexChanged: (index) {
              setState(() {
                this.index = index;
              });
            },
            children: [
              for (int i = 0; i < 100; i++)
                NumberedContainer(
                  index: i,
                  // Demonstrate different sizes to show animated size transitions.
                  width: sizes[i % sizes.length].width,
                  height: sizes[i % sizes.length].height,
                )
            ],
          ),
        ),
      ],
    );
  }
}

```

### Switcher Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherExample2 extends StatefulWidget {
  const SwitcherExample2({super.key});

  @override
  State<SwitcherExample2> createState() => _SwitcherExample2State();
}

class _SwitcherExample2State extends State<SwitcherExample2> {
  bool _isRegister = false;
  final _registerController = FormController();
  final _loginController = FormController();
  @override
  Widget build(BuildContext context) {
    return Switcher(
      // Toggle between login (index 0) and register (index 1) forms.
      index: _isRegister ? 1 : 0,
      onIndexChanged: (index) {
        setState(() {
          _isRegister = index == 1;
        });
      },
      direction: AxisDirection.left,
      children: [
        Container(
          key: const Key('login'),
          width: 350,
          padding: const EdgeInsets.all(16),
          child: Form(
            controller: _loginController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormField(
                  key: const TextFieldKey(#email),
                  label: const Text('Email'),
                  validator: const EmailValidator() & const NotEmptyValidator(),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    initialValue:
                        _loginController.getValue(const TextFieldKey(#email)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                const FormField(
                  key: TextFieldKey(#password),
                  label: Text('Password'),
                  validator: NotEmptyValidator(),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
                const SubmitButton(
                  child: Text('Login'),
                ),
                const Text('Don\'t have an account? ').thenButton(
                    onPressed: () {
                      setState(() {
                        // Switch to the register form.
                        _isRegister = true;
                      });
                    },
                    child: const Text('Sign Up!')),
              ],
            ),
          ),
        ),
        Container(
          key: const Key('register-form'),
          width: 350,
          padding: const EdgeInsets.all(16),
          child: Form(
            controller: _registerController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormField(
                  key: const TextFieldKey(#email),
                  label: const Text('Email'),
                  validator: const EmailValidator() & const NotEmptyValidator(),
                  showErrors: const {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(
                    initialValue: _registerController
                        .getValue(const TextFieldKey(#email)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                const FormField(
                  key: TextFieldKey(#password),
                  label: Text('Password'),
                  validator: LengthValidator(
                      min: 6,
                      message: 'Password must be at least 6 characters'),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
                const FormField(
                  key: TextFieldKey(#confirmPassword),
                  label: Text('Confirm Password'),
                  validator: CompareWith.equal(TextFieldKey(#password),
                      message: 'Passwords do not match'),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
                const SubmitButton(
                  child: Text('Register'),
                ),
                const Text('Already have an account? ').thenButton(
                    onPressed: () {
                      setState(() {
                        // Switch back to the login form.
                        _isRegister = false;
                      });
                    },
                    child: const Text('Login!')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `index` | `int` | Current active child index. |
| `onIndexChanged` | `ValueChanged<int>?` | Callback invoked when the active index changes through gestures. |
| `direction` | `AxisDirection` | Direction of the swipe transition animation. |
| `children` | `List<Widget>` | List of child widgets to switch between. |
| `duration` | `Duration` | Duration of the transition animation. |
| `curve` | `Curve` | Animation curve for the transition. |
