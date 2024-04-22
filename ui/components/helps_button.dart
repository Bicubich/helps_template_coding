import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsButton extends StatelessWidget {
  const HelpsButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.textStyle,
      this.buttonRadius = 12,
      this.buttonColor,
      this.isShowShadow = true,
      this.shadowColor,
      this.textColor = UiConstants.kColorBackground,
      this.isShadow = true})
      : super(key: key);

  final Function onTap;
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final double buttonRadius;
  final Color? buttonColor;
  final bool? isShowShadow;
  final Color? shadowColor;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: shadowColor ??
                      UiConstants.kColorPrimary
                          .withOpacity(0.5), // Цвет тени сверху
                  offset: const Offset(0, -4),
                  blurRadius: 12.0,
                ),
                BoxShadow(
                  color: shadowColor ??
                      UiConstants.kColorPrimary
                          .withOpacity(0.5), // Цвет тени снизу
                  offset: const Offset(0, 4),
                  blurRadius: 12.0,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? UiConstants.kColorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius.r),
          ),
        ),
        onPressed: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: (textStyle ?? UiConstants.kTextStyleText5)
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
