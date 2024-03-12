// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/confirm_login_dialog.dart';
import 'package:twg/ui/screens/booking/widget/create_post_bottom_sheet.dart';

class BottomNavBarV2 extends StatefulWidget {
  final int currentIndex;
  const BottomNavBarV2({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  setBottomBarIndex(index) {
    switch (index) {
      case 0:
        Get.toNamed(MyRouter.home);
        break;
      case 1:
        Get.toNamed(MyRouter.booking);
        break;

      case 3:
        Get.toNamed(MyRouter.chatRoom);
        break;
      case 4:
        Get.toNamed(MyRouter.profile);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 80.h,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3.w,
                    color: Colors.white.withOpacity(
                      0.5,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                backgroundColor: ColorUtils.primaryColor,
                elevation: 0.1,
                onPressed: () {
                  if (locator<GlobalData>().currentUser != null) {
                    Get.bottomSheet(
                      const CreatePostSheet(),
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    );
                  } else {
                    Get.dialog(
                      const ConfirmLoginDialog(),
                    );
                  }
                },
                child: const Icon(Icons.add)),
          ),
          Container(
            width: size.width,
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home_outlined,
                    color: widget.currentIndex == 0
                        ? ColorUtils.primaryColor
                        : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    setBottomBarIndex(0);
                  },
                  splashColor: Colors.white,
                ),
                IconButton(
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: widget.currentIndex == 1
                          ? ColorUtils.primaryColor
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(1);
                    }),
                Container(
                  width: size.width * 0.20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      color: widget.currentIndex == 3
                          ? ColorUtils.primaryColor
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(3);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.person_2_outlined,
                      color: widget.currentIndex == 4
                          ? ColorUtils.primaryColor
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(4);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
