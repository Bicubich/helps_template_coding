import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';

class HelpsSupportButton extends StatelessWidget {
  const HelpsSupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await Utils.openSupportTelegram(context),
      child: Container(
        padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 12.w, right: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 52.w),
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: UiConstants.kColorBase05,
          border: Border.all(
            color: UiConstants.kColorBase06,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.kTextSupport.tr(),
              style: UiConstants.kTextStyleText3
                  .copyWith(color: UiConstants.kColorBase01),
            ),
            Image.asset(Paths.telegramIconPath),
          ],
        ),
      ),
    );
  }
}
