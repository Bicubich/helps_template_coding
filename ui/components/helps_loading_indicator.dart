import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsLoadingIndicator extends StatelessWidget {
  const HelpsLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 75.w,
        width: 75.w,
        decoration: BoxDecoration(
          color: UiConstants.kColorBackground.withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(18.r),
          ),
        ),
        child: Padding(
          padding: getMarginOrPadding(all: 15),
          child: CircularProgressIndicator(
            color: UiConstants.kColorBase01,
          ),
        ),
      ),
    );
  }
}
