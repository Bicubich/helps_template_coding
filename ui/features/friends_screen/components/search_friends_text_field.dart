import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class SearchFriendsTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchFriendsTextField(
      {required this.controller, super.key, required this.onChanged});

  @override
  State<SearchFriendsTextField> createState() => _SearchFriendsTextFieldState();
}

class _SearchFriendsTextFieldState extends State<SearchFriendsTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: UiConstants.kColorBase01.withOpacity(0.02),
        filled: true,
        contentPadding:
            getMarginOrPadding(top: 10, bottom: 10, left: 10, right: 10),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 28),
          child: SvgPicture.asset(
            Paths.friendsMenuIconSearch,
            color: UiConstants.kColorBase01,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: UiConstants.kColorPrimary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: UiConstants.kColorPrimary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      style:
          UiConstants.kTextStyleText5.copyWith(color: UiConstants.kColorBase01),
      cursorColor: UiConstants.kColorBase01,
      onChanged: (value) => widget.onChanged(value),
    );
  }
}
