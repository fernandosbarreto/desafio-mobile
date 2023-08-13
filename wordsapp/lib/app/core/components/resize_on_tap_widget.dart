import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResizeOnTapWidget extends StatefulWidget {
  final Widget child;
  final bool runStartAnimation;
  final bool enabled;
  final double begin;
  const ResizeOnTapWidget({
    Key? key,
    required this.child,
    this.runStartAnimation = true,
    this.enabled = true,
    this.begin = 0.9,
  }) : super(key: key);

  @override
  State<ResizeOnTapWidget> createState() => _ResizeOnTapWidgetState();
}

class _ResizeOnTapWidgetState extends State<ResizeOnTapWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late bool enabled;

  @override
  void initState() {
    super.initState();
    enabled = widget.enabled;
    final double initialControllerValue = widget.runStartAnimation ? 0 : 1;
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        value: initialControllerValue);
    _sizeAnimation = Tween<double>(begin: widget.begin, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.elasticOut));
    if (widget.runStartAnimation) _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ResizeOnTapWidget oldWidget) {
    enabled = widget.enabled;
    super.didUpdateWidget(oldWidget);
  }

  void onDown() {
    if (enabled) {
      _sizeAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.ease));
      _animationController.reset();
      _animationController.forward();
    }
  }

  void onUp() {
    if (enabled) {
      _sizeAnimation =
          Tween<double>(begin: min(_sizeAnimation.value, 0.90), end: 1.0)
              .animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.elasticOut));
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        CustomPanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomPanGestureRecognizer>(
          () => CustomPanGestureRecognizer(
            onPanDown: (_) {
              onDown();
              return true;
            },
            onPanEnd: (_) => onUp(),
          ),
          (CustomPanGestureRecognizer instance) {},
        ),
      },
      child: AnimatedBuilder(
        animation: _sizeAnimation,
        child: widget.child,
        builder: (context, child) =>
            Transform.scale(scale: _sizeAnimation.value, child: child),
      ),
    );
  }
}

class CustomPanGestureRecognizer extends OneSequenceGestureRecognizer {
  final bool Function(Offset position)? onPanDown;
  final Function? onPanUpdate;
  final FutureOr<void> Function(Offset position)? onPanEnd;

  CustomPanGestureRecognizer({this.onPanDown, this.onPanUpdate, this.onPanEnd});

  @override
  void addPointer(PointerEvent event) {
    if (onPanDown?.call(event.position) ?? false) {
      startTrackingPointer(event.pointer);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onPanUpdate?.call(event.position);
    }
    if (event is PointerCancelEvent) {
      onPanEnd?.call(event.position);
      stopTrackingPointer(event.pointer);
    }
    if (event is PointerUpEvent) {
      onPanEnd?.call(event.position);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
