// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ilocation_viewmodel.dart';

import '../../../global/router.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late IBookingViewModel _iBookingViewModel;
  late ILocationViewModel _iLocationViewModel;
  String message = '';

  void changeMessage(BuildContext context) async {
    setState(() {
      message = 'Đang xác nhận yêu cầu của bạn';
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      message = 'Đang tải danh sách';
    });
    await _iBookingViewModel.getRecommendBooking(
      startPointLat: _iLocationViewModel.startPointGeo!.latitude,
      startPointLong: _iLocationViewModel.startPointGeo!.longitude,
      endPointLat: _iLocationViewModel.endPointGeo!.latitude,
      endPointLong: _iLocationViewModel.endPointGeo!.longitude,
    );
    Get.toNamed(MyRouter.booking, arguments: true);
  }

  @override
  void initState() {
    super.initState();
    _iBookingViewModel = context.read<IBookingViewModel>();
    _iLocationViewModel = context.read<ILocationViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      changeMessage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Lottie.asset('assets/lottie/loading-driving.json',
                  fit: BoxFit.cover),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    );
  }
}
