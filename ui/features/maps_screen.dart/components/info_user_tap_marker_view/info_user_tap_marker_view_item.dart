import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Импортируем пакет для доступа к буферу обмена
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';

class InfoUserTapMarkerViewItem extends StatelessWidget {
  const InfoUserTapMarkerViewItem({
    Key? key,
    required this.suffixText,
    required this.text,
    this.isCopy = false,
  }) : super(key: key);

  final String suffixText;
  final String text;
  final bool isCopy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          suffixText,
          style: UiConstants.kTextStyleText3.copyWith(
              color: UiConstants.kColorBackground, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          // Добавляем GestureDetector для обработки нажатия
          onTap: () {
            if (isCopy) {
              Clipboard.setData(
                  ClipboardData(text: text)); // Копируем текст в буфер обмена
              context.read<NotificationCubit>().showSuccessNotification(
                    context,
                    LocaleKeys.kTextPhoneCopied.tr(),
                  );
            }
          },
          child: Text(
            text,
            style: UiConstants.kTextStyleText3.copyWith(
              color: isCopy ? Colors.blue : UiConstants.kColorBackground,
              decoration: isCopy ? TextDecoration.underline : null,
              decorationColor: isCopy ? Colors.blue : null,
            ),
          ),
        ),
      ],
    );
  }
}
