import 'package:easy_localization/easy_localization.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/settings_screen/model/settings_model.dart';

class SettingsData {
  static List<List<SettingsModel>> settingsData = [
    [
      SettingsModel(
        name: LocaleKeys.kTextNotifications.tr(),
        groupName: LocaleKeys.kTextPushSOS.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushSos,
      ),
      SettingsModel(
        name: LocaleKeys.kTextSound.tr(),
        groupName: LocaleKeys.kTextPushSOS.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushSosSound,
      ),
    ],
    [
      SettingsModel(
        name: LocaleKeys.kTextNotifications.tr(),
        groupName: LocaleKeys.kTextPushBridges.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushBridge,
      ),
      SettingsModel(
        name: LocaleKeys.kTextSound.tr(),
        groupName: LocaleKeys.kTextPushBridges.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushBridgeSound,
      ),
    ],
    [
      SettingsModel(
        name: LocaleKeys.kTextNotifications.tr(),
        groupName: LocaleKeys.kTextPushDps.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushDps,
      ),
      SettingsModel(
        name: LocaleKeys.kTextSound.tr(),
        groupName: LocaleKeys.kTextPushDps.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushDpsSound,
      ),
    ],
    [
      SettingsModel(
        name: LocaleKeys.kTextNotifications.tr(),
        groupName: LocaleKeys.kTextPushOthers.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushOthers,
      ),
      SettingsModel(
        name: LocaleKeys.kTextSound.tr(),
        groupName: LocaleKeys.kTextPushOthers.tr(),
        sharedPreferencesKey: SharedPreferencesKeys.pushOthersSound,
      ),
    ]
  ];
}
