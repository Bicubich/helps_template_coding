import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.iconPadding = 0,
  }) : super(key: key);

  final String text;
  final String iconPath;
  final double iconPadding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: UiConstants.kColorBase09.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              getMarginOrPadding(all: 10)),
          backgroundColor: MaterialStateProperty.all<Color>(
            UiConstants.kColorBase10.withOpacity(0.20),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r),
            ),
          ),
          fixedSize: MaterialStateProperty.all<Size>(Size(102.w, 102.w)),
        ),
        onPressed: onPressed,
        child: Column(
          children: [
            Padding(
              padding:
                  getMarginOrPadding(left: iconPadding, right: iconPadding),
              child: Image.asset(
                iconPath,
                height: 40.w,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: Text(
                text,
                style: UiConstants.kTextStyleText7.copyWith(
                  color: UiConstants.kColorBase01,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
