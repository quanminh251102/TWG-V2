import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/ui/screens/booking/widget/auto_complete/options.dart';
import 'package:flutter/material.dart';

class AutoCompleteField extends StatefulWidget
    with SharedExampleTypeAheadConfig {
  AutoCompleteField({
    super.key,
    required this.controller,
    required this.settings,
    required this.onSuggestionSelected,
  });

  @override
  final TextEditingController controller;
  @override
  final FieldSettings settings;
  final Function(Predictions predictions) onSuggestionSelected;
  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  late IHomeViewModel iHomeViewModel;

  Future<List<Predictions>> suggestionsCallback(String pattern) async =>
      await iHomeViewModel.onSearch(pattern);

  @override
  void initState() {
    iHomeViewModel = context.read<IHomeViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IHomeViewModel>(
      builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.maybeReversed([
            TypeAheadField<Predictions>(
              direction: widget.settings.direction.value,
              controller: widget.controller,
              loadingBuilder: (context) => SizedBox(
                height: 200.h,
                child: Center(
                  child: Lottie.asset(
                    "assets/lottie/loading_location.json",
                    repeat: true,
                  ),
                ),
              ),
              errorBuilder: (context, error) => const Text('Error!'),
              emptyBuilder: (context) => SizedBox(
                height: 200.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/not-found.png',
                      height: 100.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Không tìm thấy kết quả !',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context, controller, focusNode) => CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 18.sp,
                    ),
                placeholder: widget.hintText,
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 8.w,
                ),
              ),
              decorationBuilder: (context, child) => Material(
                type: MaterialType.card,
                elevation: 4,
                borderRadius: widget.borderRadius,
                child: child,
              ),
              itemBuilder: (context, prediction) => ListTile(
                horizontalTitleGap: 0,
                leading: const Icon(
                  Icons.my_location,
                  color: ColorUtils.primaryColor,
                ),
                title: Text(
                  prediction.description!
                      .substring(0, prediction.description!.indexOf(','))
                      .trim(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  prediction.description!
                      .substring(prediction.description!.indexOf(',') + 1)
                      .trim(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              debounceDuration: widget.debounceDuration,
              hideOnSelect: true,
              hideOnUnfocus: widget.settings.hideOnUnfocus.value,
              hideWithKeyboard: widget.settings.hideOnUnfocus.value,
              retainOnLoading: widget.settings.retainOnLoading.value,
              onSelected: (value) async {
                await widget.onSuggestionSelected(value);
              },
              suggestionsCallback: suggestionsCallback,
              itemSeparatorBuilder: widget.itemSeparatorBuilder,
              listBuilder: widget.settings.gridLayout.value
                  ? widget.gridLayoutBuilder
                  : null,
            ),
          ]),
        );
      },
    );
  }
}

mixin SharedExampleTypeAheadConfig {
  FieldSettings get settings;
  TextEditingController get controller;

  final String hintText = 'Tìm kiếm';
  final BorderRadius borderRadius = BorderRadius.circular(10);

  Widget itemSeparatorBuilder(BuildContext context, int index) =>
      settings.dividers.value
          ? const Divider(height: 1)
          : const SizedBox.shrink();

  List<Widget> maybeReversed(List<Widget> children) {
    if (settings.direction.value == VerticalDirection.up) {
      return children.reversed.toList();
    }
    return children;
  }

  Widget gridLayoutBuilder(
    BuildContext context,
    List<Widget> items,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 58,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      reverse:
          SuggestionsController.of<Predictions>(context).effectiveDirection ==
              VerticalDirection.up,
      itemBuilder: (context, index) => items[index],
    );
  }

  Duration get debounceDuration => settings.debounce.value
      ? const Duration(milliseconds: 300)
      : Duration.zero;
}
