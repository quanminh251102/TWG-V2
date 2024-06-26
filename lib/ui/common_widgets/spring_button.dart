import 'package:flutter/material.dart';

class SpringButton extends StatefulWidget {
  final Widget uiChild;
  final bool useCache;
  final Alignment alignment;
  final double scaleCoefficient;
  final int duration;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onTap;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureDragDownCallback? onVerticalDragDown;
  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragCancelCallback? onVerticalDragCancel;
  final GestureDragDownCallback? onHorizontalDragDown;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;
  final GestureDragDownCallback? onPanDown;
  final GestureDragStartCallback? onPanStart;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final GestureDragCancelCallback? onPanCancel;
  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;
  final GestureForcePressStartCallback? onForcePressStart;
  final GestureForcePressPeakCallback? onForcePressPeak;
  final GestureForcePressUpdateCallback? onForcePressUpdate;
  final GestureForcePressEndCallback? onForcePressEnd;

  const SpringButton(
    this.uiChild, {
    Key? key,
    this.useCache = true,
    this.alignment = Alignment.center,
    this.scaleCoefficient = 0.75,
    this.duration = 1000,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
  })  : assert(scaleCoefficient >= 0.0 && scaleCoefficient <= 1.0),
        super(key: key);

  @override
  SpringButtonState createState() => SpringButtonState(
        useCache,
        alignment,
        scaleCoefficient,
      );
}

class SpringButtonState extends State<SpringButton>
    with SingleTickerProviderStateMixin {
  Widget? uiChild;
  final bool useCache;
  final Alignment alignment;
  final double scaleCoefficient;

  late AnimationController animationController;
  late Animation<double> animation;

  bool isSpringDown = false;

  bool isEnabled = true;

  final int _debugLevel = 0;

  SpringButtonState(
    this.useCache,
    this.alignment,
    this.scaleCoefficient,
  );

  @override
  void initState() {
    super.initState();

    if (useCache) uiChild = wrapper();

    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: widget.duration),
    );
    animationController.value = 1;
    animation = Tween(
      begin: scaleCoefficient,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  bool get hasMultiple {
    List<bool> list = [
      hasTap,
      hasSecondaryTap,
      hasDoubleTap,
      hasLongPress,
      hasVerticalDrag,
      hasHorizontalDrag,
      hasForcePress,
      hasPan,
      hasScale
    ];
    return list.where((bool b) => b).length > 1;
  }

  bool get hasTap =>
      widget.onTapDown != null ||
      widget.onTapUp != null ||
      widget.onTap != null ||
      widget.onTapCancel != null;
  bool get hasSecondaryTap =>
      widget.onSecondaryTapDown != null ||
      widget.onSecondaryTapUp != null ||
      widget.onSecondaryTapCancel != null;
  bool get hasDoubleTap => widget.onDoubleTap != null;
  bool get hasLongPress =>
      widget.onLongPress != null ||
      widget.onLongPressStart != null ||
      widget.onLongPressMoveUpdate != null ||
      widget.onLongPressUp != null ||
      widget.onLongPressEnd != null;
  bool get hasVerticalDrag =>
      widget.onVerticalDragDown != null ||
      widget.onVerticalDragStart != null ||
      widget.onVerticalDragUpdate != null ||
      widget.onVerticalDragEnd != null ||
      widget.onVerticalDragCancel != null;
  bool get hasHorizontalDrag =>
      widget.onHorizontalDragDown != null ||
      widget.onHorizontalDragStart != null ||
      widget.onHorizontalDragUpdate != null ||
      widget.onHorizontalDragEnd != null ||
      widget.onHorizontalDragCancel != null;
  bool get hasForcePress =>
      widget.onForcePressStart != null ||
      widget.onForcePressPeak != null ||
      widget.onForcePressUpdate != null ||
      widget.onForcePressEnd != null;
  bool get hasPan =>
      widget.onPanDown != null ||
      widget.onPanStart != null ||
      widget.onPanUpdate != null ||
      widget.onPanCancel != null;
  bool get hasScale =>
      widget.onScaleStart != null ||
      widget.onScaleUpdate != null ||
      widget.onScaleEnd != null;

  void enable() {
    if (!isEnabled) {
      animationController.value = 1.0;
      isSpringDown = false;
      isEnabled = true;
    }
  }

  void disable() {
    if (isEnabled) {
      animationController.value = 1.0;
      isSpringDown = false;
      isEnabled = false;
    }
  }

  void springDown() {
    if (!isEnabled) return;

    if (_debugLevel > 0) print("springDown");

    isSpringDown = true;
    animationController.value = 0;
  }

  Future spring() async {
    if (!isEnabled) return;

    if (_debugLevel > 0) print("spring-1");

    isSpringDown = false;

    if (hasMultiple) await Future.delayed(const Duration(milliseconds: 5));

    if (_debugLevel > 0) print("spring-2");

    if (!isSpringDown) animationController.forward();
  }

  Future springUp() async {
    if (!isEnabled) return;

    if (_debugLevel > 0) print("springUp-1");

    isSpringDown = false;

    if (hasMultiple) await Future.delayed(const Duration(milliseconds: 500));

    if (_debugLevel > 0) print("springUp-2");

    if (!isSpringDown) animationController.value = 1;
  }

  Widget wrapper() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: !hasTap
          ? null
          : (_) {
              springDown();
              if (widget.onTapDown != null && isEnabled) widget.onTapDown!(_);
            },
      onTapUp: !hasTap
          ? null
          : (_) {
              spring();
              if (widget.onTapUp != null && isEnabled) widget.onTapUp!(_);
            },
      onTap: !hasTap
          ? null
          : () {
              if (widget.onTap != null && isEnabled) widget.onTap!();
            },
      onTapCancel: !hasTap
          ? null
          : () {
              springUp();
              if (widget.onTapCancel != null && isEnabled) {
                widget.onTapCancel!();
              }
            },
      onSecondaryTapDown: !hasSecondaryTap
          ? null
          : (_) {
              springDown();
              if (widget.onSecondaryTapDown != null && isEnabled) {
                widget.onSecondaryTapDown!(_);
              }
            },
      onSecondaryTapUp: !hasSecondaryTap
          ? null
          : (_) {
              spring();
              if (widget.onSecondaryTapUp != null && isEnabled) {
                widget.onSecondaryTapUp!(_);
              }
            },
      onSecondaryTapCancel: !hasSecondaryTap
          ? null
          : () {
              springUp();
              if (widget.onSecondaryTapCancel != null && isEnabled) {
                widget.onSecondaryTapCancel!();
              }
            },
      onDoubleTap: !hasDoubleTap
          ? null
          : () {
              springDown();
              spring();
              if (widget.onDoubleTap != null && isEnabled) {
                widget.onDoubleTap!();
              }
            },
      onLongPress: !hasLongPress
          ? null
          : () {
              if (widget.onLongPress != null && isEnabled) {
                widget.onLongPress!();
              }
            },
      onLongPressStart: !hasLongPress
          ? null
          : (_) {
              springDown();
              if (widget.onLongPressStart != null && isEnabled) {
                widget.onLongPressStart!(_);
              }
            },
      onLongPressMoveUpdate: !hasLongPress
          ? null
          : (_) {
              if (widget.onLongPressMoveUpdate != null && isEnabled) {
                widget.onLongPressMoveUpdate!(_);
              }
            },
      onLongPressUp: !hasLongPress
          ? null
          : () {
              spring();
              if (widget.onLongPressUp != null && isEnabled) {
                widget.onLongPressUp!();
              }
            },
      onLongPressEnd: !hasLongPress
          ? null
          : (_) {
              if (widget.onLongPressEnd != null && isEnabled) {
                widget.onLongPressEnd!(_);
              }
            },
      onVerticalDragDown: !hasVerticalDrag
          ? null
          : (_) {
              if (widget.onVerticalDragDown != null && isEnabled) {
                widget.onVerticalDragDown!(_);
              }
            },
      onVerticalDragStart: !hasVerticalDrag
          ? null
          : (_) {
              springDown();
              if (widget.onVerticalDragStart != null && isEnabled) {
                widget.onVerticalDragStart!(_);
              }
            },
      onVerticalDragUpdate: !hasVerticalDrag
          ? null
          : (_) {
              if (widget.onVerticalDragUpdate != null && isEnabled) {
                widget.onVerticalDragUpdate!(_);
              }
            },
      onVerticalDragEnd: !hasVerticalDrag
          ? null
          : (_) {
              spring();
              if (widget.onVerticalDragEnd != null && isEnabled) {
                widget.onVerticalDragEnd!(_);
              }
            },
      onVerticalDragCancel: !hasVerticalDrag
          ? null
          : () {
              springUp();
              if (widget.onVerticalDragCancel != null && isEnabled) {
                widget.onVerticalDragCancel!();
              }
            },
      onHorizontalDragDown: !hasHorizontalDrag
          ? null
          : (_) {
              if (widget.onHorizontalDragDown != null && isEnabled) {
                widget.onHorizontalDragDown!(_);
              }
            },
      onHorizontalDragStart: !hasHorizontalDrag
          ? null
          : (_) {
              springDown();
              if (widget.onHorizontalDragStart != null && isEnabled) {
                widget.onHorizontalDragStart!(_);
              }
            },
      onHorizontalDragUpdate: !hasHorizontalDrag
          ? null
          : (_) {
              if (widget.onHorizontalDragUpdate != null && isEnabled) {
                widget.onHorizontalDragUpdate!(_);
              }
            },
      onHorizontalDragEnd: !hasHorizontalDrag
          ? null
          : (_) {
              spring();
              if (widget.onHorizontalDragEnd != null && isEnabled) {
                widget.onHorizontalDragEnd!(_);
              }
            },
      onHorizontalDragCancel: !hasHorizontalDrag
          ? null
          : () {
              springUp();
              if (widget.onHorizontalDragCancel != null && isEnabled) {
                widget.onHorizontalDragCancel!();
              }
            },
      onForcePressStart: !hasForcePress
          ? null
          : (_) {
              springDown();
              if (widget.onForcePressStart != null && isEnabled) {
                widget.onForcePressStart!(_);
              }
            },
      onForcePressPeak: !hasForcePress
          ? null
          : (_) {
              if (widget.onForcePressPeak != null && isEnabled) {
                widget.onForcePressPeak!(_);
              }
            },
      onForcePressUpdate: !hasForcePress
          ? null
          : (_) {
              if (widget.onForcePressUpdate != null && isEnabled) {
                widget.onForcePressUpdate!(_);
              }
            },
      onForcePressEnd: !hasForcePress
          ? null
          : (_) {
              spring();
              if (widget.onForcePressEnd != null && isEnabled) {
                widget.onForcePressEnd!(_);
              }
            },
      onPanDown: !hasPan
          ? null
          : (_) {
              if (widget.onPanDown != null && isEnabled) widget.onPanDown!(_);
            },
      onPanStart: !hasPan
          ? null
          : (_) {
              springDown();
              if (widget.onPanStart != null && isEnabled) widget.onPanStart!(_);
            },
      onPanUpdate: !hasPan
          ? null
          : (_) {
              if (widget.onPanUpdate != null && isEnabled) {
                widget.onPanUpdate!(_);
              }
            },
      onPanEnd: !hasPan
          ? null
          : (_) {
              spring();
              if (widget.onPanEnd != null && isEnabled) widget.onPanEnd!(_);
            },
      onPanCancel: !hasPan
          ? null
          : () {
              springUp();
              if (widget.onPanCancel != null && isEnabled) {
                widget.onPanCancel!();
              }
            },
      onScaleStart: !hasScale
          ? null
          : (_) {
              springDown();
              if (widget.onScaleStart != null && isEnabled) {
                widget.onScaleStart!(_);
              }
            },
      onScaleUpdate: !hasScale
          ? null
          : (_) {
              if (widget.onScaleUpdate != null && isEnabled) {
                widget.onScaleUpdate!(_);
              }
            },
      onScaleEnd: !hasScale
          ? null
          : (_) {
              spring();
              if (widget.onScaleEnd != null && isEnabled) widget.onScaleEnd!(_);
            },
      child: widget.uiChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: useCache ? uiChild : null,
      builder: (BuildContext context, Widget? cachedChild) {
        return Transform.scale(
          scale: animation.value,
          child: useCache ? cachedChild : wrapper(),
        );
      },
    );
  }
}
