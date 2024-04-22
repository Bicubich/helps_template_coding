import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsBorderChip extends StatelessWidget {
  const HelpsBorderChip(
      {super.key,
      required this.chipColor,
      required this.textColor,
      required this.text,
      this.isMainDiagonal = true});

  final Color chipColor;
  final Color textColor;
  final String text;
  final bool isMainDiagonal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: isMainDiagonal
            ? BorderRadius.only(
                bottomRight: Radius.circular(12.r),
                topLeft: Radius.circular(12.r),
              )
            : BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
      ),
      child: Text(
        text,
        style: UiConstants.kTextStyleText10
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
