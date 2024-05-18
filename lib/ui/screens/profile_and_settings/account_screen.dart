import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iauth_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/action_button.dart';
import 'package:twg/ui/common_widgets/custom_rive_nav.dart';
import 'package:twg/ui/screens/profile_and_settings/widget/profile_menu_widget.dart';
import 'package:lottie/lottie.dart' as lottie;
part './widget/header.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  late IProfileViewModel _iProfileViewModel;
  late IAuthViewModel _iAuthViewModel;

  void _modalBottomSheetLogout(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 200.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Column(
                  children: [
                    const Text(
                      "Đăng xuất",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Bạn chắc chắn muốn đăng xuất?",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionButton(
                          onTap: () async {
                            await _iAuthViewModel.logout();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorUtils.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const Center(
                              child: Text(
                                'Vâng, Đăng xuất',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        ActionButton(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 219, 219),
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const Center(
                              child: Text(
                                'Hủy',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }

  @override
  void initState() {
    _iAuthViewModel = context.read<IAuthViewModel>();
    _iProfileViewModel = context.read<IProfileViewModel>();
    Future.delayed(Duration.zero, () async {
      await _iProfileViewModel.getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: const BottomNavBarV2(
        currentIndex: 4,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Cá nhân',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            10.r,
          ),
          child: Consumer<IProfileViewModel>(
            builder: (context, vm, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      top: 15.h,
                    ),
                    child: Text(
                      'Tùy chọn',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ProfileMenuWidget(
                    title: "Cập nhật thông tin cá nhân",
                    icon: LineAwesomeIcons.person_entering_booth,
                    onPress: () {
                      Get.offNamed(MyRouter.updateProfile);
                    },
                  ),
                  ProfileMenuWidget(
                    title: "Chuyến đi",
                    icon: LineAwesomeIcons.user_check,
                    onPress: () {
                      Get.offNamed(MyRouter.myBooking);
                    },
                  ),
                  ProfileMenuWidget(
                      title: "Yêu cầu",
                      icon: LineAwesomeIcons.react,
                      onPress: () {
                        Get.offNamed(MyRouter.myApply);
                      }),
                  ProfileMenuWidget(
                    title: "Đánh giá",
                    icon: LineAwesomeIcons.star,
                    onPress: () {
                      Get.offNamed(MyRouter.myReview);
                    },
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Divider(
                      color: Colors.grey.withOpacity(
                        0.1,
                      ),
                      thickness: 2,
                    ),
                  ),
                  ProfileMenuWidget(
                    title: "Chính sách quyền riêng tư",
                    icon: LineAwesomeIcons.lock,
                    onPress: () {
                      Get.offNamed(MyRouter.privacyPolicy);
                    },
                  ),
                  SizedBox(height: 10.h),
                  ProfileMenuWidget(
                    title: "Đăng xuất",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      _modalBottomSheetLogout(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
