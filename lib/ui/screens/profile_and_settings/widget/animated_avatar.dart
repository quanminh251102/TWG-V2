// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart' as lottie;

class AnimatedAvatar extends StatefulWidget {
  final String avatarUrl;
  const AnimatedAvatar({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);
  @override
  State<AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final bool _isLoadingForUpdateProfilePage = false;
  final bool _isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: CachedNetworkImage(
        imageUrl: widget.avatarUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(60.0) //                 <--- border radius here
                ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => SizedBox(
          width: 50.w,
          height: 50.w,
          child: lottie.Lottie.asset(
            "assets/lottie/loading_image.json",
            repeat: true,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
