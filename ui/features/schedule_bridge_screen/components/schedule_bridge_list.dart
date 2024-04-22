import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/bridge_schedule_model.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/components/schedule_bridge_item.dart';
import 'package:helps_flutter/ui/features/schedule_bridge_screen/controller/schedule_bridge_controller.dart';

class ScheduleBridgeList extends StatelessWidget {
  const ScheduleBridgeList({
    super.key,
    required this.expansionTileController,
    required this.bridgeItem,
  });

  final ExpansionTileController expansionTileController;
  final BridgeScheduleModel bridgeItem;

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
          bridgeItem.name,
          style: UiConstants.kTextStyleText5
              .copyWith(color: UiConstants.kColorBase01),
        ),
      ),
      children: List.generate(
        bridgeItem.openArray.length,
        (index) => Column(
          children: [
            ScheduleBridgeItem(
              bridgeName: bridgeItem.name,
              openTime: bridgeItem.openArray[index],
              closeTime: bridgeItem.closeArray[index],
              status: BridgeScheduleController.isBridgeOpen(
                      bridgeItem.openArray[index], bridgeItem.closeArray[index])
                  ? BridgeStatus.close
                  : BridgeStatus.open,
            ),
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

enum BridgeStatus { open, close }
