import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:twg/global/router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.toNamed(MyRouter.signIn);
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/intro-1.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      imageFlex: 4,
      bodyFlex: 2,
      footerFlex: 1,
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: false,

      pages: [
        PageViewModel(
          title: "Giảm thiểu chi phí",
          body:
              "Thay vì phải chi trả cho toàn bộ chuyến đi, bạn có thể chia sẻ cùng với người khác.",
          image: _buildImage('images/intro-3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Nền tảng tiện dụng",
          body:
              "Tối ưu các bước sử dụng, người dùng dễ dàng tiếp cận được chuyến đi mình muốn.",
          image: _buildImage('images/intro-1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "An toàn là bạn !",
          body:
              "Thông tin cập nhật đầy đủ, chuyến đi được kiểm soát trong suốt quá trình di chuyển.",
          image: _buildImage('images/intro-2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Đi thôi !",
          body:
              "Cùng nhau kết nối, cùng nhau tạo nên một cộng đồng chia sẻ thân thiện và an toàn.",
          image: _buildImage('images/intro-4.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true, showNextButton: true, showDoneButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.white,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
