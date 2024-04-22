import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/permissions_screen/model/permission_model.dart';
import 'package:permission_handler/permission_handler.dart';

class MapsScreenLocationPermissionDeniedWidget extends StatelessWidget {
  const MapsScreenLocationPermissionDeniedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding:
          UiConstants.appPaddingHorizontal + UiConstants.appPaddingVertical,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            LocaleKeys.kTextLocationPermissionExplanation.tr(),
            textAlign: TextAlign.center,
            style: UiConstants.kTextStyleText5.copyWith(
              color: UiConstants.kColorBase01,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HelpsButton(
              onTap: () => requestLocationPermission(context),
              text: LocaleKeys.kTextGrantPermission.tr(),
            ),
          )
        ],
      ),
    );
  }

  Future requestLocationPermission(BuildContext context) async {
    List<PermissionModel> necessaryPermissions =
        await Utils.getNecessaryPermissions(context);
    // оставляем разрешения для локации
    necessaryPermissions = necessaryPermissions
        .where((element) =>
            element.permission == Permission.location ||
            element.permission == Permission.locationAlways)
        .toList();
    for (var permission in necessaryPermissions) {
      await permission.permission.onDeniedCallback(() {
        print('onDeniedCallback');
      }).onGrantedCallback(() {
        print('onGrantedCallback');
      }).onPermanentlyDeniedCallback(() async {
        context.read<NotificationCubit>().showErrorNotification(
              context,
              LocaleKeys.kTextRequestPermissionsError.tr(),
            );
        await Future.delayed(Duration(seconds: 3))
            .then((value) async => await openAppSettings());
      }).onRestrictedCallback(() {
        print('onRestrictedCallback');
      }).onLimitedCallback(() {
        print('onLimitedCallback');
      }).onProvisionalCallback(() {
        print('onProvisionalCallback');
      }).request();
    }
  }
}
