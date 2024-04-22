import 'dart:async';

import 'package:dash_bubble/dash_bubble.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/utils/maps_utils.dart';

class OverlaySosService {
  OverlaySosService(this.context);
  final BuildContext context;
  static DashBubble _sosService = DashBubble.instance;

  Future startBubble() async {
    Timer? sosTimer;
    bool sosButtonPressed = false;
    bool? sosServiceIsRunning = await _sosService.isRunning();
    if (sosServiceIsRunning == true) {
      await stopBubble();
    }
    await _sosService.startBubble(
      bubbleOptions: BubbleOptions(
        bubbleIcon: 'ic_sos',
        startLocationX: (MediaQuery.of(context).size.width - 140) * 0.5,
        startLocationY: MediaQuery.of(context).size.height * 0.6,
        bubbleSize: 140,
        opacity: 1,
        enableClose: false,
        closeBehavior: CloseBehavior.following,
        distanceToClose: 100,
        enableAnimateToEdge: false,
        enableBottomShadow: true,
        keepAliveWhenAppExit: false,
      ),
      notificationOptions: NotificationOptions(
          id: 1,
          title: LocaleKeys.kTextSOSService.tr(),
          body: LocaleKeys.kTextHoldWidgetForTwoSeconds.tr(),
          channelId: 'sos_service_notification',
          channelName: 'Sos Service Notification',
          icon: 'ic_notification'),
      onTap: () {},
      onTapDown: (x, y) {
        // нажимаем кнопку
        sosButtonPressed = true;
        // останавливаем таймер (в случае спама)
        sosTimer?.cancel();
        // запускаем таймер на 2 сек
        sosTimer = Timer.periodic(Duration(seconds: 2), (_) async {
          // условие на то, что таймер ещё работает (на тот случай, если мы остановили его при отжатии кнопки)
          if (sosTimer?.isActive == true && sosButtonPressed) {
            FlutterForegroundTask.launchApp();
            // закрываем все открытые маршруты, кроме карты
            Navigator.of(context).popUntil(
              ModalRoute.withName(Routes.mapsScreen),
            );
            MapsUtils.onSosTap(context);
          }
          // останавливаем таймер спустя 2 секунды
          sosTimer?.cancel();
        });
      },
      onTapUp: (x, y) {
        // отжимаем кнопку
        sosButtonPressed = false;
        // проверяем, идёт ли таймер (если нет, то функция уже выполнена, так как пользовать зажимал 2 секунды кнопку)
        if (sosTimer?.isActive == true) {
          // останавливаем таймер (для того, чтобы функция не выполнилась 2 раза - после 2сек. нажатия)
          sosTimer?.cancel();
        }
      },
      onMove: (x, y) => sosTimer?.cancel(),
    );
  }

  Future stopBubble() async {
    await _sosService.stopBubble();
  }
}
