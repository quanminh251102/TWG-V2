import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/action_button.dart';
import 'package:twg/ui/screens/profile_and_settings/update_profile/widget/gender_chooser.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage>
    with TickerProviderStateMixin {
  late IProfileViewModel _iProfileViewModel;
  late FocusNode nameFocus;
  late FocusNode phoneNumberFocus;
  late TextEditingController name;
  late TextEditingController phoneNumber;

  late GlobalKey<FormState> _formKey;
  late String gender;

  bool _isLoadingUpdate = false;

  @override
  void initState() {
    _iProfileViewModel = context.read<IProfileViewModel>();

    super.initState();

    nameFocus = FocusNode();
    phoneNumberFocus = FocusNode();

    nameFocus.addListener(() {
      setState(() {});
    });
    phoneNumberFocus.addListener(() {
      setState(() {});
    });

    _formKey = GlobalKey<FormState>();

    name = TextEditingController();
    phoneNumber = TextEditingController();

    name.text = _iProfileViewModel.accountDto.firstName.toString();
    phoneNumber.text = _iProfileViewModel.accountDto.phoneNumber ?? "";
    gender = _iProfileViewModel.accountDto.gender ?? "male";
  }

  @override
  void dispose() {
    name.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    formUpdateProfile() => Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              style: const TextStyle(fontWeight: FontWeight.w600),
              focusNode: nameFocus,
              controller: name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Vui lòng nhập tên";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Tên',
                filled: true, //<-- SEE HERE
                fillColor: nameFocus.hasFocus
                    ? ColorUtils.primaryColor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ColorUtils.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 2.0,
                  ),
                ),
                hintText: 'Vui lòng nhập tên',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              style: const TextStyle(fontWeight: FontWeight.w600),
              focusNode: phoneNumberFocus,
              controller: phoneNumber,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Vui lòng nhập số điện thoại";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                filled: true,
                fillColor: phoneNumberFocus.hasFocus
                    ? ColorUtils.primaryColor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: ColorUtils.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 2.0,
                  ),
                ),
                hintText: 'Số điện thoại',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            GenderChooser(
              isMale: gender == "male",
              selectGender: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
            (_isLoadingUpdate)
                ? const CircularProgressIndicator()
                : Center(
                    child: ActionButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            _isLoadingUpdate == false) {
                          setState(() {
                            _isLoadingUpdate = true;
                          });
                          AccountDto value = _iProfileViewModel.accountDto;
                          value.firstName = name.text.trim();
                          value.phoneNumber = phoneNumber.text.trim();
                          value.gender = gender.trim();
                          await EasyLoading.showSuccess(
                              await _iProfileViewModel.updateProfile(value));

                          setState(() {
                            _isLoadingUpdate = false;
                          });
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
                            'Cập nhật',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ]),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cập nhật thông tin cá nhân',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.profile);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: formUpdateProfile(),
        ),
      ),
    );
  }
}
