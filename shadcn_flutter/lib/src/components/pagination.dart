import 'package:shadcn_flutter/shadcn_flutter.dart';

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

  Pagination({
    required this.page,
    required this.totalPages,
    required this.onPageChanged,
    this.maxPages = 3,
    this.showSkipToFirstPage = true,
    this.showSkipToLastPage = true,
    this.hidePreviousOnFirstPage = false,
    this.hideNextOnLastPage = false,
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

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!hidePreviousOnFirstPage || hasPrevious)
            GhostButton(
              onPressed: hasPrevious ? () => onPageChanged(page - 1) : null,
              leading: const Icon(Icons.arrow_back_ios_new).iconXSmall(),
              child: Text(localizations.buttonPrevious),
            ),
          if (hasMorePreviousPages) ...[
            if (showSkipToFirstPage && firstShownPage - 1 > 1)
              GhostButton(
                onPressed: () => onPageChanged(1),
                child: const Text('1'),
              ),
            GhostButton(
              onPressed: () => onPageChanged(firstShownPage - 1),
              child: MoreDots(),
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
              child: MoreDots(),
            ),
            if (showSkipToLastPage && lastShownPage + 1 < totalPages)
              GhostButton(
                onPressed: () => onPageChanged(totalPages),
                child: Text('$totalPages'),
              ),
          ],
          if (!hideNextOnLastPage || hasNext)
            GhostButton(
              onPressed: hasNext ? () => onPageChanged(page + 1) : null,
              trailing: Icon(Icons.arrow_forward_ios).iconXSmall(),
              child: Text(localizations.buttonNext),
            ),
        ],
      ).gap(4),
    );
  }
}
