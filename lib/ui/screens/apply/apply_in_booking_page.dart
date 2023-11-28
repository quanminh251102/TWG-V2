import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'widgets/apply_item.dart';

class ApplyInBookingPage extends StatefulWidget {
  const ApplyInBookingPage({super.key});

  @override
  State<ApplyInBookingPage> createState() => _ApplyInBookingPageState();
}

class _ApplyInBookingPageState extends State<ApplyInBookingPage>
    with TickerProviderStateMixin {
  late IApplyViewModel _iApplyViewModel;
  TextEditingController _name = TextEditingController();
  late FocusNode nameFocus;

  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iApplyViewModel.setIsMyApplys(false);
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      await _iApplyViewModel.init('');
    });

    nameFocus = FocusNode();
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
            _iApplyViewModel.setApplyerName(text.trim());
          },
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách tham gia'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.profile);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...search_bar(),
              const SizedBox(height: 20),
              Consumer<IApplyViewModel>(
                builder: (context, vm, child) {
                  return Column(
                    children: [
                      if (vm.applysAfterFilter.isEmpty)
                        const Text('Danh sách rỗng'),
                      if (vm.applysAfterFilter.isNotEmpty)
                        for (var _apply in vm.applysAfterFilter) ...[
                          ApplyItem(
                            apply: _apply,
                            vm: _iApplyViewModel,
                          ),
                          const SizedBox(height: 12),
                        ],
                    ],
                  );
                },
              ),
              // if (applys_selected.length == 0)
              //   const Text('Danh sách rỗng'),
              // if (applys_selected.length > 0)
              //   for (var _apply in applys_selected) ...[
              //     ApplyItem(
              //       apply: _apply,
              //       vm: _iApplyViewModel,
              //     ),
              //     const SizedBox(height: 12),
              //   ],
            ],
          ),
        ),
      ),
    );
  }
}
