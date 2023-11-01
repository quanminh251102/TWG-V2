import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/utils/color_utils.dart';

class CustomSearchField extends StatefulWidget {
  CustomSearchField({
    super.key,
    this.onTap,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.focusNode,
    this.controller,
  });
  final Function()? onTap;
  final Function(String value)? onFieldSubmitted;
  final FocusNode? focusNode;
  TextEditingController? controller;

  final bool readOnly;
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
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.h,
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: _focusNode.hasFocus
                ? ColorUtils.primaryColor
                : const Color(0xff97999E),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xff97999E))),
          hintText: 'Tìm kiếm',
        ),
      ),
    );
  }
}
