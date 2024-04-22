import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:toastification/toastification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Toastification toastification = Toastification();
  ToastificationItem? toastificationItem;

  showSuccessNotification(BuildContext context, String text,
      {String? description}) {
    _buildNotification(context, ToastificationType.success, text,
        description: description);
  }

  showErrorNotification(BuildContext context, String text,
      {String? description}) {
    _buildNotification(context, ToastificationType.error, text,
        description: description);
  }

  showInfoNotification(BuildContext context, String text,
      {String? description}) {
    _buildNotification(context, ToastificationType.info, text,
        description: description);
  }

  showWarningNotification(BuildContext context, String text,
      {String? description}) {
    _buildNotification(context, ToastificationType.warning, text,
        description: description);
  }

  _buildNotification(
      BuildContext context, ToastificationType toastificationType, String title,
      {String? description}) {
    if (toastificationItem != null) {
      toastification.dismiss(toastificationItem!);
    }
    toastificationItem = toastification.show(
      context: context,
      type: toastificationType,
      style: ToastificationStyle.fillColored,
      primaryColor: Utils.getToastificationColor(toastificationType),
      backgroundColor: UiConstants.kColorBase01,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      padding: getMarginOrPadding(left: 12, right: 12, top: 16, bottom: 16),
      margin: getMarginOrPadding(left: 12, right: 12, top: 8, bottom: 8),
      borderRadius: BorderRadius.circular(12.r),
      icon: Utils.getToastificationIcon(toastificationType),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      direction: TextDirection.ltr,
      title: Text(
        title,
        style:
            UiConstants.kTextStyleText9.copyWith(fontWeight: FontWeight.w700),
      ),
      description: description != null
          ? RichText(
              text: TextSpan(
                text: description,
                style: UiConstants.kTextStyleText10,
              ),
            )
          : null,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}
