import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

  @override
  void initState() {
    _iApplyViewModel = context.read<IApplyViewModel>();
    _iApplyViewModel.setIsMyApplys(true);
    startPointFocus = FocusNode();
    endPointFocus = FocusNode();

    Future.delayed(Duration.zero, () async {
      await _iApplyViewModel.init('');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    search_bar() {
      return [
        const Text('Điểm đi : '),
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
            hintText: 'Điểm đi',
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
        const Text('Điểm đến : '),
        TextFormField(
          style: const TextStyle(fontWeight: FontWeight.w600),
          focusNode: endPointFocus,
          controller: _endPoint,
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
            filled: true, //<-- SEE HERE
            fillColor: endPointFocus.hasFocus
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
            hintText: 'Điểm đến',
            prefixIcon: Icon(
              Icons.location_on,
              color: endPointFocus.hasFocus
                  ? ColorUtils.primaryColor
                  : Colors.black,
            ),
          ),
          onChanged: (text) {
            _iApplyViewModel.setEndPoint(text.trim());
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Các chuyến đi đã gửi yêu cầu'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.profile);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...search_bar(),
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
