import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'widgets/apply_in_booking_item.dart';

class ApplyInBookingPage extends StatefulWidget {
  // final dynamic booking;
  // const ApplyInBookingPage({super.key, required this.booking});

  const ApplyInBookingPage({super.key});

  @override
  State<ApplyInBookingPage> createState() => _ApplyInBookingPageState();
}

class _ApplyInBookingPageState extends State<ApplyInBookingPage>
    with TickerProviderStateMixin {
  late IApplyViewModel _iApplyViewModel;
  bool isLoading_getApplyInBooking = false;
  List<dynamic> applys = [];
  List<dynamic> applys_selected = [];
  TextEditingController _name = TextEditingController();
  late FocusNode nameFocus;
  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    // TODO: implement initState
    super.initState();

    nameFocus = FocusNode();

    init();
  }

  void init() async {
    // setState(() {
    //   isLoading_getApplyInBooking = true;
    // });

    // String result = "pass";

    // // print(widget.booking.toString());
    // try {
    //   applys = await ApplyService.getApplyInBooking(widget.booking["_id"]);
    //   applys_selected = applys;
    // } catch (e) {
    //   result = "error";
    //   print(e);
    // }

    // if (result == "error") {
    //   print('lỗi');
    // } else {
    //   print('thành công');
    // }
    // setState(() {
    //   isLoading_getApplyInBooking = false;
    // });
  }

  void do_filter() {
    setState(() {
      print("do filter");
      applys_selected = applys.where((apply) {
        String name = apply["applyer"]["first_name"].toString().toLowerCase();
        String search_name = _name.text.trim().toLowerCase();

        if (name.contains(search_name)) {
          return true;
        }
        return false;
      }).toList();
      print(applys_selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    search_bar() {
      return [
        const Text('Search theo tên : '),
        TextFormField(
          style: const TextStyle(fontWeight: FontWeight.w600),
          focusNode: nameFocus,
          controller: _name,
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
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
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(
              Icons.email_outlined,
              color:
                  nameFocus.hasFocus ? ColorUtils.primaryColor : Colors.black,
            ),
          ),
          onChanged: (text) {
            do_filter();
          },
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Apply của bài đăng')),
      body: isLoading_getApplyInBooking
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...search_bar(),
                    const SizedBox(height: 20),
                    if (applys_selected.length == 0)
                      const Text('Danh sách rỗng'),
                    if (applys_selected.length > 0)
                      for (var _apply in applys_selected) ...[
                        ApplyInBookItem(
                          apply: _apply,
                          reload: init,
                        ),
                        const SizedBox(height: 12),
                      ],
                  ],
                ),
              ),
            ),
    );
  }
}
