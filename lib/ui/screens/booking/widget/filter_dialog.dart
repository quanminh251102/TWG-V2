// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../booking_screen.dart';

class FilterDialog extends StatefulWidget {
  final Future Function() onTap;
  const FilterDialog({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late IBookingViewModel _iBookingViewModel;
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final ExpansionTileController _priceTileController =
      ExpansionTileController();
  final ExpansionTileController _bookingTypeController =
      ExpansionTileController();
  late TextEditingController fromDateController;
  late TextEditingController toDateController;

  DateTime? fromDate;
  DateTime? toDate;
  Future<void> _showFromDatePicker() async {
    return await showDatePicker(
      cancelText: 'Hủy',
      confirmText: 'Xác nhận',
      helpText: 'Chọn ngày',
      context: context,
      fieldHintText: 'dd/mm/yyyy',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: toDate != null
          ? toDate!.subtract(
              const Duration(days: 1),
            )
          : DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _fromDateConstraint,
    ).then(
      (v) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        if (v != null && fromDate != v) {
          setState(
            () {
              fromDate = v;
              fromDateController.text = formatter.format(fromDate!);
            },
          );
        } else {
          setState(
            () {
              fromDate = null;
            },
          );
        }
      },
    );
  }

  Future<void> _showToDatePicker() async {
    await showDatePicker(
      cancelText: 'Hủy',
      confirmText: 'Xác nhận',
      helpText: 'Chọn ngày',
      fieldHintText: 'dd/mm/yyyy',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      selectableDayPredicate: _toDateConstraint,
    ).then(
      (v) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        if (v != null && toDate != v) {
          setState(
            () {
              toDate = v;
              toDateController.text = formatter.format(toDate!);
            },
          );
        } else {
          setState(
            () {
              toDate = null;
            },
          );
        }
      },
    );
  }

  bool _toDateConstraint(DateTime day) {
    if (fromDate == null) {
      return true;
    } else {
      if (fromDate!.isAtSameMomentAs(DateTime.now())) {
        return day.isAtSameMomentAs(DateTime.now());
      } else {
        return day.isBefore(DateTime.now()) &&
            day.isAfter(fromDate!.subtract(const Duration(days: 1)));
      }
    }
  }

  bool _fromDateConstraint(DateTime day) {
    if (toDate == null) {
      return day.isBefore(DateTime.now());
    } else {
      if (toDate!.isAtSameMomentAs(DateTime.now())) {
        return day.isAtSameMomentAs(DateTime.now());
      } else {
        return day.isBefore(DateTime.now()) &&
            day.isBefore(toDate!.add(const Duration(days: 1)));
      }
    }
  }

  RangeValues currentRangeValues = const RangeValues(
    30000,
    100000,
  );
  int selectedIndex = 0;
  void selectOption(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    _iBookingViewModel = context.read<IBookingViewModel>();
    _minPriceController.text =
        VietnameseMoneyFormatter().formatToVietnameseCurrency(
      _iBookingViewModel.filterBookingDto!.minPrice != null
          ? _iBookingViewModel.filterBookingDto!.minPrice.toString()
          : currentRangeValues.start.round().toString(),
    );
    _maxPriceController.text = VietnameseMoneyFormatter()
        .formatToVietnameseCurrency(
            _iBookingViewModel.filterBookingDto!.maxPrice != null
                ? _iBookingViewModel.filterBookingDto!.maxPrice.toString()
                : currentRangeValues.end.round().toString());
    fromDateController = TextEditingController(
      text: _iBookingViewModel.filterBookingDto!.startTime != null
          ? DateFormat('dd/MM/yyyy').format(
              DateTime.parse(_iBookingViewModel.filterBookingDto!.startTime!),
            )
          : '',
    );
    toDateController = TextEditingController(
      text: _iBookingViewModel.filterBookingDto!.endTime != null
          ? DateFormat('dd/MM/yyyy').format(
              DateTime.parse(_iBookingViewModel.filterBookingDto!.endTime!),
            )
          : '',
    );
    currentRangeValues = _iBookingViewModel.filterBookingDto!.minPrice != null
        ? RangeValues(
            double.parse(
                _iBookingViewModel.filterBookingDto!.minPrice.toString()),
            double.parse(
                _iBookingViewModel.filterBookingDto!.maxPrice.toString()))
        : const RangeValues(
            30000,
            100000,
          );
    super.initState();
  }

  Widget customDatePickerTheme(Widget? child) {
    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          background: Colors.white,
          primaryContainer: Colors.white,
          primary: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        dialogBackgroundColor: ColorUtils.primaryColor,
        dialogTheme: const DialogTheme(
          backgroundColor: ColorUtils.primaryColor,
          titleTextStyle: TextStyle(color: Colors.white),
          contentTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      child: child ?? Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return SpringSlideTransition(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Lọc bài đăng'.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    controller: _priceTileController,
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(
                          0.5,
                        ),
                      ),
                    ),
                    title: Text('Mức giá',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        )),
                    children: [
                      RangeSlider(
                        values: currentRangeValues,
                        min: 0,
                        max: 150000,
                        divisions: 100,
                        labels: RangeLabels(
                          VietnameseMoneyFormatter().formatToVietnameseCurrency(
                              currentRangeValues.start.round().toString()),
                          VietnameseMoneyFormatter().formatToVietnameseCurrency(
                              currentRangeValues.end.round().toString()),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            currentRangeValues = values;
                            _minPriceController.text =
                                VietnameseMoneyFormatter()
                                    .formatToVietnameseCurrency(
                                        currentRangeValues.start
                                            .round()
                                            .toString());
                            _maxPriceController.text =
                                VietnameseMoneyFormatter()
                                    .formatToVietnameseCurrency(
                                        currentRangeValues.end
                                            .round()
                                            .toString());
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 60.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _minPriceController,
                                enabled: false,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      ),
                                      borderSide: BorderSide(
                                        width: 5.w,
                                        color: Colors.black.withOpacity(
                                          0.5,
                                        ),
                                      )),
                                  label: const Text(
                                    'Giá từ',
                                    style: TextStyle(
                                      color: ColorUtils.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _maxPriceController,
                                enabled: false,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      ),
                                      borderSide: BorderSide(
                                        width: 5.w,
                                        color: Colors.black.withOpacity(
                                          0.5,
                                        ),
                                      )),
                                  label: const Text(
                                    'Giá đến',
                                    style: TextStyle(
                                      color: ColorUtils.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(
                          0.5,
                        ),
                      ),
                    ),
                    initiallyExpanded: false,
                    controller: _bookingTypeController,
                    title: Text(
                      'Loại bài đăng',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: PostOptionItem(
                              title: 'Tìm tài xế',
                              description: 'Lọc các bài đăng tìm tài xế',
                              icon: const Icon(
                                Icons.motorcycle,
                                color: Colors.white,
                              ),
                              isSelected: selectedIndex == 0,
                              onTap: () => selectOption(0),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: PostOptionItem(
                              title: 'Tìm hành khách',
                              description: 'Lọc bài đăng tìm hành khách',
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              isSelected: selectedIndex == 1,
                              onTap: () => selectOption(1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(
                          0.5,
                        ),
                      ),
                    ),
                    title: Text('Thời gian',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        )),
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: fromDateController,
                              enabled: true,
                              readOnly: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () async {
                                    await _showFromDatePicker();
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    borderSide: BorderSide(
                                      width: 5.w,
                                      color: Colors.black.withOpacity(
                                        0.5,
                                      ),
                                    )),
                                label: const Text(
                                  'Từ ngày',
                                  style: TextStyle(
                                    color: ColorUtils.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: TextField(
                              controller: toDateController,
                              enabled: true,
                              readOnly: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () async {
                                    await _showToDatePicker();
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    borderSide: BorderSide(
                                      width: 5.w,
                                      color: Colors.black.withOpacity(
                                        0.5,
                                      ),
                                    )),
                                label: const Text(
                                  'Đến ngày',
                                  style: TextStyle(
                                    color: ColorUtils.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              _iBookingViewModel.deleteFilter();
                              await _iBookingViewModel
                                  .onSearchBooking()
                                  .then((value) => Get.back());
                            },
                            child: Center(
                              child: Container(
                                width: 180.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: ColorUtils.lightPrimaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Xóa lọc',
                                    style: TextStyle(
                                      color: ColorUtils.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              _iBookingViewModel.filterBookingDto?.minPrice =
                                  currentRangeValues.start.round();
                              _iBookingViewModel.filterBookingDto?.maxPrice =
                                  currentRangeValues.end.round();
                              _iBookingViewModel.filterBookingDto?.bookingType =
                                  selectedIndex == 1
                                      ? "Tìm hành khách"
                                      : "Tìm tài xế";
                              _iBookingViewModel.filterBookingDto?.startTime =
                                  fromDate?.toIso8601String();
                              _iBookingViewModel.filterBookingDto?.endTime =
                                  toDate?.toIso8601String();
                              await widget.onTap().then((value) => Get.back());
                            },
                            child: Center(
                              child: Container(
                                width: 180.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: ColorUtils.primaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Áp dụng',
                                    style: TextStyle(
                                      color: ColorUtils.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PostOptionItem extends StatelessWidget {
  final String title;
  final String description;
  final Icon icon;
  final bool isSelected;
  final Function()? onTap;
  const PostOptionItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            top: 5.h,
            bottom: 5.h,
            left: 8.w,
            right: 8.w,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorUtils.lightPrimaryColor.withOpacity(0.5)
                : Colors.white,
            borderRadius: BorderRadius.circular(
              10.r,
            ),
            border: Border.all(
              color: isSelected
                  ? ColorUtils.primaryColor
                  : Colors.black.withOpacity(
                      0.1,
                    ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundColor: isSelected
                    ? ColorUtils.primaryColor
                    : Colors.grey.withOpacity(0.5),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 260.w,
                      child: Text(
                        description,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black.withOpacity(0.8)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
