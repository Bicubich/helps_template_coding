import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/model/lat_lon_model.dart';
import 'package:helps_flutter/model/sos_stream_model.dart';
import 'package:helps_flutter/system/location_manager.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/system/socket_manager.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_info_sheet.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/info_user_tap_marker_view/info_user_tap_marker_view.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/data/maps_screen_data.dart';

class MapsUtils {
  static Marker createMarker(BuildContext context, LatLng position,
      BitmapDescriptor icon, MarkerId markerId, double rotation, bool isVisible,
      {SosStreamModel? sosStreamModel = null, double opacity = 1}) {
    final Marker marker = Marker(
      alpha: opacity,
      markerId: markerId,
      position: position,
      icon: icon,
      onTap: () => showInfoUserSheet(context, sosStreamModel),
      rotation: rotation,
      visible: isVisible,
    );

    return marker;
  }

  static Future onSosTap(BuildContext context) async {
    Position? currentPosition = LocationManager.currentPosition;
    if (currentPosition != null) {
      bool isSuccess = await HelpsApi.postSos(
        UserPositionModel(
          lat: currentPosition.latitude,
          lon: currentPosition.longitude,
        ),
      );
      NotificationCubit notificationCubit = context.read<NotificationCubit>();
      if (isSuccess) {
        notificationCubit.showSuccessNotification(
          context,
          LocaleKeys.kTextYouAskedForHelp.tr(),
        );
        return;
      }
      notificationCubit.showErrorNotification(
        context,
        LocaleKeys.kTextSOSAlreadyActive.tr(),
      );
      return;
    }
  }

  static sendLongPressMark(double lat, double lon, String type) {
    // Создаем объект для отправки
    Map<String, dynamic> data = {
      'lat': lat,
      'lon': lon,
      'type': type,
    };

    // Отправляем данные на сервер через сокет
    SocketManager.emitData(data);
  }

  static Future<BitmapDescriptor> getMarkerIcon(
      String userId, bool isActive) async {
    String? myUserId =
        await SharedPreferencesHelper.getString(SharedPreferencesKeys.userId);
    final iconType = isActive
        ? (myUserId == userId ? mapsIconType.friendSos : mapsIconType.userSos)
        : (myUserId == userId ? mapsIconType.friend : mapsIconType.user);
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      MapsScreenData.mapsIcon[iconType]!,
    );
  }

  static showInfoUserSheet(
      BuildContext context, SosStreamModel? sosStreamModel) {
    if (sosStreamModel != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.r),
          ),
        ),
        builder: (newContext) => HelpsInfoSheet(
            title: LocaleKeys.kTextDriverInfo.tr(),
            body: InfoUserTapMarkerView(
              sosStreamModel: sosStreamModel,
            ),
            userPhone: sosStreamModel.user.phone!),
      );
    }
  }
}
