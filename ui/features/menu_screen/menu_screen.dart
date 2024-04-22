import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/firebase_messaging_manager.dart';
import 'package:helps_flutter/system/location_manager.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/menu_screen/components/menu_button.dart';
import 'package:helps_flutter/ui/features/menu_screen/controller/menu_screen_controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      body: ListView(
        padding: getMarginOrPadding(left: 15, right: 15),
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              SizedBox(
                height: 27.h,
              ),
              Text(
                LocaleKeys.kTextMenu.tr(),
                style: UiConstants.kTextStyleText8
                    .copyWith(color: UiConstants.kColorPrimary),
              ),
              SizedBox(
                height: 38.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    onPressed: () => _openProfileScreen(context),
                    text: LocaleKeys.kTextProfile.tr(),
                    iconPath: Paths.menuProfileIconPath,
                  ),
                  MenuButton(
                    onPressed: () => context
                        .read<NotificationCubit>()
                        .showInfoNotification(
                            context,
                            LocaleKeys.kTextThisSectionIsStillUnderDevelopment
                                .tr()),
                    text: LocaleKeys.kTextMyVideo.tr(),
                    iconPath: Paths.menuRecordsIconPath,
                  ),
                  MenuButton(
                    onPressed: () => MenuScreenController.openSmbMenu(
                        context, Menu.driverChatTelegram),
                    text: LocaleKeys.kTextDriverChatTelegram.tr(),
                    iconPath: Paths.menuTgIconPath,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    onPressed: () async =>
                        await Utils.openSupportTelegram(context),
                    text: LocaleKeys.kTextSupport.tr(),
                    iconPath: Paths.menuSupportIconPath,
                  ),
                  MenuButton(
                    onPressed: () async => await Utils.openYouTube(context),
                    text: LocaleKeys.kTextOurYouTube.tr(),
                    iconPath: Paths.menuYoutubeIconPath,
                  ),
                  MenuButton(
                    onPressed: () => context
                        .read<NotificationCubit>()
                        .showInfoNotification(
                            context,
                            LocaleKeys.kTextThisSectionIsStillUnderDevelopment
                                .tr()),
                    text: LocaleKeys.kTextOurRuTube.tr(),
                    iconPath: Paths.menuRutubeIconPath,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    onPressed: () => _openFriendsScreen(context),
                    text: LocaleKeys.kTextFriends.tr(),
                    iconPath: Paths.menuFriendsIconPath,
                  ),
                  MenuButton(
                    onPressed: () => MenuScreenController.openSmbMenu(
                        context, Menu.airplaneSchedule),
                    text: LocaleKeys.kTextAirplaneSchedule.tr(),
                    iconPath: Paths.menuFlyIconPath,
                  ),
                  MenuButton(
                    onPressed: () => MenuScreenController.openSmbMenu(
                        context, Menu.bridgeSchedule),
                    text: LocaleKeys.kTextRaisingBridges.tr(),
                    iconPath: Paths.menuBridgeIconPath,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    onPressed: () => _openSettingsScreen(context),
                    text: LocaleKeys.kTextSettings.tr(),
                    iconPath: Paths.menuSettingsIconPath,
                  ),
                  MenuButton(
                    onPressed: () => _logOut(context),
                    text: LocaleKeys.kTextExit.tr(),
                    iconPath: Paths.menuExitIconPath,
                    iconPadding: 15.w,
                  ),
                  MenuButton(
                    onPressed: () => _openAnnouncementScreen(context),
                    text: LocaleKeys.kTextAdvertisements.tr(),
                    iconPath: Paths.menuAdvertisementsIconPath,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _openFriendsScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.friendsScreen,
    );
  }

  _openProfileScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.profileScreen,
    );
  }

  _openSettingsScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.settingsScreen,
    );
  }

  _openAnnouncementScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.announcementScreen,
    );
  }

  Future _logOut(BuildContext context) async {
    // отписка от топика SOS
    await FirebaseMessagingManager.unsubscribeFromTopic('newSOS');
    // отписка от топика админки
    await FirebaseMessagingManager.unsubscribeFromTopic('serviceMSG');
    // отписка от топика мостов
    await FirebaseMessagingManager.unsubscribeFromTopic('bridges');
    String? region = await SharedPreferencesHelper.getString(
        SharedPreferencesKeys.userRegion);
    if (region != null) {
      // отписка от топика региона
      await FirebaseMessagingManager.unsubscribeFromTopic(region);
      SharedPreferencesHelper.remove(SharedPreferencesKeys.userRegion);
    }

    SharedPreferencesHelper.remove(SharedPreferencesKeys.serverToken);
    context.read<NotificationCubit>().showSuccessNotification(
          context,
          LocaleKeys.kTextYouAreLoggedOutOfYourAccount.tr(),
        );
    LocationManager.stopBackgroundLocationService();
    Navigator.popAndPushNamed(
      context,
      Routes.loginScreen,
    );
  }
}
