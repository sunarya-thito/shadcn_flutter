import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing [Pagination] widget appearance.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [Pagination] widgets, including spacing between controls and label display
/// preferences. These properties can be set at the theme level to provide
/// consistent styling across the application.
class PaginationTheme {
  /// The spacing between pagination controls.
  final double? gap;

  /// Whether to show the previous/next labels.
  final bool? showLabel;

  /// Creates a [PaginationTheme].
  const PaginationTheme({
    this.gap,
    this.showLabel,
  });

  /// Returns a copy of this theme with the given fields replaced.
  PaginationTheme copyWith({
    ValueGetter<double?>? gap,
    ValueGetter<bool?>? showLabel,
  }) {
    return PaginationTheme(
      gap: gap == null ? this.gap : gap(),
      showLabel: showLabel == null ? this.showLabel : showLabel(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginationTheme &&
        other.gap == gap &&
        other.showLabel == showLabel;
  }

  @override
  int get hashCode => Object.hash(
        gap,
        showLabel,
      );
}

/// A navigation widget for paginated content with comprehensive page controls.
///
/// [Pagination] provides an intuitive interface for navigating through paginated
/// content such as search results, data tables, or article lists. It displays
/// page numbers, navigation arrows, and skip-to-edge controls with intelligent
/// page range management to handle large page counts elegantly.
///
/// Key features:
/// - Page number display with intelligent range selection
/// - Previous/next navigation arrows
/// - Skip to first/last page controls
/// - Configurable maximum visible page numbers
/// - Automatic page range calculation for large datasets
/// - Optional label display for Previous/Next buttons
/// - Customizable spacing and appearance
/// - Theme integration for consistent styling
///
/// Page display strategies:
/// - Small page counts: Show all page numbers
/// - Large page counts: Show current page with surrounding context
/// - Edge handling: Adjust range when near first or last page
/// - Current page highlighting: Visual indication of active page
///
/// Navigation behaviors:
/// - Direct page selection by tapping page numbers
/// - Sequential navigation with previous/next buttons
/// - Quick jump to first/last pages
/// - Conditional hiding of controls at boundaries
/// - Callback-based page change notification
///
/// The widget automatically calculates the optimal page number range to display
/// based on the current page and total page count, ensuring users always have
/// context about their position in the dataset.
///
/// Example:
/// ```dart
/// Pagination(
///   page: currentPage,
///   totalPages: totalPageCount,
///   maxPages: 5, // Show up to 5 page numbers
///   onPageChanged: (page) => setState(() {
///     currentPage = page;
///     _loadPageData(page);
///   }),
///   showSkipToFirstPage: true,
///   showSkipToLastPage: true,
///   hidePreviousOnFirstPage: true,
///   hideNextOnLastPage: true,
/// );
/// ```
class Pagination extends StatelessWidget {
  final int page;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  /// The maximum number of pages to show in the pagination.
  final int maxPages;
  final bool showSkipToFirstPage;
  final bool showSkipToLastPage;
  final bool hidePreviousOnFirstPage;
  final bool hideNextOnLastPage;
  final bool? showLabel;
  final double? gap;

  const Pagination({
    super.key,
    required this.page,
    required this.totalPages,
    required this.onPageChanged,
    this.maxPages = 3,
    this.showSkipToFirstPage = true,
    this.showSkipToLastPage = true,
    this.hidePreviousOnFirstPage = false,
    this.hideNextOnLastPage = false,
    this.showLabel,
    this.gap,
  });

  bool get hasPrevious => page > 1;
  bool get hasNext => page < totalPages;
  Iterable<int> get pages sync* {
    if (totalPages <= maxPages) {
      yield* List.generate(totalPages, (index) => index + 1);
    } else {
      final start = page - maxPages ~/ 2;
      final end = page + maxPages ~/ 2;
      if (start < 1) {
        yield* List.generate(maxPages, (index) => index + 1);
      } else if (end > totalPages) {
        yield* List.generate(
            maxPages, (index) => totalPages - maxPages + index + 1);
      } else {
        yield* List.generate(maxPages, (index) => start + index);
      }
    }
  }

  int get firstShownPage {
    if (totalPages <= maxPages) {
      return 1;
    } else {
      final start = page - maxPages ~/ 2;
      return start < 1 ? 1 : start;
    }
  }

  int get lastShownPage {
    if (totalPages <= maxPages) {
      return totalPages;
    } else {
      final end = page + maxPages ~/ 2;
      return end > totalPages ? totalPages : end;
    }
  }

  bool get hasMorePreviousPages => firstShownPage > 1;
  bool get hasMoreNextPages => lastShownPage < totalPages;

  Widget _buildPreviousLabel(
      ShadcnLocalizations localizations, bool showLabel) {
    if (showLabel) {
      return GhostButton(
        onPressed: hasPrevious ? () => onPageChanged(page - 1) : null,
        leading: const Icon(RadixIcons.chevronLeft).iconXSmall(),
        child: Text(localizations.buttonPrevious),
      );
    }
    return GhostButton(
      onPressed: hasPrevious ? () => onPageChanged(page - 1) : null,
      child: const Icon(RadixIcons.chevronLeft).iconXSmall(),
    );
  }

  Widget _buildNextLabel(
      ShadcnLocalizations localizations, bool showLabel) {
    if (showLabel) {
      return GhostButton(
        onPressed: hasNext ? () => onPageChanged(page + 1) : null,
        trailing: const Icon(RadixIcons.chevronRight).iconXSmall(),
        child: Text(localizations.buttonNext),
      );
    }
    return GhostButton(
      onPressed: hasNext ? () => onPageChanged(page + 1) : null,
      child: const Icon(RadixIcons.chevronRight).iconXSmall(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<PaginationTheme>(context);
    final gap = styleValue(
        widgetValue: this.gap,
        themeValue: compTheme?.gap,
        defaultValue: 4 * scaling);
    final showLabel = styleValue(
        widgetValue: this.showLabel,
        themeValue: compTheme?.showLabel,
        defaultValue: true);
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!hidePreviousOnFirstPage || hasPrevious)
            _buildPreviousLabel(localizations, showLabel),
          if (hasMorePreviousPages) ...[
            if (showSkipToFirstPage && firstShownPage - 1 > 1)
              GhostButton(
                onPressed: () => onPageChanged(1),
                child: const Text('1'),
              ),
            GhostButton(
              onPressed: () => onPageChanged(firstShownPage - 1),
              child: const MoreDots(),
            ),
          ],
          for (final p in pages)
            if (p == page)
              OutlineButton(
                onPressed: () => onPageChanged(p),
                child: Text('$p'),
              )
            else
              GhostButton(
                onPressed: () => onPageChanged(p),
                child: Text('$p'),
              ),
          if (hasMoreNextPages) ...[
            GhostButton(
              onPressed: () => onPageChanged(lastShownPage + 1),
              child: const MoreDots(),
            ),
            if (showSkipToLastPage && lastShownPage + 1 < totalPages)
              GhostButton(
                onPressed: () => onPageChanged(totalPages),
                child: Text('$totalPages'),
              ),
          ],
          if (!hideNextOnLastPage || hasNext)
            _buildNextLabel(localizations, showLabel),
        ],
      ).gap(gap),
    );
  }
}
