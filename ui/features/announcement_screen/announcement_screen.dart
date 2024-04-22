import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:
            UiConstants.appPaddingHorizontal + UiConstants.appPaddingVertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.kTextWhatDoYouWantToDo.tr(),
              textAlign: TextAlign.center,
              style: UiConstants.kTextStyleText5.copyWith(
                color: UiConstants.kColorBase01,
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            HelpsButton(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.announcementViewScreen,
                arguments: {
                  'myAnnouncement': true,
                },
              ),
              text: LocaleKeys.kTextMyAds.tr(),
              textStyle: UiConstants.kTextStyleText4,
            ),
            SizedBox(
              height: 15.h,
            ),
            HelpsButton(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.announcementSelectCityScreen,
              ),
              text: LocaleKeys.kTextAdSearch.tr(),
              textStyle: UiConstants.kTextStyleText4,
            ),
            SizedBox(
              height: 15.h,
            ),
            HelpsButton(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.announcementCreateScreen,
              ),
              text: LocaleKeys.kTextAdPlacement.tr(),
              textStyle: UiConstants.kTextStyleText4,
            ),
          ],
        ),
      ),
    );
  }
}
