import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/shared_preferences_helper.dart';
import 'package:helps_flutter/system/shared_preferences_keys.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_alert_dialog.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/data/privacy_policy_data.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/model/privacy_policy_model.dart';

part 'privacy_policy_screen_state.dart';

class PrivacyPolicyScreenCubit extends Cubit<PrivacyPolicyScreenState> {
  final BuildContext bContext;
  PrivacyPolicyScreenCubit(this.bContext)
      : super(
          PrivacyPolicyScreenInitial(
            privacyPolicyList: [
              ...PrivacyPolicyData.privacyPolicyData(bContext)
            ],
          ),
        ) {
    privacyPolicyList = PrivacyPolicyData.privacyPolicyData(bContext);
  }

  late List<PrivacyPolicyModel> privacyPolicyList;

  Future isAllCheckBoxPressed(BuildContext context) async {
    bool isAllCheckBoxPressed =
        privacyPolicyList.every((element) => element.isCheckboxPressed);
    if (isAllCheckBoxPressed) {
      await SharedPreferencesHelper.setBool(
          SharedPreferencesKeys.isAgreePrivacyPolicy, true);
      Utils.pushToInitialScreen(context);
    }
  }

  Future onCheckBoxTap(int checkBoxIndex, BuildContext context) async {
    PrivacyPolicyModel privacyPolicyItem = privacyPolicyList[checkBoxIndex];
    if (privacyPolicyItem.isAdditionalConfirmAgree == false) {
      final String htmlString =
          await rootBundle.loadString(Paths.privacyPolicyPath);

      _showDialogAgree(privacyPolicyItem, htmlString);
    } else {
      _update(privacyPolicyItem, context);
    }
  }

  _showDialogAgree(PrivacyPolicyModel privacyPolicyItem, String htmlText) {
    showDialog(
      context: bContext,
      builder: (BuildContext context) {
        return HelpsAlertDialog(
          content: Utils.getStylingHtmlText(context, htmlText),
          firstButtonText: LocaleKeys.kTextDisagree.tr(),
          secondButtonText: LocaleKeys.kTextAgree.tr(),
          onTapFirstButton: () => Navigator.pop(context),
          onTapSecondButton: () {
            privacyPolicyItem.isAdditionalConfirmAgree = true;
            _update(privacyPolicyItem, bContext);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future _update(
      PrivacyPolicyModel privacyPolicyItem, BuildContext context) async {
    emit(
      PrivacyPolicyScreenUpdating(),
    );
    privacyPolicyItem.isCheckboxPressed = !privacyPolicyItem.isCheckboxPressed;
    if (!privacyPolicyItem.isCheckboxPressed &&
        privacyPolicyItem.isAdditionalConfirmAgree == true) {
      privacyPolicyItem.isAdditionalConfirmAgree = false;
    }
    emit(
      PrivacyPolicyScreenInitial(privacyPolicyList: privacyPolicyList),
    );
    isAllCheckBoxPressed(context);
  }
}
