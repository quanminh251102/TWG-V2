import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/utils/color_utils.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      height: 200.h,
      decoration: const BoxDecoration(
        color: ColorUtils.primaryColor,
      ),
    );
    // CarouselSlider(
    //     options: CarouselOptions(
    //       viewportFraction: 1,
    //       aspectRatio: 2.2,
    //       enlargeCenterPage: true,
    //       enableInfiniteScroll: false,
    //       initialPage: 0,
    //       autoPlay: true,
    //       autoPlayInterval: const Duration(seconds: 5),
    //     ),
    //     items: imagePath
    //         .map((item) => ClipRRect(
    //             borderRadius: BorderRadius.all(Radius.circular(5.r)),
    //             child: Image.network(
    //               '$baseUrl/${item.imagePath ?? ''}',
    //               fit: BoxFit.cover,
    //               width: 1000.w,
    //               errorBuilder: (BuildContext context, Object exception,
    //                   StackTrace? stackTrace) {
    //                 return Image.asset(
    //                   'assets/images/img.png',
    //                   width: 1000.w,
    //                   fit: BoxFit.cover,
    //                 );
    //               },
    //             )))
    //         .toList());
  }
}
