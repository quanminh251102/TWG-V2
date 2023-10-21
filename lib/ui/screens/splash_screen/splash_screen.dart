import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/isplash_screen_view_model.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/color_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ISplashScreenViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = context.read<ISplashScreenViewModel>();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    await _viewModel.goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/splash.json",
              height: 200.h,
              repeat: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'WE GO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 45.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
