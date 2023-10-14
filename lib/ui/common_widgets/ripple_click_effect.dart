import 'package:flutter/material.dart';

/// Widget that shows ripple effect on clicked
class RippleClickEffect extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final BorderRadius? borderRadius;
  final Color color;

  const RippleClickEffect({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      color: color,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
