import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/cubit/maps_screen_cubit.dart';

class MapsCircleButton extends StatelessWidget {
  const MapsCircleButton({
    Key? key,
    this.text,
    this.iconPath,
    this.buttonSize,
    this.isSosButton = false,
    required this.onPressed,
  }) : super(key: key);

  final String? text;
  final String? iconPath;
  final double? buttonSize;
  final bool isSosButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    MapsScreenCubit mapsScreenCubit = context.read<MapsScreenCubit>();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isSosButton
            ? [
                const BoxShadow(
                  color: UiConstants.kColorPrimary, // Цвет тени
                  spreadRadius: 2, // Распространение тени
                  blurRadius: 10, // Размытие тени
                ),
              ]
            : null,
      ),
      child: Listener(
        onPointerDown: (details) {
          // проверка на нажатие сос кнопки
          if (isSosButton) {
            // нажимаем кнопку
            mapsScreenCubit.sosButtonPressed = true;
            // останавливаем таймер (в случае спама)
            mapsScreenCubit.sosTimer?.cancel();
            // запускаем таймер на 2 сек
            mapsScreenCubit.sosTimer =
                Timer.periodic(Duration(seconds: 2), (_) async {
              // условие на то, что таймер ещё работает (на тот случай, если мы остановили его при отжатии кнопки)
              if (mapsScreenCubit.sosTimer?.isActive == true &&
                  mapsScreenCubit.sosButtonPressed) onPressed();
              // останавливаем таймер спустя 2 секунды
              mapsScreenCubit.sosTimer?.cancel();
            });
          }
        },
        onPointerUp: (details) {
          if (isSosButton) {
            // отжимаем кнопку
            mapsScreenCubit.sosButtonPressed = false;
            // проверяем, идёт ли таймер (если нет, то функция уже выполнена, так как пользовать зажимал 2 секунды кнопку)
            if (mapsScreenCubit.sosTimer?.isActive == true) {
              // останавливаем таймер (для того, чтобы функция не выполнилась 2 раза - после 2сек. нажатия)
              mapsScreenCubit.sosTimer?.cancel();
              // показываем уведомление, что пользователь отжал кнопку и не прошло 2 секунды
              context.read<NotificationCubit>().showInfoNotification(
                    context,
                    LocaleKeys.kTextPressedButtonMoreSeconds.tr(),
                  );
            }
          }
        },
        child: RawMaterialButton(
          splashColor: isSosButton ? Colors.transparent : null,
          highlightColor: isSosButton ? Colors.transparent : null,
          highlightElevation: isSosButton ? 0 : 8,
          focusElevation: isSosButton ? 0 : 4,
          onPressed: () => !isSosButton ? onPressed() : null,
          elevation: 0.0,
          fillColor: isSosButton
              ? UiConstants.kColorError
              : UiConstants.kColorBase08.withOpacity(0.35),
          shape: const CircleBorder(),
          constraints: BoxConstraints.tightFor(
            width: buttonSize ?? 48.0,
            height: buttonSize ?? 48.0,
          ),
          child: text != null
              ? Text(
                  text ?? '',
                  style: isSosButton
                      ? UiConstants.kTextStyleText6.copyWith(
                          color: UiConstants.kColorPrimary,
                        )
                      : UiConstants.kTextStyleText2.copyWith(
                          color: UiConstants.kColorBase09,
                        ),
                  textAlign: TextAlign.center,
                )
              : iconPath != null
                  ? SvgPicture.asset(iconPath ?? '')
                  : Container(),
        ),
      ),
    );
  }
}
