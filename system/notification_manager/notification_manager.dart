import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helps_flutter/system/notification_manager/controller/helps_notification_controller.dart';
import 'package:helps_flutter/system/notification_manager/data/helps_notification_data.dart';
import 'package:helps_flutter/system/sqllite_manager.dart';

class NotificationManager {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late AndroidNotificationChannel channel;
  static bool isFlutterLocalNotificationsInitialized = false;

  static Future initNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    //await FirebaseMessaging.instance
    //    .setForegroundNotificationPresentationOptions(
    //  alert: false,
    //  badge: false,
    //  sound: false,
    //);

    isFlutterLocalNotificationsInitialized = true;

    await _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
      ),
      onDidReceiveNotificationResponse: (data) async {
        // проверяем передан ли payload
        if (data.payload != null) {
          // получаем список из данных
          final payloadParts = data.payload!.split(':');
          // если список больше чем из 1 элемента и в нем есть элемент sos, то сохраняем в память
          if (payloadParts.length > 1 && payloadParts.first == 'sos') {
            await SqlLiteManager.initializeDatabase();
            SqlLiteManager.insertBufferData(payloadParts.last);
            SqlLiteManager.closeDatabase();
          }
        }
        print("Уведомление нажато, payload: ${data.payload}");
      },
    );
  }

  static Future showFlutterNotification(RemoteMessage remoteMessage) async {
    const String channelWithSound = HelpsNotificationData.channelWitSound;
    const String channelWithoutSound =
        HelpsNotificationData.channelWithoutSound;
    const String sosChannelId = HelpsNotificationData.sosChannelId;
    const String sosChannelWithoutSoundId =
        HelpsNotificationData.sosChannelWithoutSoundId;
    const String dpsChannelId = HelpsNotificationData.dpsChannelId;
    const String dpsChannelWithoutSoundId =
        HelpsNotificationData.dpsChannelWithoutSoundId;
    const String bridgesChannelId = HelpsNotificationData.bridgesChannelId;
    const String bridgesChannelWithoutSoundId =
        HelpsNotificationData.bridgesChannelWithoutSoundId;
    const String othersChannelId = HelpsNotificationData.othersChannelId;
    const String othersChannelWithoutSoundId =
        HelpsNotificationData.othersChannelWithoutSoundId;

    String channelId = '';
    String channelName = '';

    HelpsNotificationType notificationType;
    String? payload;
    switch (remoteMessage.data['action']) {
      case 'MapsActivity':
        notificationType = HelpsNotificationType.sos;
        payload = 'sos:${remoteMessage.data['_id']}';
        break;
      case 'dps':
        notificationType = HelpsNotificationType.dps;
        payload = 'dps:${remoteMessage.data['_id']}';
        break;
      case 'bridgeScheduler':
        notificationType = HelpsNotificationType.bridges;
        break;
      default:
        notificationType = HelpsNotificationType.others;
    }

    bool isSoundEnabled =
        await HelpsNotificationController.getSoundStatus(notificationType);

    channelName = isSoundEnabled ? channelWithSound : channelWithoutSound;

    if (notificationType == HelpsNotificationType.sos) {
      channelId = isSoundEnabled ? sosChannelId : sosChannelWithoutSoundId;
    } else if (notificationType == HelpsNotificationType.dps) {
      channelId = isSoundEnabled ? dpsChannelId : dpsChannelWithoutSoundId;
    } else if (notificationType == HelpsNotificationType.bridges) {
      channelId =
          isSoundEnabled ? bridgesChannelId : bridgesChannelWithoutSoundId;
    } else {
      channelId =
          isSoundEnabled ? othersChannelId : othersChannelWithoutSoundId;
    }

    bool isVisibleEnabled =
        await HelpsNotificationController.getVisibleStatus(notificationType);

    print('isVisibleEnabled: $isVisibleEnabled');

    if (isVisibleEnabled) {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(channelId, channelName,
              importance: Importance.max,
              playSound: isSoundEnabled,
              enableVibration: isSoundEnabled,
              //channelDescription: channel.description,
              // отвечает за то, чтобы не показывать на экране уведомление
              //silent: true,
              icon: 'ic_notification');

      final DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
        presentSound: isSoundEnabled,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: darwinNotificationDetails);

      await _flutterLocalNotificationsPlugin.show(
        0,
        remoteMessage.data['title'] ?? '',
        remoteMessage.data['body'] ?? null,
        platformChannelSpecifics,
        payload: payload,
      );
    }
  }
}

@pragma('vm:entry-point')
notificationTapBackground(NotificationResponse notificationResponse) {
  print('1');
}
