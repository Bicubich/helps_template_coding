import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsDropdownFieldWithSearch extends StatefulWidget {
  final String? label;
  final String? hintText;
  final List<String> options;
  final TextEditingController controller;
  final Function()? onTap;

  const HelpsDropdownFieldWithSearch({
    Key? key,
    this.label,
    this.hintText,
    required this.options,
    required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  _HelpsDropdownFieldWithSearchState createState() =>
      _HelpsDropdownFieldWithSearchState();
}

class _HelpsDropdownFieldWithSearchState
    extends State<HelpsDropdownFieldWithSearch> {
  late List<String> filteredOptions;

  @override
  void initState() {
    super.initState();
    filteredOptions = [];
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        // Если запрос пуст, отображаем все опции
        filteredOptions = [];
      } else {
        // Фильтруем опции, чтобы они начинались с введенного текста
        filteredOptions = widget.options
            .where((option) =>
                option.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          style: UiConstants.kTextStyleText4
              .copyWith(color: UiConstants.kColorBase01),
          decoration: InputDecoration(
            fillColor: UiConstants.kColorBase01.withOpacity(0.2),
            filled: true,
            hintText: widget.hintText,
            hintStyle: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorBase07),
            labelStyle: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorBase01),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            errorStyle: UiConstants.kTextStyleText4
                .copyWith(color: UiConstants.kColorError, fontSize: 14.sp),
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
              padding: getMarginOrPadding(right: 5.w),
              child: IconButton(
                icon: Icon(Icons.search),
                color: UiConstants.kColorPrimary,
                iconSize: 30.w,
                onPressed: () => widget.onTap != null ? widget.onTap!() : null,
              ),
            ),
          ),
          cursorColor: UiConstants.kColorBase01,
          onChanged: _filterOptions,
        ),
        SizedBox(height: 10.h),
        if (filteredOptions.isNotEmpty)
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredOptions.length,
              itemBuilder: (context, index) {
                final option = filteredOptions[index];
                return ListTile(
                  title: Text(
                    option,
                    style: UiConstants.kTextStyleText4
                        .copyWith(color: UiConstants.kColorBase01),
                  ),
                  onTap: () {
                    widget.controller.text = option;
                    widget.onTap != null ? widget.onTap!() : null;
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
