import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iauth_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/action_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late TextEditingController email;
  late TextEditingController password;
  late GlobalKey<FormState> _formKey;
  late IAuthViewModel _iAuthViewModel;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    emailFocus.addListener(() {
      setState(() {});
    });
    passwordFocus.addListener(() {
      setState(() {});
    });
    _formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
    _iAuthViewModel = context.read<IAuthViewModel>();

    // checkLastLogin();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  clearTextData() {
    email.clear();
    password.clear();
  }

  ScaffoldFeatureController buildErrorLayout(e) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e),
        ),
      );
  @override
  Widget build(BuildContext context) {
    void init_app() async {
      // appSocket.init(appUser.id);
      // BlocProvider.of<MessageCubit>(context).init_socket_message = false;
      // BlocProvider.of<CallingAudioCubit>(context).init_socket = false;

      // BlocProvider.of<MessageCubit>(context).init_socket();
      // BlocProvider.of<CallingAudioCubit>(context).init_socket_calling_audio();
      // BlocProvider.of<ChatRoomsCubit>(context).init_socket_chat_room();
      // BlocProvider.of<NotificationCubit>(context).init_socket_notifications();
    }

    return PopScope(
      onPopInvoked: (didPop) {
        didPop = false;
      },
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        bottom: 20.h,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 150.h,
                          width: 250.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      'Đăng nhập',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              focusNode: emailFocus,
                              controller: email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vui lòng nhập email";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: emailFocus.hasFocus
                                    ? ColorUtils.primaryColor.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: ColorUtils.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.1),
                                    width: 2.0,
                                  ),
                                ),
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: emailFocus.hasFocus
                                      ? ColorUtils.primaryColor
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              focusNode: passwordFocus,
                              controller: password,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vui lòng nhập mật khẩu";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                  focusColor: Colors.black,
                                  filled: true, //<-- SEE HERE
                                  fillColor: passwordFocus.hasFocus
                                      ? ColorUtils.primaryColor.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: ColorUtils.primaryColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.1),
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: 'Mật khẩu',
                                  prefixIcon: Icon(Icons.password_outlined,
                                      color: passwordFocus.hasFocus
                                          ? ColorUtils.primaryColor
                                          : Colors.black),
                                  suffixIcon: Icon(
                                    Icons.lock_outline,
                                    color: passwordFocus.hasFocus
                                        ? ColorUtils.primaryColor
                                        : Colors.black,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Center(
                              child: ActionButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await _iAuthViewModel.login(
                                    email.text, password.text);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtils.primaryColor,
                                borderRadius: BorderRadius.circular(
                                  10.r,
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Center(
                                child: Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              // BlocProvider.of<ForgotPasswordCubit>(context).init();
                              // appRouter.push(const ForgotPasswordScreenRoute());
                            },
                            child: const Center(
                              child: Text(
                                'Quên mật khẩu? ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorUtils.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.2,
                                color: Colors.black,
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Hoặc đăng nhập bằng",
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 0.2,
                                color: Colors.black,
                              )),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  // BlocProvider.of<SigninCubit>(context)
                                  //     .SignInWithGoogle();
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/google_box.svg',
                                  height: 45,
                                  width: 45,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Bạn chưa có tài khoản? ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.toNamed(
                                            MyRouter.signUp,
                                          ),
                                    text: 'Đăng ký tại đây',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      )),
    );
  }
}
