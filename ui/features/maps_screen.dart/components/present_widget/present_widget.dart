import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/maps_screen.dart/components/present_widget/cubit/present_widget_cubit.dart';

class PresentWidget extends StatefulWidget {
  const PresentWidget({super.key});

  @override
  State<PresentWidget> createState() => _PresentWidgetState();
}

class _PresentWidgetState extends State<PresentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Продолжительность вашей анимации
    )..repeat(reverse: true); // Повторять анимацию в обе стороны
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PresentWidgetCubit(),
      child: BlocBuilder<PresentWidgetCubit, int?>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => state == 0
                ? Utils.showAlertDialog(
                    context,
                    LocaleKeys.kTextNewGift.tr(),
                    LocaleKeys.kTextGet.tr(),
                    () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        Routes.friendsScreen,
                      );
                    },
                    negativeText: LocaleKeys.kTextLater.tr(),
                    onClickNegativeText: () => Navigator.pop(context),
                  )
                : context.read<NotificationCubit>().showInfoNotification(
                      context,
                      LocaleKeys.kTextGiftSoonYours.tr(),
                    ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.1).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0.99, end: 1.01).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Text(
                      LocaleKeys.kTextFreeGift.tr(),
                      textAlign: TextAlign.center,
                      style: UiConstants.kTextStyleText10.copyWith(
                          color: UiConstants.kColorPrimary,
                          height: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 5.w),
                Image.asset(Paths.presentGifPath, width: 50.w, height: 50.w),
                Text(
                  state != null
                      ? Utils.formatTime(state)
                      : LocaleKeys.kTextClaimGift.tr(),
                  style: UiConstants.kTextStyleText10
                      .copyWith(color: UiConstants.kColorPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
