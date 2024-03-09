import 'package:flutter/material.dart';
import 'spring_button.dart';

class ActionButton extends StatefulWidget {
  // final bool isChange;
  // final bool isLoading;
  final VoidCallback onTap;
  final Color? colorButtontl;
  final Color? colorButtonbr;
  final double? width;
  final double? height;
  final String? text;
  final Color? colorText;
  final Widget? iconWidget;
  final Widget child;
  const ActionButton({
    Key? key,
    required this.onTap,
    this.colorButtontl,
    this.colorButtonbr,
    this.width,
    this.height,
    this.text,
    this.colorText,
    this.iconWidget,
    required this.child,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return SpringButton(
      AnimatedContainer(
        duration: const Duration(milliseconds: 125),
        width: widget.width ?? 230,
        height: widget.height ?? 50,
        curve: Curves.decelerate,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: widget.colorButtonbr ?? Colors.black),
        child: Center(child: widget.child),
      ),
      useCache: false,
      onTap: () async {
        widget.onTap();
      },
    );
  }
}
