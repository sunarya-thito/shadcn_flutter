---
title: "Class: OverlayAnchorRegistry"
description: "A registry mapping anchor keys to their [OverlayAnchor] entries.   By default anchors register with the process-wide [global] registry, so keys  must be globally unique. Wrap a subtree in an [OverlayAnchorScope] to give it  its own registry — then keys only need to be unique within that scope, and  the same key can be reused in sibling scopes (e.g. one per list item, tab, or  route). [OverlayAnchor] and [LinkedAnchor] both resolve their registry from  the nearest scope via [of]."
---

```dart
/// A registry mapping anchor keys to their [OverlayAnchor] entries.
///
/// By default anchors register with the process-wide [global] registry, so keys
/// must be globally unique. Wrap a subtree in an [OverlayAnchorScope] to give it
/// its own registry — then keys only need to be unique within that scope, and
/// the same key can be reused in sibling scopes (e.g. one per list item, tab, or
/// route). [OverlayAnchor] and [LinkedAnchor] both resolve their registry from
/// the nearest scope via [of].
class OverlayAnchorRegistry {
  /// The process-wide fallback registry, used when there's no enclosing
  /// [OverlayAnchorScope]. Has no [parent].
  static final OverlayAnchorRegistry global;
  /// The enclosing scope's registry. [find] falls back to it (and so on up to
  /// [global]) when a key isn't registered in this scope, so an inner scope can
  /// resolve anchors declared by an outer one. Null for [global]. Set by the
  /// owning [OverlayAnchorScope]; registrations always stay local.
  OverlayAnchorRegistry? parent;
  /// Creates an [OverlayAnchorRegistry], optionally chained to a [parent].
  OverlayAnchorRegistry({this.parent});
  /// The registry for [context]'s nearest [OverlayAnchorScope], or [global] if
  /// there is none. Does not create an inherited-widget dependency, so it is
  /// safe to call outside of build (e.g. while showing an overlay).
  static OverlayAnchorRegistry of(BuildContext context);
  /// Registers an [OverlayAnchorEntry] with the given key in this registry.
  void register(Object key, OverlayAnchorEntry entry);
  /// Unregisters the entry for the given key from this registry.
  void unregister(Object key);
  /// Finds the entry for [key], falling back to [parent] (and up the chain to
  /// [global]) when it isn't registered in this scope.
  OverlayAnchorEntry? find(Object key);
}
```
