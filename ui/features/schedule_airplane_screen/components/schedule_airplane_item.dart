import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/airplane_schedule_model.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_border_chip.dart';
import 'package:helps_flutter/ui/features/schedule_airplane_screen/components/schedule_airplane_item_text.dart';

class ScheduleAirplaneItem extends StatelessWidget {
  const ScheduleAirplaneItem({super.key, required this.airplaneScheduleItem});

  final AirplaneScheduleModel airplaneScheduleItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: getMarginOrPadding(all: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: UiConstants.kColorBase10.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScheduleAirplaneItemText(
                prefixText: LocaleKeys.kTextFrom.tr().toUpperCase(),
                text: airplaneScheduleItem.arrival,
              ),
              SizedBox(
                height: 5.h,
              ),
              ScheduleAirplaneItemText(
                prefixText: LocaleKeys.kTextTo.tr().toUpperCase(),
                text: airplaneScheduleItem.departure,
                airport: airplaneScheduleItem.airportName,
              ),
              SizedBox(
                height: 5.h,
              ),
              ScheduleAirplaneItemText(
                prefixText: LocaleKeys.kTextArrival.tr().toUpperCase(),
                text: DateFormat('HH:mm')
                    .format(airplaneScheduleItem.arrivalDate),
              ),
            ],
          ),
        ),
        HelpsBorderChip(
          chipColor: airplaneScheduleItem.arrivalDate.isBefore(DateTime.now())
              ? UiConstants.kColorError
              : UiConstants.kColorSuccess,
          text: airplaneScheduleItem.arrivalDate.isBefore(DateTime.now())
              ? LocaleKeys.kTextLandingComplete.tr()
              : LocaleKeys.kTextOnTheWay.tr(),
          textColor: UiConstants.kColorBase01,
        ),
      ],
    );
  }
}
