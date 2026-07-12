import 'package:genui/genui.dart';

import 'gen_schema.dart';
import 'gen_schema_functions.dart';
import 'widgets/gen_accordion.dart';
import 'widgets/gen_alert.dart';
import 'widgets/gen_avatar.dart';
import 'widgets/gen_badge.dart';
import 'widgets/gen_button.dart';
import 'widgets/gen_card.dart';
import 'widgets/gen_checkbox.dart';
import 'widgets/gen_date_picker.dart';
import 'widgets/gen_form.dart';
import 'widgets/gen_form_field_error.dart';
import 'widgets/gen_progress.dart';
import 'widgets/gen_radio_group.dart';
import 'widgets/gen_select.dart';
import 'widgets/gen_slider.dart';
import 'widgets/gen_switch.dart';
import 'widgets/gen_tabs.dart';
import 'widgets/gen_text_area.dart';
import 'widgets/gen_text_field.dart';

/// Every [GenCatalogItem] this package ships, and the genui [Catalog]
/// built from them.
abstract final class GenCatalog {
  GenCatalog._();

  static const GenCatalogItem textField = genTextField;
  static const GenCatalogItem textArea = genTextArea;
  static const GenCatalogItem checkbox = genCheckbox;
  static const GenCatalogItem switchItem = genSwitch;
  static const GenCatalogItem select = genSelect;
  static const GenCatalogItem radioGroup = genRadioGroup;
  static const GenCatalogItem slider = genSlider;
  static const GenCatalogItem datePicker = genDatePicker;
  static const GenCatalogItem button = genButton;
  static const GenCatalogItem card = genCard;
  static const GenCatalogItem alert = genAlert;
  static const GenCatalogItem badge = genBadge;
  static const GenCatalogItem avatar = genAvatar;
  static const GenCatalogItem progress = genProgress;
  static const GenCatalogItem accordion = genAccordion;
  static const GenCatalogItem tabs = genTabs;
  static const GenCatalogItem form = genForm;
  static const GenCatalogItem formFieldError = genFormFieldError;

  static List<GenCatalogItem> get all => [
    textField,
    textArea,
    checkbox,
    switchItem,
    select,
    radioGroup,
    slider,
    datePicker,
    button,
    card,
    alert,
    badge,
    avatar,
    progress,
    accordion,
    tabs,
    form,
    formFieldError,
  ];

  /// Merged on top of [BasicCatalogItems.asNoAssetCatalog] so `Text`/
  /// `Column`/`Row`/etc. stay available alongside these shadcn_flutter
  /// widgets. [GenFunctions] (arithmetic/string/boolean) are always
  /// included alongside [systemFunctions], reachable both by the AI
  /// directly and from any widget's `functionCall` action nodes.
  static Catalog asCatalog({
    List<GenSystemFunction> systemFunctions = const [],
    List<String> systemPromptFragments = const [],
  }) {
    final allSystemFunctions = [...GenFunctions.all, ...systemFunctions];
    final registry = GenSystemFunctionRegistry(allSystemFunctions);
    return BasicCatalogItems.asNoAssetCatalog(
      systemPromptFragments: systemPromptFragments,
    ).copyWith(
      newItems: [
        for (final item in all) genCatalogItemToCatalogItem(item, registry),
      ],
      newFunctions: [
        ...BasicFunctions.all,
        for (final fn in allSystemFunctions) genSystemFunctionToClientFunction(fn),
      ],
      catalogId: 'shadcn_flutter_genui_catalog',
    );
  }
}
