import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/system/camera/camera_backgroud_service.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:saver_gallery/saver_gallery.dart';

class CameraManager {
  static late CameraController _cameraController;
  static Timer? _videoTimer;

  static Future init() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[1], ResolutionPreset.low);
    await _cameraController.initialize();
  }

  static Future toggleVideoRecording(BuildContext context) async {
    if (_cameraController.value.isRecordingVideo)
      await stopRecording(context);
    else
      await startRecording(context);
  }

  static Future startRecording(BuildContext context) async {
    await _cameraController.startVideoRecording();
    if (_cameraController.value.isRecordingVideo) {
      //changeVideoStatusDataDB(true);
      context
          .read<NotificationCubit>()
          .showInfoNotification(context, 'Запись видео запущено');
      await CameraBackgroundService.startForegroundTask(context);
      _videoTimer = Timer(Duration(minutes: 15), () async {
        if (_videoTimer?.isActive == true) {
          await stopRecording(context);
        }
      });
    }
  }

  static Future stopRecording(BuildContext context) async {
    _videoTimer?.cancel();
    final XFile videoFile = await _cameraController.stopVideoRecording();
    if (!_cameraController.value.isRecordingVideo) {
      await CameraBackgroundService.stopForegroundTask();
    }
    final result = await SaverGallery.saveFile(videoFile.path);
    if (result.isSuccess) {
      context
          .read<NotificationCubit>()
          .showSuccessNotification(context, 'Видео успешно сохранено');
      HelpsApi.uploadVideo(File(videoFile.path));
    }
  }
}
