// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../config/router/app_router.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../utils/showSnackbar.dart';
// import '../../cubits/forgot_password/forgot_password_cubit.dart';
// import 'reset_password.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   late FocusNode emailFocus;
//   late TextEditingController email;
//   late GlobalKey<FormState> _formKey;
//   bool canResendGmail = true;

//   @override
//   void initState() {
//     super.initState();
//     emailFocus = FocusNode();
//     email = TextEditingController();
//     _formKey = GlobalKey<FormState>();
//   }

//   @override
//   void dispose() {
//     email.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
//           listener: (context, state) async {
//         if (state is ForgotPasswordLoaded) {
//           if (state.isEmailVerified == true && state.status != '') {
//             if (state.status == 'pass') {
//               showSnackBar(context, 'Đổi mật khẩu thành công');
//             }
//             if (state.status == 'error') {
//               showSnackBar(context, 'Đã xảy ra lổi, vui lòng đổi mật khẩu lại');
//             }
//             await Future.delayed(const Duration(seconds: 3));
//             appRouter.push(const SignInViewRoute());
//           }
//         }
//       }, builder: (context, state) {
//         if (state is ForgotPasswordLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is ForgotPasswordLoaded) {
//           return (!state.isEmailVerified)
//               ? Scaffold(
//                   appBar: AppBar(
//                     title: const Text('ForgotPasswordScreen'),
//                   ),
//                   body: Form(
//                     key: _formKey,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
//                       child: Column(children: [
//                         TextFormField(
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                           focusNode: emailFocus,
//                           controller: email,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Vui lòng nhập email";
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             filled: true, //<-- SEE HERE
//                             fillColor: emailFocus.hasFocus
//                                 ? AppColors.primaryColor.withOpacity(0.1)
//                                 : Colors.grey.withOpacity(0.1),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: const BorderSide(
//                                   color: AppColors.primaryColor),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 width: 2.0,
//                               ),
//                             ),
//                             hintText: 'Email',
//                             prefixIcon: Icon(
//                               Icons.email_outlined,
//                               color: emailFocus.hasFocus
//                                   ? AppColors.primaryColor
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 24,
//                         ),
//                         (state.canEmailSend)
//                             ? ElevatedButton(
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     BlocProvider.of<ForgotPasswordCubit>(
//                                             context)
//                                         .sendEmail(
//                                             this.email.text.trim(), context);
//                                   }
//                                 },
//                                 child: const Text('Gửi email xác nhận'),
//                               )
//                             : const Center(
//                                 child: CircularProgressIndicator(),
//                               )
//                       ]),
//                     ),
//                   ),
//                 )
//               : const ResetPasswordScreen();
//         } else {
//           return const Center(child: Text('Error'));
//         }
//       }),
//     );
//   }
// }
