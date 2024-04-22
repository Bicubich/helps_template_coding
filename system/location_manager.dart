import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/permissions_screen/model/permission_model.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationManager {
  static Position? _currentPosition;
  static StreamController<Position?> positionStreamController =
      StreamController<Position?>.broadcast();

  static StreamSubscription<Position>? positionStream;

  static Position? get currentPosition => _currentPosition;

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> isLocationPermissionGranted(BuildContext context) async {
    List<PermissionModel> necessaryPermissions =
        await Utils.getNecessaryPermissions(context);
    bool bgLocationPermissionGranted = true;
    if (necessaryPermissions
        .any((element) => element.permission == Permission.locationAlways)) {
      bgLocationPermissionGranted = await Permission.locationAlways.isGranted;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    return permission != LocationPermission.denied &&
        bgLocationPermissionGranted;
  }

  static startBackgroundLocationService() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: _getLocationSettings(),
    ).listen((Position? position) {
      _currentPosition = position;
      positionStreamController.add(position);
      print('Pos: ${position?.latitude} : ${position?.longitude}');
    });
  }

  static stopBackgroundLocationService() {
    positionStream?.cancel();
  }

  static _getLocationSettings() {
    return (defaultTargetPlatform == TargetPlatform.android)
        ? AndroidSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            forceLocationManager: false,
            intervalDuration: const Duration(seconds: 5),
            foregroundNotificationConfig: ForegroundNotificationConfig(
              notificationText:
                  LocaleKeys.kTextLocationBackgroundNotificationText.tr(),
              notificationTitle:
                  LocaleKeys.kTextLocationBackgroundNotificationTitle.tr(),
              enableWakeLock: true,
              notificationIcon:
                  AndroidResource(name: '@mipmap/ic_notification'),
              color: Color(0xFF010203),
            ),
          )
        : (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS)
            ? AppleSettings(
                accuracy: LocationAccuracy.bestForNavigation,
                activityType: ActivityType.otherNavigation,
                pauseLocationUpdatesAutomatically: true,
                showBackgroundLocationIndicator: true,
              )
            : LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation,
              );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return await Geolocator.getLastKnownPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return await Geolocator.getLastKnownPosition();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return await Geolocator.getLastKnownPosition();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
