import 'package:helps_flutter/system/notification_manager/data/helps_notification_data.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/system/sqllite_manager.dart';

class HelpsNotificationController {
  static Future<bool> getSoundStatus(
      HelpsNotificationType helpsNotificationType) async {
    String spKey = '';
    switch (helpsNotificationType) {
      case HelpsNotificationType.sos:
        spKey = SharedPreferencesKeys.pushSosSound;
        break;
      case HelpsNotificationType.dps:
        spKey = SharedPreferencesKeys.pushDpsSound;
        break;
      case HelpsNotificationType.bridges:
        spKey = SharedPreferencesKeys.pushBridgeSound;
        break;
      case HelpsNotificationType.others:
        spKey = SharedPreferencesKeys.pushOthersSound;
        break;
      default:
        spKey = '';
    }
    if (spKey.isNotEmpty) {
      await SqlLiteManager.initializeDatabase();
      bool result = SqlLiteManager.getSetting(spKey);
      SqlLiteManager.closeDatabase();
      return result;
    }
    return false;
  }

  static Future<bool> getVisibleStatus(
      HelpsNotificationType helpsNotificationType) async {
    String spKey = '';
    switch (helpsNotificationType) {
      case HelpsNotificationType.sos:
        spKey = SharedPreferencesKeys.pushSos;
        break;
      case HelpsNotificationType.dps:
        spKey = SharedPreferencesKeys.pushDps;
        break;
      case HelpsNotificationType.bridges:
        spKey = SharedPreferencesKeys.pushBridge;
        break;
      case HelpsNotificationType.others:
        spKey = SharedPreferencesKeys.pushOthers;
        break;
      default:
        spKey = '';
    }
    if (spKey.isNotEmpty) {
      await SqlLiteManager.initializeDatabase();
      bool result = SqlLiteManager.getSetting(spKey);
      SqlLiteManager.closeDatabase();
      return result;
    }
    return false;
  }
}
