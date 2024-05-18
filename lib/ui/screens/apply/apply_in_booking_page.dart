import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ireview_viewmodel.dart';
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
  late IReviewViewModel _iReviewViewModel;
  final TextEditingController _name = TextEditingController();
  late FocusNode nameFocus;
  bool isLoading = false;
  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iApplyViewModel.setIsMyApplys(false);

    _iReviewViewModel = context.read<IReviewViewModel>();
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      await _iApplyViewModel.init('');
    });
    setState(() {
      isLoading = false;
    });
    super.initState();

    nameFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    search_bar() {
      return [
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
              Icons.book_outlined,
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
        title: const Text(
          'Danh sách tham gia',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.profile);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
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
              isLoading
                  ? Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Lottie.asset(
                            'assets/lottie/loading_text.json',
                            height: 100.h,
                          )),
                    )
                  : Consumer<IApplyViewModel>(
                      builder: (context, vm, child) {
                        return Column(
                          children: [
                            if (vm.applysAfterFilter.isEmpty)
                              Center(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Lottie.asset(
                                      'assets/lottie/empty.json',
                                      height: 100.h,
                                    )),
                              ),
                            if (vm.applysAfterFilter.isNotEmpty)
                              for (var _apply in vm.applysAfterFilter) ...[
                                ApplyItem(
                                  apply: _apply,
                                  vm: _iApplyViewModel,
                                  rvm: _iReviewViewModel,
                                ),
                                const SizedBox(height: 12),
                              ],
                          ],
                        );
                      },
                    )
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
