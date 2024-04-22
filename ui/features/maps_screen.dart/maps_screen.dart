import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/camera/camera_manager.dart';
import 'package:helps_flutter/model/mark_stream_model.dart';
import 'package:helps_flutter/system/notification_manager/notification_manager.dart';
import 'package:helps_flutter/system/overlay_sos_service.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/system/sqllite_manager.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/maps_circle_button.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/maps_screen_loading_widget.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/maps_screen_location_permission_denied_widget.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/maps_screen_location_service_disable_widget.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/present_widget/present_widget.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/cubit/maps_screen_cubit.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/cubit/maps_screen_state.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/utils/maps_utils.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage
        .listen(NotificationManager.showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data['action'] == 'MapsActivity' &&
          message.data['_id'] != null) {
        await SqlLiteManager.initializeDatabase();
        SqlLiteManager.insertBufferData(message.data['_id']);
        await SqlLiteManager.closeDatabase();
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    didSmbWhenAppStateChanged(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future didSmbWhenAppStateChanged(AppLifecycleState state) async {
    String? token = await SharedPreferencesHelper.getString(
        SharedPreferencesKeys.serverToken);
    if (token != null) {
      switch (state) {
        // закрытие приложения (полностью)
        case AppLifecycleState.detached:
          print('AppLifecycleState: Приложение удалено из очереди\n');
          break;
        // сворачивание приложения
        case AppLifecycleState.paused:
          OverlaySosService(context).startBubble();
          print('AppLifecycleState: Приложение свёрнуто\n');
          break;
        // восстановление приложения
        case AppLifecycleState.resumed:
          OverlaySosService(context).stopBubble();
          print('AppLifecycleState: Работа приложения восстановлена\n');
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        return Utils.showAlertDialog(
          context,
          LocaleKeys.kTextCloseAppConfirmation.tr(),
          LocaleKeys.kTextYes.tr(),
          () => Utils.closeApp(),
          negativeText: LocaleKeys.kTextNo.tr(),
          onClickNegativeText: () => Navigator.pop(context),
        );
      },
      child: HelpsTemplate(
        body: BlocProvider(
          create: (context) =>
              MapsScreenCubit(context, googleMapsController: _controller),
          child: BlocBuilder<MapsScreenCubit, MapsScreenState>(
            builder: (context, state) {
              if (state is MapsScreenLoaded) {
                return Stack(
                  children: [
                    GoogleMap(
                        style: context.read<MapsScreenCubit>().mapStyle,
                        initialCameraPosition: context
                            .read<MapsScreenCubit>()
                            .initialCameraPosition!,
                        zoomControlsEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMove: (position) async {
                          final cubit = context.read<MapsScreenCubit>();
                          cubit.changeZoom(position.zoom, isCameraMove: true);
                          cubit.restartTimer();

                          final isVisitableMarks = cubit.isVisitableMarks;
                          final currentZoom = position.zoom;

                          if (currentZoom >= 11 && !isVisitableMarks) {
                            cubit.toggleMarksVisible(true);
                          } else if (currentZoom < 11 && isVisitableMarks) {
                            cubit.toggleMarksVisible(false);
                          }
                        },
                        onLongPress: (argument) {
                          if (state.currentZoom >= 17) {
                            Utils.showAlertDialog(
                              context,
                              'Вы хотите разместить пост ДПС?',
                              LocaleKeys.kTextYes.tr(),
                              () {
                                MapsUtils.sendLongPressMark(
                                    argument.latitude,
                                    argument.longitude,
                                    MarkStreamType.traffic_police.name);
                                Navigator.pop(context);
                              },
                              negativeText: LocaleKeys.kTextNo.tr(),
                              onClickNegativeText: () => Navigator.pop(context),
                            );
                          } else {
                            context
                                .read<NotificationCubit>()
                                .showInfoNotification(
                                  context,
                                  LocaleKeys.kTextUserMarkWarning.tr(),
                                );
                          }
                        },
                        markers: {
                          ...state.userPointList.map((e) => e.marker).toSet(),
                          ...state.nonUserMarks
                        }),
                    Padding(
                      padding: UiConstants.appPaddingHorizontal +
                          getMarginOrPadding(top: 15) +
                          UiConstants.appPaddingVertical,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PresentWidget(),
                              MapsCircleButton(
                                text: LocaleKeys.kTextMenu.tr(),
                                buttonSize: 75.w,
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  Routes.menuScreen,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 182.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  MapsCircleButton(
                                    iconPath: Paths.zoomInIconPath,
                                    buttonSize: 40.w,
                                    onPressed: () async => await context
                                        .read<MapsScreenCubit>()
                                        .onZoomIn(),
                                  ),
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  MapsCircleButton(
                                    iconPath: Paths.zoomOutIconPath,
                                    buttonSize: 40.w,
                                    onPressed: () async => await context
                                        .read<MapsScreenCubit>()
                                        .onZoomOut(),
                                  ),
                                ],
                              ),
                              MapsCircleButton(
                                iconPath: Paths.locationIconPath,
                                buttonSize: 60.w,
                                onPressed: () async => await context
                                    .read<MapsScreenCubit>()
                                    .onCurrentPosition(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //MapsCircleButton(
                              //  iconPath: Paths.friendsIconPath,
                              //  buttonSize: 60.w,
                              //  onPressed: () => context
                              //      .read<NotificationCubit>()
                              //      .showInfoNotification(context,
                              //          LocaleKeys.kTextFriendsMode.tr()),
                              //),
                              Container(
                                width: 60.w,
                              ),
                              MapsCircleButton(
                                text: LocaleKeys.kTextSOS.tr(),
                                isSosButton: true,
                                iconPath: Paths.cameraIconPath,
                                buttonSize: 100.w,
                                onPressed: () => MapsUtils.onSosTap(context),
                              ),
                              MapsCircleButton(
                                iconPath: Paths.cameraIconPath,
                                buttonSize: 60.w,
                                onPressed: () => recordingVideo(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is MapsScreenLocationPermissionDenied) {
                return MapsScreenLocationPermissionDeniedWidget();
              } else if (state is MapsScreenLocationServiceDisable) {
                return MapsScreenLocationServiceDisableWidget();
              } else {
                return MapsScreenLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Future recordingVideo(BuildContext context) async {
    await CameraManager.toggleVideoRecording(context);
  }
}
