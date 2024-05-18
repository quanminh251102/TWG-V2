import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/action_button.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage>
    with TickerProviderStateMixin {
  late IProfileViewModel _iProfileViewModel;
  late FocusNode nameFocus;
  late FocusNode birthdayFocus;
  late FocusNode genderFocus;
  late TextEditingController name;
  late TextEditingController birthday;

  late GlobalKey<FormState> _formKey;
  late SingleValueDropDownController gender;

  String? _gender;
  DateTime? _birthday;
  bool _isLoadingUpdate = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorUtils.primaryColor,
              onPrimary: Colors.black,
              surface: ColorUtils.primaryColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    ) as DateTime;
    if (picked != _birthday) {
      setState(() {
        _birthday = picked;
        if (_birthday == null) {
          birthday.text = 'Chọn ngày';
        } else {
          birthday.text =
              '${_birthday?.day}/${_birthday?.month}/${_birthday?.year}';
        }
      });
    }
  }

  @override
  void initState() {
    _iProfileViewModel = context.read<IProfileViewModel>();
    gender = SingleValueDropDownController();
    super.initState();
    print('update page');

    nameFocus = FocusNode();
    birthdayFocus = FocusNode();
    genderFocus = FocusNode();

    nameFocus.addListener(() {
      setState(() {});
    });
    birthdayFocus.addListener(() {
      setState(() {});
    });
    genderFocus.addListener(() {
      setState(() {});
    });

    _formKey = GlobalKey<FormState>();
    name = TextEditingController();
    birthday = TextEditingController();

    name.text = _iProfileViewModel.accountDto.firstName.toString();

    if (_iProfileViewModel.accountDto.gender == "male") {
      gender.dropDownValue =
          const DropDownValueModel(name: 'Nam', value: "male");
    } else {
      gender.dropDownValue =
          const DropDownValueModel(name: 'Nữ', value: "female");
    }

    // if (_iProfileViewModel.accountDto. widget.user["birth_date"] == "") {
    //   this._birthday = DateTime.now();
    // } else {
    //   this._birthday = DateTime.parse(widget.user["birth_date"]);
    // }
    // if (this._birthday == null) {
    //   this.birthday.text = 'Chọn ngày';
    // } else {
    //   this.birthday.text =
    //       '${_birthday?.day}/${_birthday?.month}/${_birthday?.year}';
    // }
  }

  @override
  void dispose() {
    name.dispose();
    birthday.dispose();
    gender.dispose();
    super.dispose();
  }

  void function_pass() {
    setState(() {
      _isLoadingUpdate = false;
    });
    // showSnackBar(context, 'Cập nhật thành công');
  }

  void function_error() {
    setState(() {
      _isLoadingUpdate = false;
    });
    // showSnackBar(context, 'Đã xảy ra lổi');
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
                // prefixIcon: Icon(
                //   Icons.ac_unit_rounded,
                //   color: nameFocus.hasFocus
                //       ? AppColors.primaryColor
                //       : Colors.black,
                // ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            DropDownTextField(
              clearOption: false,
              controller: gender,
              textFieldFocusNode: genderFocus,
              textFieldDecoration: InputDecoration(
                labelText: 'Giới tính',
                hintText: 'Giới tính',
                filled: true, //<-- SEE HERE
                fillColor: Colors.grey.withOpacity(0.1),
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
              ),
              // searchFocusNode: searchFocusNode,
              // searchAutofocus: true,
              dropDownItemCount: 8,
              searchShowCursor: false,
              // enableSearch: true,
              // searchKeyboardType: TextInputType.number,
              dropDownList: const [
                DropDownValueModel(name: 'Nam', value: "male"),
                DropDownValueModel(name: 'Nữ', value: "female"),
              ],
              onChanged: (val) {
                print(val);
                print(gender.dropDownValue);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            // TextFormField(
            //   readOnly: true,
            //   focusNode: birthdayFocus,
            //   controller: birthday,
            //   onTap: () {
            //     _selectDate(context);
            //   },
            //   validator: (value) {
            //     if (value!.isEmpty || value.length < 1) {
            //       return 'Chọn ngày';
            //     }
            //     return null;
            //   },
            //   decoration: InputDecoration(
            //     labelText: 'Ngày sinh', hintText: 'Chọn ngày',
            //     labelStyle: const TextStyle(fontSize: 15),
            //     filled: true, //<-- SEE HERE
            //     fillColor: Colors.grey.withOpacity(0.1),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(color: ColorUtils.primaryColor),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(
            //         color: Colors.grey.withOpacity(0.1),
            //         width: 2.0,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 24,
            // ),
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
                          value.gender = gender.dropDownValue!.value;
                          //  this._birthday.toString(),
                          String text =
                              await _iProfileViewModel.updateProfile(value);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(text),
                            ),
                          );
                          setState(() {
                            _isLoadingUpdate = false;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorUtils.primaryColor,
                            borderRadius: BorderRadius.circular(25)),
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
