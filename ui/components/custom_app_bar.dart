import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        LocaleKeys.kTextAppTitle.tr(),
        style: UiConstants.kTextStyleText13
            .copyWith(color: UiConstants.kColorBase02),
      ),
      backgroundColor: UiConstants.kColorBase01.withOpacity(.1),
      foregroundColor: UiConstants.kColorBase02,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
