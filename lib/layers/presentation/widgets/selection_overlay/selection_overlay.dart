import 'package:flutter/material.dart';

class WidgetSelectionOverlay extends StatefulWidget {
  final Widget child;
  final Widget option;
  final num optionHeight;
  final bool onLeft;

  const WidgetSelectionOverlay({
    super.key,
    required this.child,
    required this.option,
    this.optionHeight = 0,
    this.onLeft = false,
  });

  @override
  State<WidgetSelectionOverlay> createState() => _SelectionOverlayState();
}

class _SelectionOverlayState extends State<WidgetSelectionOverlay> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _open() {
    if (mounted) {
      _overlayEntry = _getOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _close() {
    _overlayEntry?.remove();

    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onLongPress: _open,
        child: widget.child,
      ),
    );
  }

  OverlayEntry _getOverlay() {
    final Size screen = MediaQuery.of(context).size;

    Size? size;

    Offset? currentLocation;

    bool inSafeArea = true;

    if (mounted) {
      size = context.size;

      final RenderBox? box = context.findRenderObject() as RenderBox?;
      currentLocation = box?.localToGlobal(Offset.zero);
    }

    if (size != null && currentLocation != null) {
      inSafeArea =
          (currentLocation.dy + size.height + 4 + widget.optionHeight) <
              screen.height;
    }

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
                    onTap: _close, child: Container(color: Colors.black26))),
            CompositedTransformFollower(
              showWhenUnlinked: false,
              link: _layerLink,
              followerAnchor:
                  widget.onLeft ? Alignment.topLeft : Alignment.topRight,
              targetAnchor:
                  widget.onLeft ? Alignment.topLeft : Alignment.topRight,
              child: widget.child,
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              child: widget.option,
              offset: Offset(0, inSafeArea ? 4 : -4),
              followerAnchor: !widget.onLeft
                  ? inSafeArea
                      ? Alignment.topRight
                      : Alignment.bottomRight
                  : inSafeArea
                      ? Alignment.topLeft
                      : Alignment.bottomLeft,
              targetAnchor: !widget.onLeft
                  ? inSafeArea
                      ? Alignment.bottomRight
                      : Alignment.topRight
                  : inSafeArea
                      ? Alignment.bottomLeft
                      : Alignment.topLeft,
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _close();
    super.deactivate();
  }
}
