<dotguides>
This workspace uses the *Dotguides* system for providing context-aware coding guidance for open source packages it uses. Use the `read_docs` tool to load documentation files relevant to specific tasks.

## Detected Languages

Language: flutter
Runtime: flutter
Version: >=3.3.0 <4.0.0
Package Manager: pub

## Package Usage Guides

The following are the discovered package usage guides for this workspace. FOLLOW THEIR GUIDANCE CAREFULLY. Not all packages have discoverable guidance files.

<package name="shadcn_flutter">
<usage_guide>
# shadcn_flutter — Usage

shadcn_flutter is a Flutter component library inspired by shadcn/ui. It brings a
consistent, modern design system to Flutter with polished, themeable widgets
that feel at home on mobile and desktop.

## Installation (stable)

1. Create a Flutter project

```shell
flutter create my_app
cd my_app
```

2. Add the dependency

```shell
flutter pub add shadcn_flutter
```

3. Import the package

```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
```

4. Use ShadcnApp in main()

```dart
void main() {
  runApp(
    ShadcnApp(
      title: 'My App',
      home: MyHomePage(),
    ),
  );
}
```

5. Run the app

```shell
flutter run
```

## Installation (experimental)

Use a Git dependency to track the latest changes. Not recommended for
production.

```yaml
dependencies:
  shadcn_flutter:
    git:
      url: "https://github.com/sunarya-thito/shadcn_flutter.git"
```
</usage_guide>
</package>
</dotguides>