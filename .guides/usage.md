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
