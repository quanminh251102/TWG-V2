// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';

// import '../../../utils/constants/colors.dart';
// import '../../../utils/showSnackbar.dart';
// import '../../cubits/forgot_password/forgot_password_cubit.dart';
// import '../homepage/signin/widget/app_icon_button.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   const ResetPasswordScreen({super.key});

//   @override
//   State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   late FocusNode passwordFocus;
//   late FocusNode passwordConFirmFocus;
//   late TextEditingController password;
//   late TextEditingController passwordConfirm;
//   late GlobalKey<FormState> _formKey;
//   @override
//   void initState() {
//     super.initState();

//     passwordFocus = FocusNode();
//     passwordConFirmFocus = FocusNode();

//     passwordConFirmFocus.addListener(() {
//       setState(() {});
//     });
//     passwordFocus.addListener(() {
//       setState(() {});
//     });
//     passwordConFirmFocus.addListener(() {
//       setState(() {});
//     });
//     _formKey = GlobalKey<FormState>();
//     password = TextEditingController();
//     passwordConfirm = TextEditingController();
//   }

//   @override
//   void dispose() {
//     password.dispose();
//     passwordConfirm.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ResetPasswordScreen'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
//         child: Form(
//           key: _formKey,
//           child: Column(children: [
//             TextFormField(
//               style: const TextStyle(fontWeight: FontWeight.bold),
//               focusNode: passwordFocus,
//               controller: this.password,
//               obscureText: true,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Vui lòng nhập mật khẩu";
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                   labelStyle: const TextStyle(fontWeight: FontWeight.w600),
//                   focusColor: Colors.black,
//                   filled: true, //<-- SEE HERE
//                   fillColor: passwordFocus.hasFocus
//                       ? AppColors.primaryColor.withOpacity(0.1)
//                       : Colors.grey.withOpacity(0.1),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(color: AppColors.primaryColor),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                       color: Colors.grey.withOpacity(0.1),
//                       width: 2.0,
//                     ),
//                   ),
//                   hintText: 'Mật khẩu',
//                   prefixIcon: Icon(Icons.password_outlined,
//                       color: passwordFocus.hasFocus
//                           ? AppColors.primaryColor
//                           : Colors.black),
//                   suffixIcon: Icon(
//                     Icons.lock_outline,
//                     color: passwordFocus.hasFocus
//                         ? AppColors.primaryColor
//                         : Colors.black,
//                   )),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             TextFormField(
//               style: const TextStyle(fontWeight: FontWeight.bold),
//               focusNode: this.passwordConFirmFocus,
//               controller: passwordConfirm,
//               obscureText: true,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Vui lòng nhập mật khẩu";
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                   labelStyle: const TextStyle(fontWeight: FontWeight.w600),
//                   focusColor: Colors.black,
//                   filled: true, //<-- SEE HERE
//                   fillColor: passwordConFirmFocus.hasFocus
//                       ? AppColors.primaryColor.withOpacity(0.1)
//                       : Colors.grey.withOpacity(0.1),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(color: AppColors.primaryColor),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(
//                       color: Colors.grey.withOpacity(0.1),
//                       width: 2.0,
//                     ),
//                   ),
//                   hintText: 'Xác nhận mật khẩu',
//                   prefixIcon: Icon(Icons.password_outlined,
//                       color: passwordFocus.hasFocus
//                           ? AppColors.primaryColor
//                           : Colors.black),
//                   suffixIcon: Icon(
//                     Icons.lock_outline,
//                     color: passwordConFirmFocus.hasFocus
//                         ? AppColors.primaryColor
//                         : Colors.black,
//                   )),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Center(
//               child: ActionButton(
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     String password = this.password.text.trim();
//                     String passwordConfirm = this.passwordConfirm.text.trim();
//                     if (password != passwordConfirm) {
//                       showSnackBar(
//                           context, 'Mật khẩu khác với mật khẩu xác nhận');
//                     } else {
//                       BlocProvider.of<ForgotPasswordCubit>(context)
//                           .resetPassword(password, context);
//                     }
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(25)),
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: const Center(
//                     child: Text(
//                       'Tiếp tục',
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
