import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_support_button.dart';

class HelpsFetchDataErrorWidget extends StatelessWidget {
  const HelpsFetchDataErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          UiConstants.appPaddingHorizontal + UiConstants.appPaddingVertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                LocaleKeys.kTextDataLoadingError.tr(),
                textAlign: TextAlign.center,
                style: UiConstants.kTextStyleText5.copyWith(
                  color: UiConstants.kColorBase01,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 270.w,
            child: const HelpsSupportButton(),
          ),
        ],
      ),
    );
  }
}
