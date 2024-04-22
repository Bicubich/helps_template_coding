import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:helps_flutter/constants/external_links.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/features/privacy_policy_screen/model/privacy_policy_model.dart';

class PrivacyPolicyData {
  final BuildContext context;

  PrivacyPolicyData({required this.context});

  static List<PrivacyPolicyModel> privacyPolicyData(BuildContext context) {
    return [
      PrivacyPolicyModel(
        LocaleKeys.kTextIAgreePrivacyPolicy.tr(),
        clickText: ExternalLinks.privacyPolicyLink,
        isAdditionalConfirmAgree: false,
        onClickText: () =>
            Utils.launchURL(context, ExternalLinks.privacyPolicyLink),
      ),
      PrivacyPolicyModel(
        LocaleKeys.kTextAllowMyLocationToBeUsed.tr(),
      ),
    ];
  }
}
