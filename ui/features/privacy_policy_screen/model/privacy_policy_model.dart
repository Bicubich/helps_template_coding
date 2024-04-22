class PrivacyPolicyModel {
  PrivacyPolicyModel(this.text,
      {this.isCheckboxPressed = false,
      this.isAdditionalConfirmAgree,
      this.onTapCheckbox,
      this.clickText,
      this.onClickText});

  final String text;
  bool isCheckboxPressed;
  bool? isAdditionalConfirmAgree;
  final Function? onTapCheckbox;
  final String? clickText;
  final Function? onClickText;
}
