import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/system/sqllite_manager.dart';
import 'package:helps_flutter/ui/components/helps_switch_with_text/helps_switch_with_text.dart';
import 'package:helps_flutter/ui/components/helps_switch_with_text/helps_switch_with_text_cubit.dart';
import 'package:helps_flutter/ui/features/settings_screen/model/settings_model.dart';

class SettingsGroupView extends StatelessWidget {
  const SettingsGroupView({super.key, required this.settingsList});

  final List<SettingsModel> settingsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          settingsList.first.groupName,
          textAlign: TextAlign.center,
          style: UiConstants.kTextStyleText3.copyWith(
              color: UiConstants.kColorPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0),
        ),
        SizedBox(
          height: 5.h,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            SettingsModel settingsItem = settingsList[index];
            return BlocProvider(
              create: (context) =>
                  HelpsSwitchWithTextCubit(settingsItem.switchStatus),
              child: BlocBuilder<HelpsSwitchWithTextCubit, bool>(
                builder: (context, switchState) {
                  return HelpsSwitchWithText(
                      text: settingsItem.name,
                      isEnabled: switchState,
                      onChanged: (bool isSwitchEnabled) async {
                        await SqlLiteManager.initializeDatabase();
                        SqlLiteManager.insertSetting(
                            settingsItem.sharedPreferencesKey, isSwitchEnabled);
                        context
                            .read<HelpsSwitchWithTextCubit>()
                            .changeSwitch(isSwitchEnabled);
                        await SqlLiteManager.closeDatabase();
                      });
                },
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 5.h,
          ),
          itemCount: settingsList.length,
        ),
      ],
    );
  }
}
