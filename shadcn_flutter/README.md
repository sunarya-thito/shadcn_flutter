# shadcn_flutter
A set of widgets and utilities for building applications in flutter.
Optimized for web applications.
This is a port of the shadcn UI package to flutter.

Widget Catalog: [shadcn_flutter](https://sunarya-thito.github.io/shadcn_flutter/)

## Usage
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'My App',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorSchemes.darkZync(),
        radius: 0.5,
      ),
      home: MyHomePage(),
    );
  }
}
```

## Widgets

### Disclosure
![Accodrion](docs_images/accordion.png)
![Collapsible](docs_images/collapsible.png)

### Feedback
![Alert](docs_images/alert.png)
![Alert Dialog](docs_images/alert_dialog.png)
![Circular Progress](docs_images/circular_progress.png)
![Progress Bar](docs_images/progress.png)
![Skeleton](docs_images/skeleton.png)

### Forms
![Button](docs_images/button.png)
![Checkbox](docs_images/checkbox.png)
![Color Picker](docs_images/colorpicker.png)
![Combobox](docs_images/combobox.png)
![Date Picker](docs_images/datepicker.png)
![Form](docs_images/form.png)
![Input](docs_images/input.png)
![Input OTP](docs_images/inputotp.png)
![Radio Group](docs_images/radiogroup.png)
![Slider](docs_images/slider.png)
![Switch](docs_images/switch.png)
![Text Area](docs_images/textarea.png)
![Toggle](docs_images/toggle.png)

### Layout
![Card](docs_images/card.png)
![Carousel](docs_images/carousel.png)
![Divider](docs_images/divider.png)
![Steps](docs_images/steps.png)

### Navigation
![Breadcrumb](docs_images/breadcrumb.png)
![Pagination](docs_images/pagination.png)
![Tabs](docs_images/tabs.png)
![Tab List](docs_images/tablist.png)

### Surfaces
![Dialog](docs_images/dialog.png)
![Drawer](docs_images/drawer.png)
![Popover](docs_images/popover.png)
![Sheet](docs_images/sheet.png)
![Tooltip](docs_images/tooltip.png)

### Data Display
![Avatar](docs_images/avatar.png)
![Code Snippet](docs_images/codesnippet.png)

### Utilities
![Badge](docs_images/badge.png)
![Calendar](docs_images/calendar.png)
![Command](docs_images/command.png)