import 'package:flutter/material.dart';

enum TooltipDirection { left, right, top, bottom }

enum TooltipBottomStart { left, right, center }

enum TooltipTopStart { left, right, center }

const Map<TooltipBottomStart, Alignment> _tooltipBottomAlignment = {
  TooltipBottomStart.left: Alignment.topLeft,
  TooltipBottomStart.center: Alignment.topCenter,
  TooltipBottomStart.right: Alignment.topRight,
};

const Map<TooltipTopStart, Alignment> _tooltipTopAlignment = {
  TooltipTopStart.left: Alignment.bottomLeft,
  TooltipTopStart.center: Alignment.bottomCenter,
  TooltipTopStart.right: Alignment.bottomRight,
};

class CustomToolTipController {
  late CustomToolTipState _state;

  void close() {
    _state._close();
  }

  void open() {
    _state._open();
  }

  bool get isOpen => _state.show;
}

class CustomToolTip extends StatefulWidget {
  final Widget child;
  final TooltipDirection direction;
  final Color? toolTipBackgroundColor, barrierColor;
  final Widget tooltip;
  final VoidCallback? onTapTooltip, onTapChild;
  final bool disabled, fitSize, barrierDismissible, fitScreen;
  final bool? initShow;
  final num tooltipSpace;
  final TooltipBottomStart tooltipBottomStart;
  final TooltipTopStart tooltipTopStart;
  final CustomToolTipController? controller;

  const CustomToolTip({
    Key? key,
    required this.child,
    this.direction = TooltipDirection.right,
    this.toolTipBackgroundColor = Colors.transparent,
    required this.tooltip,
    this.onTapTooltip,
    this.initShow,
    this.disabled = false,
    this.barrierDismissible = false,
    this.fitScreen = false,
    this.onTapChild,
    this.tooltipSpace = 4,
    this.tooltipBottomStart = TooltipBottomStart.center,
    this.tooltipTopStart = TooltipTopStart.center,
    this.controller,
    this.fitSize = false,
    this.barrierColor,
  }) : super(key: key);

  @override
  State<CustomToolTip> createState() => CustomToolTipState();
}

class CustomToolTipState extends State<CustomToolTip> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool show = false;

  @override
  void initState() {
    _initController();
    if (widget.initShow == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _onChanged(false);
      });
    }

    super.initState();
  }

  void _initController() {
    if (widget.controller != null) {
      widget.controller!._state = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.disabled ? null : _onChanged,
        child: widget.child,
      ),
    );
  }

  void _close() {
    if (show) {
      _overlayEntry?.remove();
      show = false;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) setState(() {});
      });
    }
  }

  void _open() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!show) {
          _overlayEntry = _getOverlay();
          Overlay.of(context).insert(_overlayEntry!);
          show = true;
        }
      });
    }
  }

  void _onChanged([bool hasCallback = true]) {
    if (mounted) {
      if (!show) {
        _overlayEntry = _getOverlay();
        Overlay.of(context).insert(_overlayEntry!);
        show = true;
      } else {
        _overlayEntry?.remove();
        show = false;
      }

      if (mounted) setState(() {});

      if (hasCallback) {
        widget.onTapChild?.call();
      }
    }
  }

  OverlayEntry _getOverlay() {
    Size? size;
    Offset? currentPosition;
    if (mounted) {
      size = context.size;
      if (context.findRenderObject() != null) {
        final RenderBox box = context.findRenderObject()! as RenderBox;
        currentPosition = box.localToGlobal(Offset.zero);
      }
    }
    return OverlayEntry(
      maintainState: true,
      builder: (ctx) => Stack(
        children: [
          if (widget.barrierDismissible)
            GestureDetector(
              onTap: _close,
              child:
                  Container(color: widget.barrierColor ?? Colors.transparent),
            ),
          Positioned(child: _getToolTipBody(size, currentPosition)),
        ],
      ),
    );
  }

  Widget _getToolTipBody(Size? size, Offset? currentPosition) {
    switch (widget.direction) {
      case TooltipDirection.right:
        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: Alignment.centerLeft,
            offset: Offset((size?.width ?? 0) + widget.tooltipSpace.toDouble(),
                (size?.height ?? 0) / 2),
            child: SizedBox(
              height: widget.fitSize ? size?.height ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
      case TooltipDirection.left:
        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: Alignment.centerRight,
            offset: Offset(
                -widget.tooltipSpace.toDouble(), (size?.height ?? 0) / 2),
            child: SizedBox(
              height: widget.fitSize ? size?.height ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
      case TooltipDirection.bottom:
        Offset offset = Offset.zero;
        switch (widget.tooltipBottomStart) {
          case TooltipBottomStart.left:
            offset =
                Offset(0, (size?.height ?? 0) + widget.tooltipSpace.toDouble());
            break;
          case TooltipBottomStart.center:
            offset = Offset((size?.width ?? 0) / 2,
                (size?.height ?? 0) + widget.tooltipSpace.toDouble());
            break;
          case TooltipBottomStart.right:
            offset = Offset(size?.width ?? 0,
                (size?.height ?? 0) + widget.tooltipSpace.toDouble());
            break;
        }

        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: _tooltipBottomAlignment[widget.tooltipBottomStart]!,
            offset: offset,
            child: SizedBox(
              width: widget.fitSize ? size?.width ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
      case TooltipDirection.top:
        Offset offset = Offset.zero;
        if (!widget.fitScreen) {
          switch (widget.tooltipTopStart) {
            case TooltipTopStart.left:
              offset = Offset(0, -widget.tooltipSpace.toDouble());
              break;
            case TooltipTopStart.center:
              offset = Offset(
                  (size?.width ?? 0) / 2, -widget.tooltipSpace.toDouble());
              break;
            case TooltipTopStart.right:
              offset =
                  Offset(size?.width ?? 0, -widget.tooltipSpace.toDouble());
              break;
          }
        } else {
          offset = Offset(
              -(currentPosition?.dx ?? 0), -widget.tooltipSpace.toDouble());
        }

        return CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            followerAnchor: widget.fitScreen
                ? Alignment.bottomLeft
                : _tooltipTopAlignment[widget.tooltipTopStart]!,
            offset: offset,
            child: SizedBox(
              width: widget.fitSize ? size?.width ?? 0 : null,
              child: Material(
                color: widget.toolTipBackgroundColor,
                child: GestureDetector(
                  onTap: () {
                    widget.onTapTooltip?.call();
                    _onChanged(false);
                  },
                  child: widget.tooltip,
                ),
              ),
            ));
    }
  }

  @override
  void didUpdateWidget(covariant CustomToolTip oldWidget) {
    if (show && widget.initShow == false) {
      _overlayEntry?.remove();
      show = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _close();
    });
    super.dispose();
  }
}
