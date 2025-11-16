<div align="center">

# 🎨 shadcn_flutter

**A cohesive shadcn/ui ecosystem for Flutter—components, theming, and
tooling—ready to ditch Material and Cupertino**

[![Pub Likes](https://img.shields.io/pub/likes/shadcn_flutter?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/shadcn_flutter)
[![Pub Points](https://img.shields.io/pub/points/shadcn_flutter?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/shadcn_flutter)
[![Pub Version](https://img.shields.io/pub/v/shadcn_flutter?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/shadcn_flutter)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/sunarya-thito?style=for-the-badge&logo=github&logoColor=white)](https://github.com/sponsors/sunarya-thito)
[![GitHub Repo stars](https://img.shields.io/github/stars/sunarya-thito/shadcn_flutter?style=for-the-badge&logo=github&logoColor=white)](https://github.com/sunarya-thito/shadcn_flutter)

**[📚 Widget Catalog](https://sunarya-thito.github.io/shadcn_flutter/)** •
**[📦 pub.dev](https://pub.dev/packages/shadcn_flutter)** •
**[💬 Discord](https://discord.gg/ZzfBPQG4sV)**

</div>

---

## Introduction

Welcome to shadcn_flutter, a cohesive UI ecosystem built on the shadcn/ui design
system for Flutter applications across mobile, web, and desktop. Rather than a
one‑to‑one design‑system port, this project focuses on delivering a consistent,
production‑ready experience that feels at home on every platform.

> [!NOTE]
> Already using Material or Cupertino? You can adopt shadcn_flutter
> incrementally: mix components inside your existing MaterialApp/CupertinoApp,
> keep your navigation (e.g., GoRouter), and align visuals with your
> shadcn_flutter theme. Interop is optional—go all‑in when you're ready.

## Features

- 84 components and growing!
- Standalone ecosystem: no Material or Cupertino requirement; optional interop
  when needed.
- shadcn/ui design tokens and ready-to-use New York theme.
- Works inside MaterialApp and CupertinoApp; mix and match while you migrate.
- First-class support across Android, iOS, Web, macOS, Windows, and Linux.
- Various widget extensions for typography purposes.

## Components Library

### Animation

[![AnimatedValueBuilder](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/animatedvaluebuilder.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/animated_value_builder)
[![Number Ticker](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/number_ticker.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/number_ticker)
[![RepeatedAnimationBuilder](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/repeatedanimationbuilder.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/repeated_animation_builder)

### Disclosure

[![Accordion](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/accordion.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/accordion)
[![Collapsible](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/collapsible.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/collapsible)

### Feedback

[![Alert](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/alert.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/alert)
[![Alert Dialog](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/alert_dialog.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/alert-dialog)
[![Circular Progress](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/circular_progress.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/circular-progress)
[![Progress Bar](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/progress.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/progress)
[![Skeleton](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/skeleton.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/skeleton)
[![Toast](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/toast.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/toast)

### Forms

[![Button](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/button.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/button)
[![Checkbox](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/checkbox.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/checkbox)
[![Chip Input](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/chip_input.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/chip_input)
[![Color Picker](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/colorpicker.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/color-picker)
[![Date Picker](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/datepicker.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/date_picker)
[![Form](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/form.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/form)
[![Input](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/input.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/input)
[![Input OTP](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/inputotp.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/input_otp)
[![Phone Input](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/phone_input.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/phone_input)
[![Radio Group](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/radiogroup.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/radio_group)
[![Select](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/select.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/select)
[![Slider](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/slider.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/slider)
[![Star Rating](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/star_rating.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/star_rating)
[![Switch](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/switch.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/switch)
[![Text Area](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/textarea.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/text_area)
[![Time Picker](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/time_picker.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/time_picker)
[![Toggle](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/toggle.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/toggle)

### Layout

[![Card](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/card.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/card)
[![Carousel](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/carousel.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/carousel)
[![Divider](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/divider.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/divider)
[![Resizable](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/resizable.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/resizable)
[![Stepper](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/stepper.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/stepper)
[![Steps](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/steps.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/steps)
[![Timeline](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/timeline.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/timeline)

### Navigation

[![Breadcrumb](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/breadcrumb.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/breadcrumb)
[![Menubar](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/menubar.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/menubar)
[![Navigation Menu](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/navigation_menu.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/navigation_menu)
[![Pagination](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/pagination.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/pagination)
[![Tabs](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/tabs.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/tabs)
[![Tab List](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/tablist.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/tab_list)
[![Tree](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/tree.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/tree)

### Surfaces

[![Dialog](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/dialog.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/dialog)
[![Drawer](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/drawer.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/drawer)
[![Hover Card](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/hover_card.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/hover_card)
[![Popover](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/popover.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/popover)
[![Sheet](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/sheet.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/sheet)
[![Tooltip](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/tooltip.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/tooltip)

### Data Display

[![Avatar](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/avatar.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/avatar)
[![Avatar Group](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/avatar_group.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/avatar_group)
[![Code Snippet](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/codesnippet.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/code-snippet)
[![Tracker](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/tracker.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/tracker)

### Utilities

[![Badge](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/badge.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/badge)
[![Calendar](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/calendar.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/calendar)
[![Command](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/command.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/command)
[![Context Menu](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/context_menu.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/context_menu)
[![Dropdown Menu](https://raw.githubusercontent.com/sunarya-thito/shadcn_flutter/master/docs_images/dropdown_menu.png)](https://sunarya-thito.github.io/shadcn_flutter/#/components/dropdown_menu)

## LLMs Support

This repository includes a prebuilt, machine‑friendly reference file you can
feed to LLMs and editor assistants:

- [`llms-full.txt`](https://sunarya-thito.github.io/shadcn_flutter/llms-full.txt) -
  Full component reference with props, methods, and usage examples

## FAQ

<details>
<summary><strong>Does this replace Material/Cupertino?</strong></summary>

Yes. shadcn_flutter is a standalone ecosystem built on the shadcn/ui design
system. Interop with Material/Cupertino is optional so you can adopt it
incrementally or go all‑in.

</details>

<details>
<summary><strong>Can I use it with my existing MaterialApp/CupertinoApp?</strong></summary>

Yes. Drop shadcn_flutter components into your app, keep your current routing
(e.g., GoRouter) and state management, and migrate over time.

</details>

<details>
<summary><strong>Does it support GoRouter?</strong></summary>

Yes.

</details>

<details>
<summary><strong>Which platforms are supported?</strong></summary>

Android, iOS, Web, macOS, Windows, and Linux.

</details>

<details>
<summary><strong>Can I use it commercially?</strong></summary>

Yes. Free to use for personal and commercial projects. No attribution required.

</details>

<details>
<summary><strong>Can I choose between Default and New York styles?</strong></summary>

This package currently supports the New York style. If you need the default
style of shadcn/ui, consider this package:
[flutter-shadcn-ui](https://github.com/nank1ro/flutter-shadcn-ui) by
[@nank1ro](https://x.com/nank1ro).

</details>

## Contributing & Support

We welcome contributions from the community! Here's how you can help make
shadcn_flutter even better:

### Ways to Contribute

<div align="center">

[![⭐ Star on GitHub](https://img.shields.io/badge/⭐_Star_on_GitHub-black?style=for-the-badge&logo=github)](https://github.com/sunarya-thito/shadcn_flutter)
[![💖 Sponsor](https://img.shields.io/badge/💖_Sponsor-pink?style=for-the-badge&logo=github-sponsors)](https://github.com/sponsors/sunarya-thito)
[![🐛 Report Bug](https://img.shields.io/badge/🐛_Report_Bug-red?style=for-the-badge&logo=github)](https://github.com/sunarya-thito/shadcn_flutter/issues)
[![💡 Request Feature](https://img.shields.io/badge/💡_Request_Feature-blue?style=for-the-badge&logo=github)](https://github.com/sunarya-thito/shadcn_flutter/issues)

</div>

#### Financial Support

- **[GitHub Sponsors](https://github.com/sponsors/sunarya-thito)** - Support
  ongoing development
- **[PayPal](https://paypal.me/sunaryathito)** - Support ongoing development
- **Star the repository** - Help us reach more developers
- **Share the project** - Spread the word in your community

#### Code Contributions

- **Bug fixes** - Help us squash those pesky bugs
- **New features** - Add components or enhance existing ones
- **Documentation** - Improve guides, examples, and API docs
- **Testing** - Write tests to improve reliability

#### Community Support

- **[Join our Discord](https://discord.gg/ZzfBPQG4sV)** - Get help and connect
  with other developers
- **Help others** - Answer questions and share your knowledge
- **Write tutorials** - Create blog posts or video tutorials

### Recognition

This project is funded and maintained by the community. Every contribution, no
matter how small, makes a difference and helps ensure the continued development
of shadcn_flutter.

**Thank you to all our contributors and supporters! 🙏**

---

<div align="center">

**Built with ❤️ by [Thito Yalasatria Sunarya](https://github.com/sunarya-thito)
and the community**

_Made in Indonesia 🇮🇩_

</div>
