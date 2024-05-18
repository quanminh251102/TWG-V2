// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:twg/core/utils/color_utils.dart';

class CustomSearchField extends StatefulWidget {
  final Function()? onTap;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final BorderRadius? borderRadius;
  final bool readOnly;
  const CustomSearchField({
    Key? key,
    this.onTap,
    this.onFieldSubmitted,
    this.onChanged,
    this.focusNode,
    this.controller,
    required this.readOnly,
    this.borderRadius,
  }) : super(key: key);
  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: widget.controller,
        cursorColor:
            _focusNode.hasFocus ? ColorUtils.primaryColor : Colors.white,
        focusNode: _focusNode,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 10.w,
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: _focusNode.hasFocus
                ? ColorUtils.primaryColor
                : const Color(0xff97999E),
          ),
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(
                  6.r,
                ),
            borderSide: const BorderSide(
              color: Color(
                0xff97999E,
              ),
            ),
          ),
          hintText: 'Tìm kiếm',
        ),
      ),
    );
  }
}
