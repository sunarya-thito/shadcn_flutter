import 'package:genui/genui.dart';

import 'catalog_widgets/button.dart' as button_item;
import 'catalog_widgets/card.dart' as card_item;
import 'catalog_widgets/check_box.dart' as check_box_item;
import 'catalog_widgets/choice_picker.dart' as choice_picker_item;
import 'catalog_widgets/divider.dart' as divider_item;
import 'catalog_widgets/slider.dart' as slider_item;
import 'catalog_widgets/text.dart' as text_item;
import 'catalog_widgets/text_field.dart' as text_field_item;

/// Catalog items that render AI-generated interfaces using shadcn_flutter
/// widgets instead of Material widgets.
///
/// This only re-themes the items that have a visibly different look in
/// shadcn_flutter (buttons, text, cards, form controls, ...). Items that are
/// already theme-neutral in [BasicCatalogItems] (such as `Column`, `Row`,
/// `Icon` and `Image`) are left untouched, and items with no shadcn_flutter
/// equivalent (such as `List`, `Modal`, `Tabs`, `AudioPlayer`, `Video` and
/// `DateTimeInput`) fall back to their Material implementation.
abstract final class ShadcnCatalogItems {
  ShadcnCatalogItems._();

  /// A button that triggers an action when pressed.
  static final CatalogItem button = button_item.button;

  /// A container that groups a single child widget.
  static final CatalogItem card = card_item.card;

  /// A checkbox that allows the user to toggle a boolean state.
  static final CatalogItem checkBox = check_box_item.checkBox;

  /// A widget allowing the user to select one or more options from a list.
  static final CatalogItem choicePicker = choice_picker_item.choicePicker;

  /// A thin horizontal or vertical line used to separate content.
  static final CatalogItem divider = divider_item.divider;

  /// A slider control for selecting a value from a range.
  static final CatalogItem slider = slider_item.slider;

  /// A block of styled text.
  static final CatalogItem text = text_item.text;

  /// An input field where the user can enter text.
  static final CatalogItem textField = text_field_item.textField;

  /// All the items re-themed by this package.
  static List<CatalogItem> get all => [
    button,
    card,
    checkBox,
    choicePicker,
    divider,
    slider,
    text,
    textField,
  ];

  /// Creates a catalog with all basic catalog items, with the items in
  /// [all] re-themed to use shadcn_flutter widgets.
  static Catalog asCatalog({List<String> systemPromptFragments = const []}) {
    return BasicCatalogItems.asCatalog(
      systemPromptFragments: systemPromptFragments,
    ).copyWith(newItems: all, catalogId: 'shadcn_flutter_catalog');
  }

  /// Creates a catalog without items that require additional data (audio,
  /// image or video), with the items in [all] re-themed to use
  /// shadcn_flutter widgets.
  static Catalog asNoAssetCatalog({
    List<String> systemPromptFragments = const [],
  }) {
    return BasicCatalogItems.asNoAssetCatalog(
      systemPromptFragments: systemPromptFragments,
    ).copyWith(newItems: all, catalogId: 'shadcn_flutter_catalog');
  }
}
