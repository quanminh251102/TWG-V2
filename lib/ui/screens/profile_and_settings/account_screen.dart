import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/custom_bottom_navigation_bar.dart';
import 'package:twg/ui/screens/profile_and_settings/widget/profile_menu_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  late IProfileViewModel _iProfileViewModel;

  bool _isLoadingForUpdateProfilePage = false;
  bool _isLoadingImage = false;

  void uploadImage(XFile file) async {
    setState(() {
      _isLoadingImage = true;
    });

    var result = await _iProfileViewModel.uploadFile(file);

    if (result != 'error') {
      AccountDto value = _iProfileViewModel.accountDto;

      value.avatarUrl = result;
      //  this._birthday.toString(),
      String text = await _iProfileViewModel.updateProfile(value);

      Get.showSnackbar(
        GetSnackBar(
          title: text,
        ),
      );
    }

    setState(() {
      _isLoadingImage = false;
    });
  }

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
                        GestureDetector(
                          onTap: () {
                            // BlocProvider.of<SigninCubit>(context).Logout();
                            // appRouter.push(const SignInViewRoute());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorUtils.primaryColor,
                                borderRadius: BorderRadius.circular(25)),
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
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 219, 219),
                                borderRadius: BorderRadius.circular(25)),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const Center(
                              child: Text(
                                'Hủy',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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

  void openMediaDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Chọn nguồn',
              style: TextStyle(fontSize: 14),
            ),
            content: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        print("get successfully");
                        uploadImage(image);
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        Text('Máy ảnh')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        uploadImage(image);
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                        });
                        // image.path
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          size: 30,
                        ),
                        Text('Thư viện')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(
        value: CustomNavigationBar.account,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Cá nhân',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            20.r,
          ),
          child: Consumer<IProfileViewModel>(
            builder: (context, vm, child) {
              return Column(
                children: [
                  /// -- IMAGE
                  Stack(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              openMediaDialog();
                            },
                            child: CachedNetworkImage(
                              imageUrl: vm.accountDto.avatarUrl.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          60.0) //                 <--- border radius here
                                      ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            openMediaDialog();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorUtils.primaryColor),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(vm.accountDto.firstName.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      )),
                  Text(vm.accountDto.email.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp,
                      )),

                  SizedBox(
                    height: 20.h,
                  ),
                  ProfileMenuWidget(
                    title: "Cập nhật thông tin cá nhân",
                    icon: LineAwesomeIcons.person_entering_booth,
                    onPress: () {
                      Get.offNamed(MyRouter.updateProfile);
                    },
                  ),
                  ProfileMenuWidget(
                    title: "Chính sách quyền riêng tư",
                    icon: LineAwesomeIcons.lock,
                    onPress: () {
                      Get.offNamed(MyRouter.privacyPolicy);
                    },
                  ),
                  ProfileMenuWidget(
                    title: "Chuyến đi của tôi",
                    icon: LineAwesomeIcons.user_check,
                    onPress: () {
                      Get.offNamed(MyRouter.myBooking);
                    },
                  ),
                  ProfileMenuWidget(
                      title: "Yêu cầu của tôi",
                      icon: LineAwesomeIcons.react,
                      onPress: () {}),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Divider(
                      color: Colors.grey.withOpacity(
                        0.1,
                      ),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ProfileMenuWidget(
                    title: "Đánh giá",
                    icon: LineAwesomeIcons.star,
                    onPress: () {
                      Get.offNamed(MyRouter.myReview);
                    },
                  ),
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
