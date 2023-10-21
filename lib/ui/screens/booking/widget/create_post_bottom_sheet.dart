// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twg/core/utils/color_utils.dart';

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  int selectedIndex = 0;
  void selectOption(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Bạn muốn đăng bài cho chuyến đi: '.toUpperCase()),
        PostOptionItem(
          title: 'Tìm tài xế',
          description: 'Đăng bài để tìm cho bạn một tài xế thích hợp.',
          image: 'assets/icons/moto.svg',
          isSelected: selectedIndex == 0,
          onTap: () => selectOption(0),
        ),
        PostOptionItem(
          title: 'Tìm hành khách',
          description: 'Đăng bài để tìm hành khách chia sẻ chuyến đi.',
          image: 'assets/icons/person.svg',
          isSelected: selectedIndex == 1,
          onTap: () => selectOption(1),
        ),
      ]),
    );
  }
}

class PostOptionItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isSelected;
  final Function()? onTap;
  const PostOptionItem({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 8.h,
        left: 16.w,
        right: 16.w,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(
              255,
              235,
              232,
              232,
            ),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 10.w,
            ),
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtils.primaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(
                    image,
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          InkWell(
            onTap: onTap,
            child: CircleAvatar(
              radius: 14.r,
              backgroundColor: isSelected
                  ? const Color.fromARGB(255, 223, 157, 3)
                  : Colors.white,
              child: Icon(
                isSelected ? Icons.check : Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
