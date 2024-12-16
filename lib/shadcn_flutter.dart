library shadcn_flutter;

// bundle from https://pub.dev/packages/country_flags
export 'package:country_flags/country_flags.dart' show CountryFlag;
// bundle cross_file
export 'package:cross_file/cross_file.dart' show XFile;
// bundle from data_widget
export 'package:data_widget/data_widget.dart';
export 'package:data_widget/extension.dart';
export 'package:flutter/cupertino.dart'
    show
        cupertinoDesktopTextSelectionControls,
        cupertinoDesktopTextSelectionHandleControls;
// export Icons from material
export 'package:flutter/material.dart'
    show Icons, MaterialPageRoute, MaterialPage, SliverAppBar, FlutterLogo
    hide TextButton;
export 'package:flutter/widgets.dart'
    hide
        ErrorWidgetBuilder,
        Form,
        FormState,
        Table,
        TableRow,
        TableCell,
        FormField;
// bundle from gap
export 'package:gap/gap.dart';
// hide pixel_snap overriden widgets
// Column,
// Row,
// Text,
// RichText,
// Center,
// FractionallySizedBox,
// Align,
// Baseline,
// ConstrainedBox,
// DecoratedBox,
// Container,
// FittedBox,
// IntrinsicWidth,
// LimitedBox,
// OverflowBox,
// Padding,
// SizedBox,
// SizedOverflowBox,
// Positioned,
// PhysicalModel,
// CustomPaint,
// Icon,
// Image,
// ImageIcon,
// AnimatedAlign,
// AnimatedContainer,
// AnimatedCrossFade,
// AnimatedPositioned,
// AnimatedPhysicalModel,
// AnimatedSize;
// bundle from https://pub.dev/packages/phonecodes
export 'package:phonecodes/phonecodes.dart' show Countries, Country;
// export 'package:pixel_snap/widgets.dart'
//     show
//         Column,
//         Row,
//         Text,
//         RichText,
//         Center,
//         FractionallySizedBox,
//         Align,
//         Baseline,
//         ConstrainedBox,
//         DecoratedBox,
//         Container,
//         FittedBox,
//         IntrinsicWidth,
//         LimitedBox,
//         OverflowBox,
//         Padding,
//         SizedBox,
//         SizedOverflowBox,
//         Positioned,
//         PhysicalModel,
//         CustomPaint,
//         Icon,
//         Image,
//         ImageIcon,
//         AnimatedAlign,
//         AnimatedContainer,
//         AnimatedCrossFade,
//         AnimatedPositioned,
//         AnimatedPhysicalModel,
//         AnimatedSize;
// bundle from skeletonizer https://pub.dev/packages/skeletonizer
export 'package:skeletonizer/skeletonizer.dart' show Bone, BoneMock;

export 'src/animation.dart';
export 'src/collection.dart';
export 'src/components/animation.dart';
export 'src/components/chart/tracker.dart';
export 'src/components/control/button.dart';
export 'src/components/control/clickable.dart';
export 'src/components/control/command.dart';
export 'src/components/control/scrollbar.dart';
export 'src/components/control/scrollview.dart';
export 'src/components/display/avatar.dart';
export 'src/components/display/badge.dart';
export 'src/components/display/calendar.dart';
export 'src/components/display/carousel.dart';
export 'src/components/display/chip.dart';
export 'src/components/display/circular_progress_indicator.dart';
export 'src/components/display/code_snippet.dart';
export 'src/components/display/divider.dart';
export 'src/components/display/dot_indicator.dart';
export 'src/components/display/keyboard_shortcut.dart';
export 'src/components/display/linear_progress_indicator.dart';
export 'src/components/display/number_ticker.dart';
export 'src/components/display/progress.dart';
export 'src/components/display/skeleton.dart';
export 'src/components/form/autocomplete.dart';
export 'src/components/form/checkbox.dart';
export 'src/components/form/chip_input.dart';
export 'src/components/form/color_picker.dart';
export 'src/components/form/date_picker.dart';
export 'src/components/form/form.dart';
export 'src/components/form/form_field.dart';
export 'src/components/form/image.dart';
export 'src/components/form/input_otp.dart';
export 'src/components/form/number_input.dart';
export 'src/components/form/phone_input.dart';
export 'src/components/form/radio_group.dart';
export 'src/components/form/select.dart';
export 'src/components/form/slider.dart';
export 'src/components/form/sortable.dart';
export 'src/components/form/star_rating.dart';
export 'src/components/form/switch.dart';
export 'src/components/form/text_area.dart';
export 'src/components/form/text_field.dart';
export 'src/components/form/time_picker.dart';
export 'src/components/form/validated.dart';
export 'src/components/icon/icon.dart';
export 'src/components/icon/triple_dots.dart';
export 'src/components/layout/accordion.dart';
export 'src/components/layout/alert.dart';
export 'src/components/layout/basic.dart';
export 'src/components/layout/breadcrumb.dart';
export 'src/components/layout/card.dart';
export 'src/components/layout/card_image.dart';
export 'src/components/layout/collapsible.dart';
export 'src/components/layout/dialog/alert_dialog.dart';
export 'src/components/layout/media_query.dart';
export 'src/components/layout/outlined_container.dart';
export 'src/components/layout/overflow_marquee.dart';
export 'src/components/layout/resizable.dart';
export 'src/components/layout/scaffold.dart';
export 'src/components/layout/scrollable_client.dart';
export 'src/components/layout/sortable.dart';
export 'src/components/layout/stage_container.dart';
export 'src/components/layout/stepper.dart';
export 'src/components/layout/steps.dart';
export 'src/components/layout/table.dart';
export 'src/components/layout/timeline.dart';
export 'src/components/layout/tree.dart';
export 'src/components/locale/shadcn_localizations.dart';
export 'src/components/menu/context_menu.dart';
export 'src/components/menu/dropdown_menu.dart';
export 'src/components/menu/menu.dart';
export 'src/components/menu/menubar.dart';
export 'src/components/menu/navigation_menu.dart';
export 'src/components/menu/popup.dart';
export 'src/components/navigation/navigation_bar.dart';
export 'src/components/navigation/pagination.dart';
export 'src/components/navigation/tab_list.dart';
export 'src/components/navigation/tabs.dart';
export 'src/components/overlay/dialog.dart';
export 'src/components/overlay/drawer.dart';
export 'src/components/overlay/hover_card.dart';
export 'src/components/overlay/overlay.dart';
export 'src/components/overlay/popover.dart';
export 'src/components/overlay/refresh_trigger.dart';
export 'src/components/overlay/toast.dart';
export 'src/components/overlay/tooltip.dart';
export 'src/components/text/selectable.dart';
export 'src/components/text/text.dart';
export 'src/icons/bootstrap_icons.dart';
export 'src/icons/radix_icons.dart';
export 'src/shadcn_app.dart';
export 'src/theme/color_scheme.dart';
export 'src/theme/generated_colors.dart';
export 'src/theme/generated_themes.dart';
export 'src/theme/theme.dart';
export 'src/theme/typography.dart';
export 'src/util.dart';
