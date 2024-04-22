import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/model/coordinates_model.dart' as cm;
import 'package:helps_flutter/api/model/lat_lon_model.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/system/camera/camera_backgroud_service.dart';
import 'package:helps_flutter/system/camera/camera_manager.dart';
import 'package:helps_flutter/model/mark_stream_model.dart';
import 'package:helps_flutter/model/sos_stream_model.dart';
import 'package:helps_flutter/model/user_stream_model.dart';
import 'package:helps_flutter/system/firebase_messaging_manager.dart';
import 'package:helps_flutter/system/location_manager.dart';
import 'package:helps_flutter/system/notification_manager/notification_manager.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/system/socket_manager.dart';
import 'package:helps_flutter/system/sqllite_manager.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/cubit/maps_screen_state.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/data/maps_screen_data.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/model/user_point_model.dart';
import 'package:collection/collection.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/utils/maps_utils.dart';

class MapsScreenCubit extends Cubit<MapsScreenState> {
  final BuildContext context;
  final Completer<GoogleMapController> googleMapsController;
  MapsScreenCubit(this.context, {required this.googleMapsController})
      : super(MapsScreenLoading()) {
    init();
  }

  StreamSubscription<Position?>? positionStreamSubscription;
  Stream<UserStreamModel?>? userStream;
  Stream<SosStreamModel?>? sosStream;
  Stream<MarkStreamModel?>? markStream;
  Stream<String?>? userDisconnectStream;
  late String mapStyle;
  CameraPosition? initialCameraPosition;
  double defaultZoom = 18;
  double currentZoom = 18;
  List<UserPointModel> userPointList = [];
  List<Marker> nonUserMarks = [];
  Timer? _attachTimer;
  Map<String, DateTime> _dpsNotificationCleanerMap = {};
  Timer? _dpsNotificationCleanTimer;
  bool _isAttachTimerBlock = false;
  Timer? sosTimer;
  bool isAllFuturesEnabled = false;
  bool sosButtonPressed = false;
  bool isVisitableMarks = true;
  String? clientUserId;

  Future init() async {
    clientUserId =
        await SharedPreferencesHelper.getString(SharedPreferencesKeys.userId);
    // инициализация камеры
    await CameraManager.init();
    // инициализация сервиса камеры
    await CameraBackgroundService.init();
    mapStyle = await rootBundle.loadString(Paths.mapStylePath);
    // подписка на топик SOS
    await FirebaseMessagingManager.subscribeToTopic('newSOS');
    // уведомление от админки
    await FirebaseMessagingManager.subscribeToTopic('serviceMSG');
    _initFuturesEnabledTimer();
  }

  Future onZoomIn() async {
    final GoogleMapController controller = await googleMapsController.future;
    double zoomLevel = await controller.getZoomLevel();
    changeZoom(zoomLevel + 1, controller: controller);
  }

  Future onZoomOut() async {
    final GoogleMapController controller = await googleMapsController.future;
    double zoomLevel = await controller.getZoomLevel();
    changeZoom(zoomLevel - 1, controller: controller);
  }

  Future onCurrentPosition() async {
    _isAttachTimerBlock = false;
    final GoogleMapController controller = await googleMapsController.future;
    _changePosition(
        defaultZoom, (state as MapsScreenLoaded).userPosition, controller);
  }

  Future changeZoom(double newZoom,
      {GoogleMapController? controller, bool isCameraMove = false}) async {
    GoogleMapController? gController = controller;
    if (gController == null) {
      gController = await googleMapsController.future;
    }
    newZoom = newZoom.clamp(0, 20);
    // тогда, когда мы не нажимали на кнопку масштабирования
    if (!isCameraMove) {
      gController.animateCamera(CameraUpdate.newLatLngZoom(
        (state as MapsScreenLoaded).userPosition,
        newZoom,
      ));
    }
    emit(
      (state as MapsScreenLoaded).copyWith(currentZoom: newZoom),
    );
  }

  Future _changePosition(
      double zoom, LatLng position, GoogleMapController controller) async {
    controller.animateCamera(CameraUpdate.newLatLngZoom(
      position,
      zoom,
    ));
    emit(
      (state as MapsScreenLoaded)
          .copyWith(currentZoom: zoom, userPosition: position),
    );
  }

  _initPositionListener() {
    // слушатель позиции пользователя
    LocationManager.positionStreamController.stream.listen((position) async {
      if (position != null) {
        initialCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: defaultZoom);
        cm.CoordinatesModel? coordinates = await HelpsApi.putCoordinates(
          UserPositionModel(
            lat: position.latitude,
            lon: position.longitude,
            angle: position.heading.toInt(),
          ),
        );
        // добавляем список метод рядов в список и вызываем уведомление
        for (cm.MarksInRange mark in coordinates?.marksInRange ?? []) {
          String? markId = _dpsNotificationCleanerMap.keys
              .firstWhereOrNull((key) => key == mark.id);
          if (markId == null) {
            _dpsNotificationCleanerMap[mark.id] =
                DateTime.now().add(Duration(minutes: 5));
            NotificationManager.showFlutterNotification(RemoteMessage(
                messageId: markId,
                data: {
                  'title': 'Пост ДПС рядом',
                  'action': 'dps',
                  '_id': mark.id
                }));
          }
        }

        if (!(state is MapsScreenLoaded)) {
          emit(
            MapsScreenLoaded(
                userPosition: _getUserPositionDevice(),
                currentZoom: defaultZoom,
                userPointList: userPointList,
                nonUserMarks: nonUserMarks),
          );
          SocketManager.initSocket(context);
        }
      } else {
        emit(MapsScreenLoading());
      }
    });
  }

  // Назначение функции:
  // - 1. Прослушивает событие сокета, когда пользователи делают запрос о помощи
  // - 2. Находит и обновляет данные о SOS
  _initSosStreamListener() {
    SocketManager.sosStream.listen((sosStreamModel) async {
      if (sosStreamModel == null) return;

      UserPointModel? userPoint = userPointList.firstWhereOrNull(
        (userPoint) =>
            userPoint.marker.markerId.value == sosStreamModel.user.id,
      );

      final isActive = sosStreamModel.isActive;
      final position = LatLng(sosStreamModel.lat, sosStreamModel.lon);
      final icon =
          await MapsUtils.getMarkerIcon(sosStreamModel.user.id, isActive);

      if (userPoint != null) {}

      if (userPoint?.animationTimer?.isActive != true &&
          sosStreamModel.isActive) {}

      final marker = MapsUtils.createMarker(
          context,
          position,
          icon,
          MarkerId(sosStreamModel.user.id),
          userPoint?.userStream?.angle ?? 0,
          userPoint?.userStream == null ? false : isVisitableMarks,
          sosStreamModel: isActive ? sosStreamModel : null);

      if (userPoint != null) {
        userPoint.marker = marker;
        userPoint.sosStream = isActive ? sosStreamModel : null;
        // анимация
        if (isActive && userPoint.animationTimer == null) {
          userPoint.animationTimer = _startAnimationSosMarker(userPoint);
        } else {
          userPoint.animationTimer?.cancel();
          userPoint.animationTimer = null;
        }
      } else {
        userPoint = UserPointModel(
            marker: marker,
            userStream: null,
            sosStream: isActive ? sosStreamModel : null,
            animationTimer: null);
        // анимация
        if (isActive && userPoint.animationTimer == null) {
          userPoint.animationTimer = _startAnimationSosMarker(userPoint);
        } else {
          userPoint.animationTimer?.cancel();
          userPoint.animationTimer = null;
        }
        userPointList.add(userPoint);
      }

      if (userPoint.animationTimer == null) {
        emit((state as MapsScreenLoaded).copyWith(
          userPointList: userPointList,
        ));
      }
    });
  }

  Timer _startAnimationSosMarker(UserPointModel userPoint) {
    return Timer.periodic(Duration(milliseconds: 50), (timer) {
      Marker currentMarker = userPoint.marker;

      Marker marker = MapsUtils.createMarker(
          context,
          currentMarker.position,
          currentMarker.icon,
          currentMarker.markerId,
          currentMarker.rotation,
          isVisitableMarks,
          sosStreamModel: userPoint.sosStream,
          opacity: _getOpacity(userPoint, currentMarker.alpha));
      userPoint.marker = marker;

      emit(
        MapsScreenLoaded(
            userPosition: _getUserPositionDevice(),
            currentZoom: defaultZoom,
            userPointList: [],
            nonUserMarks: nonUserMarks),
      );

      emit((state as MapsScreenLoaded).copyWith(
        userPointList: userPointList,
      ));
    });
  }

  double _getOpacity(UserPointModel userPoint, double opacity) {
    double step = 0.1;
    if (opacity == 1) {
      userPoint.isAnimationReversed = true;
    } else if (opacity == 0.1) {
      userPoint.isAnimationReversed = false;
    }
    double result =
        userPoint.isAnimationReversed ? opacity -= step : opacity += step;
    result = double.parse(result.toStringAsFixed(2));
    return result;
  }

  // Назначение функции:
  // - 1. Прослушивает событие сокета, когда пользователи отправляют свои координаты на сервер
  // - 2. Находит и обновляет данные о пользователе
  // - 3. Добавляет пользователя в список, если такого ещё нет
  _initUserStreamListener() {
    SocketManager.userStream.listen((userStreamModel) async {
      if (userStreamModel == null) return;

      final userPoint = userPointList.firstWhereOrNull(
        (userPoint) => userPoint.marker.markerId.value == userStreamModel.user,
      );

      final position = LatLng(userStreamModel.lat, userStreamModel.lon);
      final icon = await MapsUtils.getMarkerIcon(
          userStreamModel.user, userPoint?.sosStream?.isActive ?? false);

      final marker = MapsUtils.createMarker(
        context,
        position,
        icon,
        MarkerId(userStreamModel.user),
        userStreamModel.angle,
        isVisitableMarks,
        sosStreamModel: userPoint?.sosStream,
      );

      if (userPoint != null) {
        userPoint.marker = marker;
        userPoint.userStream = userStreamModel;
      } else {
        userPointList
            .add(UserPointModel(marker: marker, userStream: userStreamModel));
      }

      _checkRedirectMessageData(userPoint);

      if (userPoint?.animationTimer == null) {
        emit(
          MapsScreenLoaded(
              userPosition: _getUserPositionDevice(),
              currentZoom: defaultZoom,
              userPointList: userPointList,
              nonUserMarks: nonUserMarks),
        );

        emit((state as MapsScreenLoaded).copyWith(
          userPointList: userPointList,
        ));
      }
    });
  }

  // Назначение функции:
  // - 1. Прослушивает событие сокета, когда нужно разместить на карте непользовательскую метку (ДПС)
  // - 2. Добавляет и удаляет метку из из списка
  _initMarkStreamListener() {
    // слушатель непользовательских меток
    SocketManager.markStream.listen((markStreamModel) async {
      if (markStreamModel != null) {
        if (markStreamModel.isActive) {
          LatLng position = LatLng(markStreamModel.lat!, markStreamModel.lon!);

          mapsIconType iconType =
              MarkStreamType.traffic_police.name == markStreamModel.type
                  ? mapsIconType.dps_150
                  : mapsIconType.girl_150;

          BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(10000, 10000)),
              MapsScreenData.mapsIcon[iconType]!);

          nonUserMarks.add(MapsUtils.createMarker(context, position, icon,
              MarkerId(markStreamModel.id), 0, isVisitableMarks));
        } else {
          nonUserMarks.removeWhere(
            (mark) => mark.markerId == MarkerId(markStreamModel.id),
          );
        }

        MapsScreenLoaded(
            userPosition: _getUserPositionDevice(),
            currentZoom: defaultZoom,
            userPointList: userPointList,
            nonUserMarks: []);

        emit((state as MapsScreenLoaded).copyWith(
          nonUserMarks: nonUserMarks,
        ));
      }
    });
  }

  // Назначение функции:
  // - 1. Прослушивает событие сокета, когда пользователь отключается от сокета
  // - 2. Удаляет пользователя из списка, чтобы он больше не рендерился
  _initUserDisconnectStreamListener() {
    // слушатель отключения пользователей
    SocketManager.userDisconnectStream.listen((userId) async {
      if (userId == null) return null;

      userPointList.removeWhere(
        (userPoint) => userPoint.marker.markerId.value == userId,
      );

      emit((state as MapsScreenLoaded).copyWith(
        userPointList: userPointList,
      ));
    });
  }

  void toggleMarksVisible(bool isNeedShow) {
    isVisitableMarks = isNeedShow;
    userPointList.forEach((userPoint) {
      userPoint.marker = userPoint.marker.copyWith(visibleParam: isNeedShow);
    });

    nonUserMarks.forEach((marker) {
      marker = marker.copyWith(visibleParam: isNeedShow);
    });
    emit((state as MapsScreenLoaded)
        .copyWith(nonUserMarks: nonUserMarks, userPointList: userPointList));
  }

  _startAttachTimer() {
    if (_attachTimer?.isActive != true && !_isAttachTimerBlock) {
      _attachTimer = Timer.periodic(Duration(seconds: 5), (_) async {
        if (_attachTimer?.isActive == true &&
            LocationManager.currentPosition != null) {
          await onCurrentPosition();
        }
      });
    }
  }

  stopAttachTimer() {
    _attachTimer?.cancel();
  }

  restartTimer() {
    _attachTimer?.cancel();
    _startAttachTimer();
  }

  // таймер, чтобы удалять из map объекты уведомления о дпс, чтобы их через 5 минут снова показать
  _startDpsNotificationCleanTimer() {
    if (_dpsNotificationCleanTimer?.isActive != true) {
      _dpsNotificationCleanTimer =
          Timer.periodic(Duration(minutes: 5), (_) async {
        List keysToRemove = [];
        _dpsNotificationCleanerMap.forEach((key, value) {
          if (value.isAfter(DateTime.now())) {
            keysToRemove.add(key);
          }
        });

        // Удалить ключи после завершения итерации
        keysToRemove.forEach((key) {
          _dpsNotificationCleanerMap.remove(key);
        });
      });
    }
  }

  // функция проверяет предоставленные разрешения и сервисы
  _initFuturesEnabledTimer() {
    Timer.periodic(Duration(seconds: 2), (_) async {
      final isLocationPermissionGranted =
          await LocationManager.isLocationPermissionGranted(context);
      final isLocationServiceEnabled =
          await LocationManager.isLocationServiceEnabled();

      if (!isLocationPermissionGranted) {
        _stopAllService();
        emit(MapsScreenLocationPermissionDenied());
      } else if (!isLocationServiceEnabled) {
        _stopAllService();
        emit(MapsScreenLocationServiceDisable());
      } else {
        if (!isAllFuturesEnabled) {
          emit(MapsScreenLoading());
          _startAllService();
        }
      }
    });
  }

  // функция проверяет id пользователей, которые позвали на помощь (редирект с push-сообщения)
  Future _checkRedirectMessageData(UserPointModel? userPoint) async {
    if (userPoint?.sosStream?.isActive == true) {
      await SqlLiteManager.initializeDatabase();
      String? userId = SqlLiteManager.getFirstBufferData();
      print("$userId");
      if (userId != null) {
        _isAttachTimerBlock = true;
        _attachTimer?.cancel();
        Future.delayed(Duration(minutes: 5)).then((value) {
          if (_attachTimer?.isActive == false) {
            _isAttachTimerBlock = false;
            _startAttachTimer();
          }
        });
        final GoogleMapController controller =
            await googleMapsController.future;
        await _changePosition(
            defaultZoom,
            LatLng(userPoint!.userStream!.lat, userPoint.userStream!.lon),
            controller);
        SqlLiteManager.clearBufferData();
      }
      await SqlLiteManager.closeDatabase();
    }
  }

  _startAllService() {
    isAllFuturesEnabled = true;
    LocationManager.startBackgroundLocationService();
    _initPositionListener();
    _initUserStreamListener();
    _initSosStreamListener();
    _initMarkStreamListener();
    _initUserDisconnectStreamListener();
    _startAttachTimer();
    _startDpsNotificationCleanTimer();
  }

  _stopAllService() {
    isAllFuturesEnabled = false;
    LocationManager.stopBackgroundLocationService();
    positionStreamSubscription = null;
    userStream = null;
    sosStream = null;
    markStream = null;
    userDisconnectStream = null;
    _attachTimer?.cancel();
    SocketManager.disposeSocket();
  }

  // определение координат именно того пользователя, который в данный момент пользуется устройством
  LatLng _getUserPositionDevice() {
    // это нужно для того, чтобы не приближать хаотично ко всем при обновлении состояния, когда много у кого сос
    UserPointModel? currentDeviceUser = userPointList.firstWhereOrNull(
        (element) => element.marker.markerId.value == clientUserId);
    return currentDeviceUser != null
        ? currentDeviceUser.marker.position
        : initialCameraPosition!.target;
  }
}
