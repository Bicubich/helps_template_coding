import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:helps_flutter/firebase_options.dart';
import 'package:helps_flutter/system/notification_manager/notification_manager.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMessagingManager {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Метод для инициализации Firebase Cloud Messaging
  static initialize() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Установка обработчика для входящих сообщений
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      print("onMessage: ${message.notification?.title}");
      print("onMessage: ${message.notification?.body}");
      print("onMessage: ${message.data}");
      //HelpsNotificationType? notificationType;
      //String? payload;
      //// проверяем что нам надо сделать
      //switch (message.data['action']) {
      //  case 'MapsActivity':
      //    notificationType = HelpsNotificationType.sos;
      //    payload = 'sos:${message.data['_id']}';
      //    break;
      //  case 'bridgeScheduler':
      //    notificationType = HelpsNotificationType.bridges;
      //    break;
      //  default:
      //    notificationType = HelpsNotificationType.others;
    });

    //NotificationManager.showNotification(
    //  notificationType: notificationType,
    //  title: message.notification?.title ?? '',
    //  body: message.notification?.body ?? '',
    //  payload: payload,
    //);
    // Обработка входящего сообщения здесь
    //});
  }

  // Подписка на уведомления (если требуется)
  static subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  // Отписка от уведомлений (если требуется)
  static unsubscribeFromTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  // Метод для получения токена устройства
  static Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationManager.initNotifications();
  NotificationManager.showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}
