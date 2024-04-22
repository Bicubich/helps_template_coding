import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/api/api.dart';
import 'package:helps_flutter/api/model/announcement_response_model.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/model/announcement_model.dart';

class AnnouncementController {
  static Future deleteAnnouncement(BuildContext context, String id) async {
    bool isSuccess = await HelpsApi.deleteAnnouncement(id);
    isSuccess
        ? context.read<NotificationCubit>().showSuccessNotification(
            context, LocaleKeys.kTextAdSuccessfullyDeleted.tr())
        : context
            .read<NotificationCubit>()
            .showErrorNotification(context, LocaleKeys.kTextErrorOccurred.tr());
  }

  static Future changeAnnouncementVisible(
      AnnouncementResponseModel announcement) async {
    await HelpsApi.changeAnnouncementVisible(
        announcement.id, announcement.isActive);
  }

  static Future createAnnouncement(
      BuildContext context, AnnouncementModel announcement) async {
    bool isSuccess = await HelpsApi.addAnnouncement(announcement);
    if (isSuccess) {
      context.read<NotificationCubit>().showSuccessNotification(
          context, LocaleKeys.kTextAdSuccessfullyCreated.tr());
      Navigator.pushReplacementNamed(
        context,
        Routes.announcementViewScreen,
        arguments: {
          'myAnnouncement': true,
        },
      );
    } else {
      context
          .read<NotificationCubit>()
          .showErrorNotification(context, LocaleKeys.kTextErrorOccurred.tr());
    }
  }
}
