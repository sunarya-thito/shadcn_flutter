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

### Animation
| Component | Path |
| :--- | :--- |
| **Number Ticker** | [components/animation/number_ticker.md](./components/animation/number_ticker.md) |

### Control
| Component | Path |
| :--- | :--- |
| **Button** | [components/control/button.md](./components/control/button.md) |

### Disclosure
| Component | Path |
| :--- | :--- |
| **Accordion** | [components/disclosure/accordion.md](./components/disclosure/accordion.md) |
| **Collapsible** | [components/disclosure/collapsible.md](./components/disclosure/collapsible.md) |

### Display
| Component | Path |
| :--- | :--- |
| **Avatar** | [components/display/avatar.md](./components/display/avatar.md) |
| **Chat Bubble** | [components/display/chat.md](./components/display/chat.md) |
| **Code Snippet** | [components/display/code_snippet.md](./components/display/code_snippet.md) |
| **Table** | [components/display/table.md](./components/display/table.md) |
| **Tracker** | [components/display/tracker.md](./components/display/tracker.md) |

### Feedback
| Component | Path |
| :--- | :--- |
| **Alert** | [components/feedback/alert.md](./components/feedback/alert.md) |
| **Alert Dialog** | [components/feedback/alert_dialog.md](./components/feedback/alert_dialog.md) |
| **Progress** | [components/feedback/progress.md](./components/feedback/progress.md) |
| **Skeleton** | [components/feedback/skeleton.md](./components/feedback/skeleton.md) |
| **Toast** | [components/feedback/toast.md](./components/feedback/toast.md) |

### Form
| Component | Path |
| :--- | :--- |
| **AutoComplete** | [components/form/autocomplete.md](./components/form/autocomplete.md) |
| **Checkbox** | [components/form/checkbox.md](./components/form/checkbox.md) |
| **Chip Input** | [components/form/chip_input.md](./components/form/chip_input.md) |
| **Color Picker** | [components/form/color_picker.md](./components/form/color_picker.md) |
| **Date Picker** | [components/form/date_picker.md](./components/form/date_picker.md) |
| **Form** | [components/form/form.md](./components/form/form.md) |
| **Formatted Input** | [components/form/formatted_input.md](./components/form/formatted_input.md) |
| **Text Input** | [components/form/input.md](./components/form/input.md) |
| **Input OTP** | [components/form/input_otp.md](./components/form/input_otp.md) |
| **Item Picker** | [components/form/item_picker.md](./components/form/item_picker.md) |
| **Phone Input** | [components/form/phone_input.md](./components/form/phone_input.md) |
| **Radio Group** | [components/form/radio_group.md](./components/form/radio_group.md) |
| **Select** | [components/form/select.md](./components/form/select.md) |
| **Slider** | [components/form/slider.md](./components/form/slider.md) |
| **Star Rating** | [components/form/star_rating.md](./components/form/star_rating.md) |
| **Switch** | [components/form/switch.md](./components/form/switch.md) |
| **Text Area** | [components/form/text_area.md](./components/form/text_area.md) |
| **Time Picker** | [components/form/time_picker.md](./components/form/time_picker.md) |

### Layout
| Component | Path |
| :--- | :--- |
| **Card** | [components/layout/card.md](./components/layout/card.md) |
| **Card Image** | [components/layout/card_image.md](./components/layout/card_image.md) |
| **Carousel** | [components/layout/carousel.md](./components/layout/carousel.md) |
| **Divider** | [components/layout/divider.md](./components/layout/divider.md) |
| **Resizable** | [components/layout/resizable.md](./components/layout/resizable.md) |
| **Scaffold** | [components/layout/scaffold.md](./components/layout/scaffold.md) |
| **Sortable** | [components/layout/sortable.md](./components/layout/sortable.md) |
| **Stepper** | [components/layout/stepper.md](./components/layout/stepper.md) |
| **Steps** | [components/layout/steps.md](./components/layout/steps.md) |
| **Timeline** | [components/layout/timeline.md](./components/layout/timeline.md) |

### Navigation
| Component | Path |
| :--- | :--- |
| **Breadcrumb** | [components/navigation/breadcrumb.md](./components/navigation/breadcrumb.md) |
| **Dot Indicator** | [components/navigation/dot_indicator.md](./components/navigation/dot_indicator.md) |
| **Menubar** | [components/navigation/menubar.md](./components/navigation/menubar.md) |
| **Navigation Menu** | [components/navigation/navigation_menu.md](./components/navigation/navigation_menu.md) |
| **Pagination** | [components/navigation/pagination.md](./components/navigation/pagination.md) |
| **Switcher** | [components/navigation/switcher.md](./components/navigation/switcher.md) |
| **Tab List** | [components/navigation/tab_list.md](./components/navigation/tab_list.md) |
| **Tab Pane** | [components/navigation/tab_pane.md](./components/navigation/tab_pane.md) |
| **Tabs** | [components/navigation/tabs.md](./components/navigation/tabs.md) |
| **Tree** | [components/navigation/tree.md](./components/navigation/tree.md) |

### Overlay
| Component | Path |
| :--- | :--- |
| **Dialog** | [components/overlay/dialog.md](./components/overlay/dialog.md) |
| **Drawer** | [components/overlay/drawer.md](./components/overlay/drawer.md) |
| **Hover Card** | [components/overlay/hover_card.md](./components/overlay/hover_card.md) |
| **Popover** | [components/overlay/popover.md](./components/overlay/popover.md) |
| **Swiper** | [components/overlay/swiper.md](./components/overlay/swiper.md) |
| **Tooltip** | [components/overlay/tooltip.md](./components/overlay/tooltip.md) |
| **Window** | [components/overlay/window.md](./components/overlay/window.md) |

### Utility
| Component | Path |
| :--- | :--- |
| **Badge** | [components/utility/badge.md](./components/utility/badge.md) |
| **Calendar** | [components/utility/calendar.md](./components/utility/calendar.md) |
| **Chip** | [components/utility/chip.md](./components/utility/chip.md) |
| **Command** | [components/utility/command.md](./components/utility/command.md) |
| **Context Menu** | [components/utility/context_menu.md](./components/utility/context_menu.md) |
| **Dropdown Menu** | [components/utility/dropdown_menu.md](./components/utility/dropdown_menu.md) |
| **Overflow Marquee** | [components/utility/overflow_marquee.md](./components/utility/overflow_marquee.md) |
| **Refresh Trigger** | [components/utility/refresh_trigger.md](./components/utility/refresh_trigger.md) |

> [!TIP]
> This is a curated list. For the full list of all 100+ components, check the [components directory](./components/).

## Interactive Usage Tips

1. **Wait for Interaction**: When using `Popover` or `Dialog`, prefer using the provided controllers for programmatic access.
2. **Lean on Extensions**: Use `.h1()`, `.p()`, `.iconSmall()` etc., instead of manually configuring `TextStyle` or `size`.
3. **Density Matters**: Use `DensityContainer` or `theme.density` to ensure spacing is consistent across platform-specific densities.

