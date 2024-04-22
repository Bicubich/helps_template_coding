import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/airplane_schedule_model.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/features/schedule_airplane_screen/components/schedule_airplane_item.dart';

class ScheduleAirplaneList extends StatelessWidget {
  const ScheduleAirplaneList({
    super.key,
    required this.expansionTileController,
    required this.title,
    required this.airplaneScheduleList,
  });
  final List<AirplaneScheduleModel> airplaneScheduleList;
  final ExpansionTileController expansionTileController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: expansionTileController,
      shape: const Border(bottom: BorderSide(width: 1)),
      tilePadding: getMarginOrPadding(right: 15),
      childrenPadding: UiConstants.appPaddingHorizontal,
      iconColor: UiConstants.kColorBase01,
      collapsedIconColor: UiConstants.kColorBase01,
      title: ListTile(
        title: Text(
          title,
          style: UiConstants.kTextStyleText5
              .copyWith(color: UiConstants.kColorBase01),
        ),
      ),
      children: List.generate(
        airplaneScheduleList.length,
        (index) => Column(
          children: [
            ScheduleAirplaneItem(
                airplaneScheduleItem: airplaneScheduleList[index]),
            if (index != -1)
              SizedBox(
                height: 20.h,
              )
          ],
        ),
      ),
    );
  }
}
