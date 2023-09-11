// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBtn extends StatefulWidget {
  SvgPicture? icon;
  final Function onPressed;
  Function? onReleased;
  Widget? children;
  IconBtn({
    Key? key,
    this.icon,
    required this.onPressed,
    this.onReleased,
    this.children,
  }) : super(key: key);

  @override
  _IconBtnState createState() => _IconBtnState();
}

class _IconBtnState extends State<IconBtn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Set up the scale animation
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        widget.onPressed;
      },
      onTapUp: (_) {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.icon,
      ),
    );
  }
}
