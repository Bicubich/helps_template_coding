import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsAlertDialog extends StatelessWidget {
  final Widget content;
  final String firstButtonText;
  final String? secondButtonText;
  final Function onTapFirstButton;
  final Function? onTapSecondButton;

  const HelpsAlertDialog(
      {required this.content,
      required this.firstButtonText,
      this.secondButtonText,
      required this.onTapFirstButton,
      this.onTapSecondButton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
      child: AlertDialog(
        contentPadding: getMarginOrPadding(all: 15),
        backgroundColor: UiConstants.kColorBackground.withOpacity(0.7),
        content: Container(
          constraints: BoxConstraints(maxHeight: 350.h, minHeight: 150.h),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: content,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => onTapFirstButton(),
            child: Text(
              firstButtonText,
              style: UiConstants.kTextStyleText3.copyWith(
                color: UiConstants.kColorBase01,
              ),
            ),
          ),
          secondButtonText != null
              ? TextButton(
                  onPressed: () =>
                      onTapSecondButton != null ? onTapSecondButton!() : null,
                  child: Text(
                    secondButtonText!,
                    style: UiConstants.kTextStyleText3.copyWith(
                      color: UiConstants.kColorPrimary,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
