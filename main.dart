import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helps_flutter/firebase_options.dart';
import 'package:helps_flutter/home.dart';
import 'package:helps_flutter/system/firebase_messaging_manager.dart';
import 'package:helps_flutter/system/notification_manager/notification_manager.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessagingManager.initialize();

  if (!kIsWeb) {
    await NotificationManager.initNotifications();
  }

  print("Токен FMS: ${await FirebaseMessagingManager.getDeviceToken()}");
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      startLocale: const Locale('ru'),
      child: const Home(),
    ),
  );
}
