import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';
import 'package:helps_flutter/ui/components/helps_support_button.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/settings_screen/components/settings_group_view.dart';
import 'package:helps_flutter/ui/features/settings_screen/cubit/settings_screen_cubit.dart';
import 'package:helps_flutter/ui/features/settings_screen/data/settings_data.dart';
import 'package:helps_flutter/ui/features/settings_screen/model/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      body: BlocProvider(
        create: (context) => SettingsScreenCubit(),
        child: BlocBuilder<SettingsScreenCubit, SettingsScreenState>(
          builder: (context, state) {
            if (state is SettingsScreenLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  padding: UiConstants.appPaddingHorizontal +
                      UiConstants.appPaddingVertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 32.h, bottom: 10.h, left: 33.w, right: 33.w),
                          decoration: BoxDecoration(
                            color: UiConstants.kColorBase04.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(
                                Paths.mapPlaceholderPath,
                                fit: BoxFit.fitHeight,
                              ).blurred(
                                colorOpacity: 0.0,
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(20)),
                                blur: 2,
                              ),
                              Column(
                                children: [
                                  ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      List<SettingsModel> settingsList =
                                          state.settingsList[index];

                                      return SettingsGroupView(
                                          settingsList: settingsList);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 30.h,
                                    ),
                                    itemCount: SettingsData.settingsData.length,
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  const HelpsSupportButton(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return HelpsLoadingIndicator();
          },
        ),
      ),
    );
  }
}
