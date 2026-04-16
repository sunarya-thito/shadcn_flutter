---
name: shadcn-flutter
description: A comprehensive UI ecosystem for Flutter built on the shadcn/ui design system.
---

# Shadcn Flutter

A cohesive UI ecosystem for Flutter—components, theming, and tooling—ready to ditch Material and Cupertino. Built with modern design tokens and high-quality widgets across mobile, web, and desktop.

## Getting Started

To set up a fresh Flutter application with Shadcn Flutter:

1. Add the dependency:
   ```shell
   flutter pub add shadcn_flutter
   ```

2. Configure your `main.dart`:
   ```dart
   import 'package:shadcn_flutter/shadcn_flutter.dart';

   void main() {
     runApp(
       ShadcnApp(
         title: 'My App',
         theme: ThemeData(
           colorScheme: ColorSchemes.darkSlate,
           radius: 0.5,
         ),
         home: const MyHomePage(),
       ),
     );
   }

   class MyHomePage extends StatelessWidget {
     const MyHomePage({super.key});

     @override
     Widget build(BuildContext context) {
       return const Scaffold(
         child: Center(
           child: Text('Hello World!').h1(),
         ),
       );
     }
   }
   ```

## Guides

Learn the core concepts and design system fundamentals.

| Name | Description | Path |
| :--- | :--- | :--- |
| **Introduction** | Overview of the ecosystem, features, and FAQ. | [guides/introduction.md](./guides/introduction.md) |
| **Installation** | Step-by-step setup for stable and experimental versions. | [guides/installation.md](./guides/installation.md) |
| **Theming** | Customizing tokens like radius, density, and scaling. | [guides/theming.md](./guides/theming.md) |
| **Colors** | Using the Tailwind-based color palette and ColorShades. | [guides/colors.md](./guides/colors.md) |
| **Typography** | Semantic text styles and widget extensions. | [guides/typography.md](./guides/typography.md) |
| **Layout** | Spacing, gaps, and responsive layout helpers. | [guides/layout.md](./guides/layout.md) |
| **Icons** | Accessing the 10,000+ bundled icons (Lucide, Radix, etc). | [guides/icons.md](./guides/icons.md) |
| **Interop** | Using Material and Cupertino widgets incrementally. | [guides/interop.md](./guides/interop.md) |
| **State Management** | Guide to the built-in Data and Model state system. | [guides/state_management.md](./guides/state_management.md) |
| **Web Preloader** | Customizing the loading experience for web apps. | [guides/web_preloader.md](./guides/web_preloader.md) |

## Components

Shadcn Flutter features over 100+ high-quality components. Below are the core categories.

### Form & Input
| Component | Path |
| :--- | :--- |
| **Autocomplete** | [components/autocomplete.md](./components/autocomplete.md) |
| **Checkbox** | [components/checkbox.md](./components/checkbox.md) |
| **Color Picker** | [components/color_picker.md](./components/color_picker.md) |
| **Date Picker** | [components/date_picker.md](./components/date_picker.md) |
| **File Picker** | [components/file_picker.md](./components/file_picker.md) |
| **Input** | [components/input.md](./components/input.md) |
| **Input OTP** | [components/input_otp.md](./components/input_otp.md) |
| **Radio Group** | [components/radio_group.md](./components/radio_group.md) |
| **Select** | [components/select.md](./components/select.md) |
| **Slider** | [components/slider.md](./components/slider.md) |
| **Switch** | [components/switch.md](./components/switch.md) |
| **Text Area** | [components/text_area.md](./components/text_area.md) |

### Layout
| Component | Path |
| :--- | :--- |
| **Accordion** | [components/accordion.md](./components/accordion.md) |
| **Alert** | [components/alert.md](./components/alert.md) |
| **Breadcrumb** | [components/breadcrumb.md](./components/breadcrumb.md) |
| **Card** | [components/card.md](./components/card.md) |
| **Collapsible** | [components/collapsible.md](./components/collapsible.md) |
| **Resizable** | [components/resizable.md](./components/resizable.md) |
| **Scaffold** | [components/scaffold.md](./components/scaffold.md) |
| **Table** | [components/table.md](./components/table.md) |
| **Timeline** | [components/timeline.md](./components/timeline.md) |
| **Tree** | [components/tree.md](./components/tree.md) |

### Display
| Component | Path |
| :--- | :--- |
| **Avatar** | [components/avatar.md](./components/avatar.md) |
| **Badge** | [components/badge.md](./components/badge.md) |
| **Carousel** | [components/carousel.md](./components/carousel.md) |
| **Chat** | [components/chat.md](./components/chat.md) |
| **Chip** | [components/chip.md](./components/chip.md) |
| **Code Snippet** | [components/code_snippet.md](./components/code_snippet.md) |
| **Progress** | [components/progress.md](./components/progress.md) |
| **Skeleton** | [components/skeleton.md](./components/skeleton.md) |
| **Spinner** | [components/spinner.md](./components/spinner.md) |

### Overlay & Navigation
| Component | Path |
| :--- | :--- |
| **Dialog** | [components/dialog.md](./components/dialog.md) |
| **Drawer** | [components/drawer.md](./components/drawer.md) |
| **Navigation Bar** | [components/bar.md](./components/bar.md) |
| **Pagination** | [components/pagination.md](./components/pagination.md) |
| **Popover** | [components/popover.md](./components/popover.md) |
| **Tabs** | [components/tabs.md](./components/tabs.md) |
| **Toast** | [components/toast.md](./components/toast.md) |
| **Tooltip** | [components/tooltip.md](./components/tooltip.md) |

### Menu
| Component | Path |
| :--- | :--- |
| **Context Menu** | [components/context_menu.md](./components/context_menu.md) |
| **Dropdown Menu** | [components/dropdown_menu.md](./components/dropdown_menu.md) |
| **Menubar** | [components/menubar.md](./components/menubar.md) |
| **Navigation Menu** | [components/navigation_menu.md](./components/navigation_menu.md) |

> [!TIP]
> This is a curated list. For the full list of all 100+ components, check the [components directory](./components/).

## Interactive Usage Tips

1. **Wait for Interaction**: When using `Popover` or `Dialog`, prefer using the provided controllers for programmatic access.
2. **Lean on Extensions**: Use `.h1()`, `.p()`, `.iconSmall()` etc., instead of manually configuring `TextStyle` or `size`.
3. **Density Matters**: Use `DensityContainer` or `theme.density` to ensure spacing is consistent across platform-specific densities.
