import 'package:easy_localization/easy_localization.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/permissions_screen/model/permission_model.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionData {
  static List<PermissionModel> permissions = [
    PermissionModel(
      permission: Permission.camera,
      name: LocaleKeys.kTextCameraPermissionTitle.tr(),
      description: LocaleKeys.kTextCameraPermissionDescription.tr(),
    ),
    PermissionModel(
      permission: Permission.microphone,
      name: LocaleKeys.kTextMicrophonePermissionTitle.tr(),
      description: LocaleKeys.kTextMicrophonePermissionDescription.tr(),
    ),
    PermissionModel(
      permission: Permission.location,
      name: LocaleKeys.kTextLocationPermissionTitle.tr(),
      description: LocaleKeys.kTextLocationPermissionDescription.tr(),
    ),
    PermissionModel(
      minAndroidApiVersion: 29,
      permission: Permission.locationAlways,
      name: LocaleKeys.kTextBackgroundLocationPermissionTitle.tr(),
      description: LocaleKeys.kTextBackgroundLocationPermissionDescription.tr(),
    ),
    PermissionModel(
      minAndroidApiVersion: 30,
      permission: Permission.manageExternalStorage,
      name: LocaleKeys.kTextExternalStoragePermissionTitle.tr(),
      description: LocaleKeys.kTextExternalStoragePermissionDescription.tr(),
    ),
    PermissionModel(
      permission: Permission.notification,
      name: LocaleKeys.kTextPushNotificationPermissionTitle.tr(),
      description: LocaleKeys.kTextPushNotificationPermissionDescription.tr(),
    ),
    PermissionModel(
      permission: Permission.systemAlertWindow,
      name: LocaleKeys.kTextOnTopOfOtherAppsPermissionTitle.tr(),
      description: LocaleKeys.kTextOnTopOfOtherAppsPermissionDescription.tr(),
    ),
  ];
}
