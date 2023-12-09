import 'package:flutter/material.dart';

class SpringSlideTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback? onEnd;

  const SpringSlideTransition({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 900),
    this.onEnd,
  }) : super(key: key);

  @override
  _SpringSlideTransitionState createState() => _SpringSlideTransitionState();
}

class _SpringSlideTransitionState extends State<SpringSlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onEnd?.call();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
