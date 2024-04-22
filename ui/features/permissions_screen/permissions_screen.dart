import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/permissions_screen/cubit/permissions_screen_cubit.dart';
import 'package:helps_flutter/ui/features/permissions_screen/cubit/permissions_screen_state.dart';
import 'package:helps_flutter/ui/features/permissions_screen/model/permission_model.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
        isNeedAppBar: false,
        body: BlocProvider(
          create: (context) => PermissionsScreenCubit(context),
          child: BlocBuilder<PermissionsScreenCubit, PermissionsScreenState>(
            builder: (permissionScreenContext, permissionScreenState) {
              return ListView(
                padding: UiConstants.appPaddingHorizontal +
                    UiConstants.appPaddingVertical,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys.kTextAppTitle.tr(),
                          style: UiConstants.kTextStyleText1
                              .copyWith(color: UiConstants.kColorBase02),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          LocaleKeys.kTextPermissionsHelps.tr(),
                          textAlign: TextAlign.center,
                          style: UiConstants.kTextStyleText2.copyWith(
                            color: UiConstants.kColorBase02,
                          ),
                        ),
                        Text(
                          LocaleKeys.kTextPermissionsHelps2.tr(),
                          textAlign: TextAlign.center,
                          style: UiConstants.kTextStyleText11.copyWith(
                            color: UiConstants.kColorBase02.withOpacity(0.5),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            PermissionModel permission = permissionScreenContext
                                .read<PermissionsScreenCubit>()
                                .necessaryPermissions[index];
                            print(permission.name);
                            return Text(
                              '${index + 1}. ${permission.name}',
                              style: UiConstants.kTextStyleText3.copyWith(
                                color: permission.isGranted
                                    ? UiConstants.kColorSuccess
                                    : UiConstants.kColorError,
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5.h,
                          ),
                          itemCount: permissionScreenContext
                              .read<PermissionsScreenCubit>()
                              .necessaryPermissions
                              .length,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        HelpsButton(
                          onTap: () async => await onRequestPermissionTap(
                              permissionScreenContext, context),
                          text: LocaleKeys.kTextRequestPermissions.tr(),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  Future onRequestPermissionTap(
      BuildContext permissionScreenContext, BuildContext context) async {
    await permissionScreenContext
        .read<PermissionsScreenCubit>()
        .requestPermissions(context);
    bool isAllPermissionsGranted = permissionScreenContext
        .read<PermissionsScreenCubit>()
        .isAllPermissionsGranted();
    if (isAllPermissionsGranted) {
      Utils.pushToInitialScreen(context);
    }
  }
}
