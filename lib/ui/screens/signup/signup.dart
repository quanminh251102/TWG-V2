import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iauth_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/action_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;
  late FocusNode passwordConFirmFocus;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController email;
  late TextEditingController passwordConfirm;
  late GlobalKey<FormState> _formKey;
  late IAuthViewModel _iAuthViewModel;
  @override
  void initState() {
    super.initState();
    _iAuthViewModel = context.read<IAuthViewModel>();
    usernameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    passwordConFirmFocus = FocusNode();
    usernameFocus.addListener(() {
      setState(() {});
    });
    emailFocus.addListener(() {
      setState(() {});
    });
    passwordConFirmFocus.addListener(() {
      setState(() {});
    });
    passwordFocus.addListener(() {
      setState(() {});
    });
    passwordConFirmFocus.addListener(() {
      setState(() {});
    });
    _formKey = GlobalKey<FormState>();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirm = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    super.dispose();
  }

  clearTextData() {
    username.clear();
    email.clear();
    password.clear();
    passwordConfirm.clear();
  }

  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text('Mật khẩu không khớp!'),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        child: Container(
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0.h,
                bottom: 10.h,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 250.h,
                  width: 250.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.2),
              child: Text(
                'Tạo tài khoản',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      focusNode: usernameFocus,
                      controller: username,
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: usernameFocus.hasFocus
                            ? ColorUtils.primaryColor.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: ColorUtils.primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Họ và tên',
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: usernameFocus.hasFocus
                              ? ColorUtils.primaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
                          borderSide:
                              const BorderSide(color: ColorUtils.primaryColor),
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      focusNode: passwordConFirmFocus,
                      controller: passwordConfirm,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Vui lòng nhập mật khẩu";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          focusColor: Colors.black,
                          filled: true, //<-- SEE HERE
                          fillColor: passwordConFirmFocus.hasFocus
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
                          hintText: 'Xác nhận mật khẩu',
                          prefixIcon: Icon(Icons.password_outlined,
                              color: passwordFocus.hasFocus
                                  ? ColorUtils.primaryColor
                                  : Colors.black),
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            color: passwordConFirmFocus.hasFocus
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
                        await _iAuthViewModel.signUp(
                          email.text,
                          username.text,
                          password.text,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorUtils.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Center(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Bạn đã có tài khoản? ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(
                                    MyRouter.signIn,
                                  ),
                            text: 'Đăng nhập tại đây',
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
    ));
  }
}
