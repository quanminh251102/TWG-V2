import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ireview_viewmodel.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/screens/profile_and_settings/my_reviews/widgets/review_item.dart';

class MyReViewsPage extends StatefulWidget {
  const MyReViewsPage({super.key});

  @override
  State<MyReViewsPage> createState() => _MyReViewsPageState();
}

class _MyReViewsPageState extends State<MyReViewsPage> {
  bool isLoading = false;
  List<dynamic> reviews = [];
  List<dynamic> reviews_selected = [];
  TextEditingController _name = TextEditingController();
  late FocusNode nameFocus;
  late IReviewViewModel _iReviewViewModel;
  @override
  void initState() {
    _iReviewViewModel = context.read<IReviewViewModel>();
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      await _iReviewViewModel.init();
    });
    nameFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    search_bar() {
      return [
        Text('Search theo tên : '),
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
            // prefixIcon: Icon(
            //   Icons.email_outlined,
            //   color: nameFocus.hasFocus ? AppColors.primaryColor : Colors.black,
            // ),
          ),
          onChanged: (text) {
            _iReviewViewModel.setName(text.trim());
          },
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.offNamed(MyRouter.profile);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...search_bar(),
                    const SizedBox(height: 20),
                    Consumer<IReviewViewModel>(
                      builder: (context, vm, child) {
                        return Column(
                          children: [
                            if (vm.reviewsAfterFilter.isEmpty)
                              const Text('Danh sách rỗng'),
                            if (vm.reviewsAfterFilter.isNotEmpty)
                              for (var data in vm.reviewsAfterFilter) ...[
                                ReviewItem(review: data),
                                const SizedBox(height: 12),
                              ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
