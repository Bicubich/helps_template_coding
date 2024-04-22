import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class ScheduleAirplaneItemText extends StatelessWidget {
  const ScheduleAirplaneItemText(
      {super.key, required this.prefixText, required this.text, this.airport});

  final String prefixText;
  final String text;
  final String? airport;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5.w,
      children: [
        Text(
          prefixText,
          style: UiConstants.kTextStyleText4
              .copyWith(color: UiConstants.kColorPrimary),
        ),
        Text(
          text,
          style: UiConstants.kTextStyleText4
              .copyWith(color: UiConstants.kColorBase01),
        ),
        Visibility(
          visible: airport != null,
          child: Wrap(
            children: [
              Text(
                '($airport)',
                style: UiConstants.kTextStyleText4
                    .copyWith(color: UiConstants.kColorBase01),
              ),
            ],
          ),
        )
      ],
    );
  }
}
