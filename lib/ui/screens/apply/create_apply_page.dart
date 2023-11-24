import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/router.dart';

class CreateApplyPage extends StatefulWidget {
  // final Booking booking;
  // const CreateApplyPage({super.key, required this.booking});

  const CreateApplyPage({super.key});

  @override
  State<CreateApplyPage> createState() => _CreateApplyPageState();
}

enum PriceOpition { accpected, refuse }

class _CreateApplyPageState extends State<CreateApplyPage>
    with TickerProviderStateMixin {
  late IApplyViewModel _iApplyViewModel;
  PriceOpition _site = PriceOpition.accpected;
  late FocusNode noteFocus;
  late FocusNode dealPriceFocus;
  late TextEditingController note = TextEditingController();
  late TextEditingController dealPrice = TextEditingController();
  late GlobalKey<FormState> _formKey;
  bool isLoading_create_apply = false;

  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    super.initState();
    _site = PriceOpition.accpected;

    noteFocus = FocusNode();
    dealPriceFocus = FocusNode();

    noteFocus.addListener(() {
      setState(() {});
    });

    dealPriceFocus.addListener(() {
      setState(() {});
    });

    _formKey = GlobalKey<FormState>();
  }

  void create_apply(BuildContext context) async {
    // setState(() {
    //   isLoading_create_apply = true;
    // });
    try {
      int price = 0;
      if (_site == PriceOpition.accpected) {
        price = 0;
      } else {
        price = int.parse(dealPrice.text.trim());
      }
      String note_string = " ";
      if (note.text.trim().length > 0) {
        note_string = note.text.trim();
      }
      String result = "pass";

      var bookingId = _iApplyViewModel.bookingDto!.id.toString();
      print(bookingId);
      result = await _iApplyViewModel
          .createApply(CreateApplyDto(dealPrice: price, booking: bookingId));
      // var snackBar = SnackBar(
      //   content: Text(result),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      // var snackBar = SnackBar(
      //   content: Text('Xay ra loi'),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // setState(() {
    //   isLoading_create_apply = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo apply'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.offNamed(MyRouter.profile);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lựa chọn giá'),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('Đồng ý giá'),
                  leading: Radio(
                    value: PriceOpition.accpected,
                    groupValue: _site,
                    onChanged: (PriceOpition? value) {
                      setState(() {
                        _site = value as PriceOpition;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Deal giá'),
                  leading: Radio(
                    value: PriceOpition.refuse,
                    groupValue: _site,
                    onChanged: (PriceOpition? value) {
                      setState(() {
                        _site = value as PriceOpition;
                        primaryFocus!.requestFocus();
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: (_site == PriceOpition.refuse),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    focusNode: dealPriceFocus,
                    controller: this.dealPrice,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập giá";
                      }
                      int price;
                      try {
                        price = int.parse(value);
                      } catch (e) {
                        return "Chỉ nhập kí tự số";
                      }
                      if (price == 0) {
                        return "Vui lòng nhập giá trị lớn hơn 0";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      focusColor: Colors.black,
                      filled: true, //<-- SEE HERE
                      fillColor: dealPriceFocus.hasFocus
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
                      hintText: 'Giá',
                      prefixIcon: Icon(Icons.money,
                          color: dealPriceFocus.hasFocus
                              ? ColorUtils.primaryColor
                              : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Ghi chú'),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  focusNode: noteFocus,
                  controller: this.note,
                  validator: (value) {
                    // if (value!.isEmpty) {
                    //   return "Vui lòng nhập ghi chú";
                    // }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                    focusColor: Colors.black,
                    filled: true, //<-- SEE HERE
                    fillColor: noteFocus.hasFocus
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
                    hintText: 'Ghi chú',
                    prefixIcon: Icon(Icons.note_rounded,
                        color: noteFocus.hasFocus
                            ? ColorUtils.primaryColor
                            : Colors.black),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: (isLoading_create_apply)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              create_apply(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 50),
                              maximumSize: const Size(200, 50),
                              backgroundColor: ColorUtils.primaryColor),
                          child: const Text(
                            'Tạo apply',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
