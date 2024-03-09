import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/apply/widgets/apply_item.dart';

class MyApplyPage extends StatefulWidget {
  const MyApplyPage({super.key});

  @override
  State<MyApplyPage> createState() => _MyApplyPageState();
}

class _MyApplyPageState extends State<MyApplyPage>
    with TickerProviderStateMixin {
  late IApplyViewModel _iApplyViewModel;
  final TextEditingController _startPoint = TextEditingController();
  final TextEditingController _endPoint = TextEditingController();
  late FocusNode startPointFocus;
  late FocusNode endPointFocus;
  bool isLoading = false;
  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iApplyViewModel.setIsMyApplys(true);
    startPointFocus = FocusNode();
    endPointFocus = FocusNode();
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
  }

  @override
  Widget build(BuildContext context) {
    search_bar() {
      return [
        TextFormField(
          style: const TextStyle(fontWeight: FontWeight.w600),
          focusNode: startPointFocus,
          controller: _startPoint,
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
            filled: true, //<-- SEE HERE
            fillColor: startPointFocus.hasFocus
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
            hintText: 'Địa điểm...',
            prefixIcon: Icon(
              Icons.location_on,
              color: startPointFocus.hasFocus
                  ? ColorUtils.primaryColor
                  : Colors.black,
            ),
          ),
          onChanged: (text) {
            _iApplyViewModel.setStartPoint(text.trim());
          },
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yêu cầu',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              ...search_bar(),
              SizedBox(
                height: 10.h,
              ),
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
                        return vm.applysAfterFilter.isEmpty
                            ? Center(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Lottie.asset(
                                      'assets/lottie/empty.json',
                                      height: 100.h,
                                    )),
                              )
                            : Column(
                                children: vm.applysAfterFilter
                                    .map(
                                      (e) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 12.h,
                                        ),
                                        child: ApplyItem(
                                          apply: e,
                                          vm: _iApplyViewModel,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );

                        // return ListView.builder(
                        //   itemBuilder: (ctx, index) {
                        //     return ApplyItem(
                        //       apply: vm.applysAfterFilter[index],
                        //       vm: _iApplyViewModel,
                        //     );
                        //   },
                        //   itemCount: vm.applysAfterFilter.length,
                        // );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
