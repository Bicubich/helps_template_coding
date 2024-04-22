import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/components/helps_icon_button.dart';

class HelpsInfoSheet extends StatelessWidget {
  HelpsInfoSheet(
      {super.key,
      required this.body,
      required this.title,
      required this.userPhone});

  final String title;
  final Widget body;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      padding: getMarginOrPadding(all: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: UiConstants.kTextStyleText4
                      .copyWith(color: UiConstants.kColorBackground),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              HelpsIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.close,
                width: 24.w,
                height: 24.w,
                iconColor: UiConstants.kColorBackground,
              ),
            ],
          ),
          Spacer(),
          body,
          Spacer(),
          HelpsButton(
            onTap: () => Utils.openContacts(context, userPhone),
            text: LocaleKeys.kTextCall.tr(),
          )
        ],
      ),
    );
  }
}
