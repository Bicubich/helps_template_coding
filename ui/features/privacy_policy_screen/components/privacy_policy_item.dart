import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/model/privacy_policy_model.dart';

class PrivacyPolicyItem extends StatelessWidget {
  const PrivacyPolicyItem(
      {super.key,
      required this.privacyPolicyModel,
      required this.onTapCheckbox});
  final PrivacyPolicyModel privacyPolicyModel;
  final Function onTapCheckbox;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTapCheckbox(),
          child: Image.asset(
            privacyPolicyModel.isCheckboxPressed
                ? Paths.checkboxPressedIconPath
                : Paths.checkboxUnpressedIconPath,
            height: 24.w,
            width: 24.w,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: privacyPolicyModel.text,
              style: UiConstants.kTextStyleText11.copyWith(
                color: UiConstants.kColorBase02,
              ),
              children: [
                if (privacyPolicyModel.clickText != null)
                  TextSpan(
                    text: privacyPolicyModel.clickText,
                    style: UiConstants.kTextStyleText11.copyWith(
                        color: UiConstants.kColorPrimary,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => privacyPolicyModel.onClickText != null
                          ? privacyPolicyModel.onClickText!()
                          : null,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
