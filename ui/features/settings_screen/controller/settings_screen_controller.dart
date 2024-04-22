import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/data/api_data.dart';
import 'package:helps_flutter/api/model/api_response_model.dart';
import 'package:helps_flutter/api/model/user_model.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';

class SettingsScreenController {
  static Future<bool> putUserData(
      BuildContext context, UserModel userModel) async {
    ApiResponse response = await HelpsApi.putUser(userModel);
    if (response.status == ApiResponseStatus.error) {
      String? notificationMessage =
          ResponseAnswer.userResponseCodesData[response.responseCode];
      if (notificationMessage != null)
        context.read<NotificationCubit>().showErrorNotification(
              context,
              notificationMessage,
            );

      return false;
    }
    return true;
  }
}
