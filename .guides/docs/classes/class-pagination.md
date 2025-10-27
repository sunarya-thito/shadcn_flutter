---
title: "Class: Pagination"
description: "A navigation widget for paginated content with comprehensive page controls."
---

```dart
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
  const Pagination({super.key, required this.page, required this.totalPages, required this.onPageChanged, this.maxPages = 3, this.showSkipToFirstPage = true, this.showSkipToLastPage = true, this.hidePreviousOnFirstPage = false, this.hideNextOnLastPage = false, this.showLabel, this.gap});
  bool get hasPrevious;
  bool get hasNext;
  Iterable<int> get pages;
  int get firstShownPage;
  int get lastShownPage;
  bool get hasMorePreviousPages;
  bool get hasMoreNextPages;
  Widget build(BuildContext context);
}
```
