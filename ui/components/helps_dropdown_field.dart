import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsDropdownField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final List<String> options;
  final TextEditingController controller;

  const HelpsDropdownField({
    Key? key,
    this.label,
    this.hintText,
    required this.options,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 30.h,
      value: options.isNotEmpty ? options[0] : null,
      onChanged: (String? value) {
        controller.text = value ?? '';
      },
      dropdownColor: UiConstants.kColorBase07,
      icon: Container(),
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorBase01),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        fillColor: UiConstants.kColorBase01.withOpacity(0.2),
        filled: true,
        hintText: hintText,
        hintStyle: UiConstants.kTextStyleText4
            .copyWith(color: UiConstants.kColorBase07),
        labelStyle: UiConstants.kTextStyleText4
            .copyWith(color: UiConstants.kColorBase01),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12.r),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12.r),
        ),
        suffixIcon: Padding(
          padding: getMarginOrPadding(all: 2.w),
          child: Icon(
            Icons.arrow_drop_down,
            color: UiConstants.kColorBase07,
          ),
        ),
      ),
    );
  }
}
