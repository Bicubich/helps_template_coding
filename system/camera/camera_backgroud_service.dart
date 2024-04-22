import 'dart:async';
import 'dart:isolate';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/system/camera/camera_manager.dart';

class CameraBackgroundService {
  static ReceivePort? _receivePort;

  static Future init() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        priority: NotificationPriority.MAX,
        channelImportance: NotificationChannelImportance.MAX,
        iconData: const NotificationIconData(
          resType: ResourceType.drawable,
          resPrefix: ResourcePrefix.ic,
          name: 'notification',
        ),
        buttons: [
          const NotificationButton(
              id: 'sendButton',
              text: 'Остановить',
              textColor: UiConstants.kColorError),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 1000,
        isOnceEvent: true,
        autoRunOnBoot: false,
        allowWakeLock: false,
        allowWifiLock: false,
      ),
    );
  }

  static Future<bool> startForegroundTask(BuildContext context) async {
    // Register the receivePort before starting the service.
    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = _registerReceivePort(receivePort, context);
    if (!isRegistered) {
      print('Failed to register receivePort!');
      return false;
    }

    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Запись видео',
        notificationText: 'Нажмите Остановить, чтобы прервать запись',
        callback: startCallback,
      );
    }
  }

  static Future stopForegroundTask() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
      _closeReceivePort(); // закрыть порт при остановке сервиса
    }
  }

  static bool _registerReceivePort(
      ReceivePort? newReceivePort, BuildContext context) {
    if (newReceivePort == null) {
      return false;
    }

    _closeReceivePort();

    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      if (data is int) {
        print('eventCount: $data');
      } else if (data is String) {
        if (data == 'onNotificationPressed') {
          //Navigator.of(context).pushNamed('/resume-route');
        } else if (data == 'sendButton') {
          CameraManager.stopRecording(context);
        }
      } else if (data is DateTime) {
        print('timestamp: ${data.toString()}');
      }
    });

    return _receivePort != null;
  }

  static _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }
}

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  // Called when the task is started.
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    // You can use the getData function to get the stored data.
    final customData =
        await FlutterForegroundTask.getData<String>(key: 'customData');
    print('customData: $customData');
  }

// Called every [interval] milliseconds in [ForegroundTaskOptions].
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // Send string representation of timestamp to the main isolate.
    sendPort?.send(timestamp.toString());
  }

  // Called when the notification button on the Android platform is pressed.
  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {
    //stopEvent();
  }

  // Called when the notification button on the Android platform is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    _sendPort?.send(id);
  }

  // Called when the notification itself on the Android platform is pressed.
  //
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // this function to be called.
  @override
  void onNotificationPressed() {
    // Note that the app will only route to "/resume-route" when it is exited so
    // it will usually be necessary to send a message through the send port to
    // signal it to restore state when the app is already started.
    FlutterForegroundTask.launchApp("/resume-route");
    _sendPort?.send('onNotificationPressed');
  }

  // функция нужна для того, чтобы записать в БД запись, которая соответствует состоянию видео
  //void stopEvent() {
  //  SqlLiteManager.initializeDatabase();
  //  SqlLiteManager.insertSetting('is_video_recording', false);
  //  SqlLiteManager.closeDatabase();
  //}
}
