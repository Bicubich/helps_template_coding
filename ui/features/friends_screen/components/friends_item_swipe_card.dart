import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class FriendsItemSwipeCard extends StatelessWidget {
  const FriendsItemSwipeCard(
      {super.key,
      this.iconPath,
      required this.text,
      required this.onPressed,
      this.isLast = false,
      this.secondText});

  final String? iconPath;
  final String text;
  final String? secondText;
  final Function onPressed;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: 100.w,
        height: 100.w,
        padding: getMarginOrPadding(left: 12, right: 6, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: UiConstants.kColorBase10.withOpacity(0.2),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(12.r),
            right: Radius.circular(isLast ? 24.r : 12.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iconPath != null
                ? SvgPicture.asset(
                    iconPath!,
                    height: 24.w,
                  )
                : Text(
                    text,
                    style: UiConstants.kTextStyleText10.copyWith(
                      color: UiConstants.kColorBase01,
                    ),
                  ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              text,
              style: UiConstants.kTextStyleText10.copyWith(
                color: UiConstants.kColorBase01,
              ),
            )
          ],
        ),
      ),
    );
  }
}
