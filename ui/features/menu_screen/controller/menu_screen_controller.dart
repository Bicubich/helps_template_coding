import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_background_shading/cubit/background_shading_cubit.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';

class MenuScreenController {
  static Future<void> openSmbMenu(BuildContext context, Menu menu) async {
    await context.read<BackgroundShadingCubit>().activate();
    final region = await SharedPreferencesHelper.getString(
        SharedPreferencesKeys.userRegion);
    final notificationCubit = context.read<NotificationCubit>();

    if (region == null || region.isEmpty) {
      notificationCubit.showErrorNotification(
          context, LocaleKeys.kTextRegionNotDefined.tr());
      await context.read<BackgroundShadingCubit>().hide();
      return;
    }

    if (menu == Menu.bridgeSchedule && region != 'Leningradskaya_oblast') {
      notificationCubit.showErrorNotification(
          context, LocaleKeys.kTextTerritorialLocationNotLenObl.tr());
      await context.read<BackgroundShadingCubit>().hide();
      return;
    }

    await context.read<BackgroundShadingCubit>().hide();
    _navigateToMenu(context, menu, region);
  }

  static Future _navigateToMenu(
      BuildContext context, Menu menu, String region) async {
    switch (menu) {
      case Menu.bridgeSchedule:
        Navigator.pushNamed(context, Routes.scheduleBridgeScreen);
        break;
      case Menu.airplaneSchedule:
        Navigator.pushNamed(context, Routes.scheduleAirplaneScreen,
            arguments: {'region': region});
        break;
      case Menu.driverChatTelegram:
        String? driverChatTelegramUrl =
            await HelpsApi.getDriverChatTelegramUrl(region);
        if (driverChatTelegramUrl != null) {
          Utils.launchURL(context, driverChatTelegramUrl);
        }

        break;
      default:
    }
  }
}

enum Menu {
  bridgeSchedule,
  airplaneSchedule,
  driverChatTelegram,
}
