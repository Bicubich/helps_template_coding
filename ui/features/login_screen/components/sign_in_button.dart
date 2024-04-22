import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(
      {super.key,
      required this.onTap,
      required this.iconPath,
      required this.text});

  final Function onTap;
  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      onPressed: () => onTap(),
      child: Container(
        width: 140.w,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(iconPath),
              height: 24.w,
              width: 24.w,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 8.w),
              child: Text(
                text,
                style: UiConstants.kTextStyleText2
                    .copyWith(color: UiConstants.kColorBase06),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
