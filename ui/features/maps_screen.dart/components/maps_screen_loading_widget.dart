import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';

class MapsScreenLoadingWidget extends StatelessWidget {
  const MapsScreenLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          UiConstants.appPaddingHorizontal + UiConstants.appPaddingVertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.kTextLoadingYourLocationData.tr(),
            textAlign: TextAlign.center,
            style: UiConstants.kTextStyleText5.copyWith(
              color: UiConstants.kColorBase01,
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          CircularProgressIndicator(
            color: UiConstants.kColorBase01,
          )
        ],
      ),
    );
  }
}
