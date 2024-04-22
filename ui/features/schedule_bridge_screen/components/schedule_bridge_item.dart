import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/components/schedule_bridge_list.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/controller/schedule_bridge_controller.dart';

class ScheduleBridgeItem extends StatelessWidget {
  const ScheduleBridgeItem({
    super.key,
    required this.status,
    required this.bridgeName,
    required this.openTime,
    required this.closeTime,
  });

  final String bridgeName;
  final DateTime openTime;
  final DateTime closeTime;
  final BridgeStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(all: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: UiConstants.kColorBase04.withOpacity(.8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CircleAvatar(
            radius: 12.r,
            backgroundColor: status == BridgeStatus.open
                ? UiConstants.kColorSuccess
                : UiConstants.kColorError.withOpacity(.8),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 12.r + 12.r + 10.w,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.kTextBridgeName.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiConstants.kTextStyleText3.copyWith(
                          color: UiConstants.kColorBase01, letterSpacing: 0),
                    ),
                    Text(
                      bridgeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: UiConstants.kTextStyleText3.copyWith(
                          //overflow: TextOverflow.ellipsis,
                          color: UiConstants.kColorPrimary,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.kTextBridgeOpeningTime.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: UiConstants.kTextStyleText3.copyWith(
                          color: UiConstants.kColorBase01, letterSpacing: 0),
                    ),
                    Text(
                      BridgeScheduleController.formatTimeRange(
                          openTime, closeTime),
                      style: UiConstants.kTextStyleText3.copyWith(
                          color: UiConstants.kColorPrimary,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
