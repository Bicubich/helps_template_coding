import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/permissions_screen/cubit/permissions_screen_state.dart';
import 'package:helps_flutter/ui/features/permissions_screen/model/permission_model.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreenCubit extends Cubit<PermissionsScreenState> {
  final BuildContext context;
  PermissionsScreenCubit(this.context) : super(PermissionsScreenInitial()) {
    init();
  }

  List<PermissionModel> necessaryPermissions = [];

  init() async {
    necessaryPermissions = await Utils.getNecessaryPermissions(context);
    await _updatePermissions();
    emit(PermissionsScreenInitial());
  }

  bool isAllPermissionsGranted() {
    return necessaryPermissions.every((element) => element.isGranted);
  }

  Future requestPermissions(BuildContext context) async {
    for (PermissionModel permission in necessaryPermissions) {
      if (!permission.isGranted) {
        await permission.permission.onDeniedCallback(() {
          print('onDeniedCallback');
        }).onGrantedCallback(() {
          print('onGrantedCallback');
          _updatePermissions();
        }).onPermanentlyDeniedCallback(() async {
          context.read<NotificationCubit>().showErrorNotification(
                context,
                LocaleKeys.kTextRequestPermissionsError.tr(),
              );
          Future.delayed(Duration(seconds: 3))
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
    await _updatePermissions();
  }

  Future _updatePermissions() async {
    for (PermissionModel permission in necessaryPermissions) {
      permission.isGranted = await permission.permission.isGranted;
    }
    emit(PermissionsScreenUpdating());
    emit(PermissionsScreenInitial());
  }
}
