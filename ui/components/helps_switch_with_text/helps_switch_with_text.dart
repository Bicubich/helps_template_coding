import 'package:flutter/material.dart';
import 'package:helps_flutter/constants/ui_constants.dart';

class HelpsSwitchWithText extends StatelessWidget {
  HelpsSwitchWithText(
      {super.key,
      required this.text,
      required this.isEnabled,
      required this.onChanged,
      this.textStyle,
      this.textColor = UiConstants.kColorBase01});

  final String text;
  final TextStyle? textStyle;
  final Color textColor;
  final bool isEnabled;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: (textStyle ?? UiConstants.kTextStyleText2)
                .copyWith(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Switch(
          value: isEnabled,
          onChanged: onChanged,
          activeColor: UiConstants.kColorPrimary,
          thumbColor: MaterialStateProperty.all<Color>(
              isEnabled ? UiConstants.kColorPrimary : UiConstants.kColorBase01),
          inactiveTrackColor: UiConstants.kColorBackground.withOpacity(.7),
        ),
      ],
    );
  }
}
