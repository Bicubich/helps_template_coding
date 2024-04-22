import 'package:blur/blur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_support_button.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/components/privacy_policy_item.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/cubit/privacy_policy_screen_cubit.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/model/privacy_policy_model.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      isNeedAppBar: false,
      body: BlocProvider(
        create: (context) => PrivacyPolicyScreenCubit(context),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                LocaleKeys.kTextAppTitle.tr(),
                style: UiConstants.kTextStyleText1
                    .copyWith(color: UiConstants.kColorBase02),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 32.h, bottom: 10.h, left: 15.w, right: 15.w),
                margin: UiConstants.appPaddingHorizontal +
                    UiConstants.appPaddingVertical,
                height: 360.h,
                decoration: BoxDecoration(
                  color: UiConstants.kColorBase04.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      Paths.mapPlaceholderPath,
                      fit: BoxFit.fill,
                    ).blurred(
                      colorOpacity: 0.0,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(20)),
                      blur: 2,
                    ),
                    Column(
                      children: [
                        Text(
                          LocaleKeys.kTextUserAgreementAndPrivacyPolicy.tr(),
                          style: UiConstants.kTextStyleText9.copyWith(
                            color: UiConstants.kColorPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        BlocBuilder<PrivacyPolicyScreenCubit,
                                PrivacyPolicyScreenState>(
                            builder:
                                (privacyPolicyContext, privacyPolicyState) {
                          return ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                PrivacyPolicyModel privacyPolicy =
                                    (privacyPolicyState)
                                        .privacyPolicyList[index];
                                return PrivacyPolicyItem(
                                  privacyPolicyModel: privacyPolicy,
                                  onTapCheckbox: () => onRequestCheckBoxTap(
                                      privacyPolicyContext, index, context),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15.h,
                                  ),
                              itemCount: (privacyPolicyState
                                      as PrivacyPolicyScreenInitial)
                                  .privacyPolicyList
                                  .length);
                        }),
                        const Spacer(),
                        const HelpsSupportButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future onRequestCheckBoxTap(BuildContext privacyPolicyContext,
      int checkBoxIndex, BuildContext context) async {
    await privacyPolicyContext
        .read<PrivacyPolicyScreenCubit>()
        .onCheckBoxTap(checkBoxIndex, context);
  }
}
