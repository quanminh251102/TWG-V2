import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/isplash_screen_view_model.dart';

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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/splash.png',
              ),
            ),
          ),
        ));
  }
}
