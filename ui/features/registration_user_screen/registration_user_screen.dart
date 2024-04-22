import 'package:blur/blur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/user_model.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/helps_text_field_with_text.dart';
import 'package:helps_flutter/ui/components/helps_support_button.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/registration_user_screen/controller/registration_user_screen_controller.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';

class RegistrationUserScreen extends StatefulWidget {
  const RegistrationUserScreen({super.key});

  @override
  State<RegistrationUserScreen> createState() => _RegistrationUserScreenState();
}

class _RegistrationUserScreenState extends State<RegistrationUserScreen> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _secondNameController = TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController(text: '+7 ');
  final ruFormatter = RuPhoneInputFormatter(initialText: '+7 ');

  final TextEditingController _numberLicenseController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _phoneController.dispose();
    _numberLicenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      isNeedAppBar: false,
      body: Form(
        key: formKey,
        child: ListView(
          padding:
              UiConstants.appPaddingHorizontal + UiConstants.appPaddingVertical,
          physics: const BouncingScrollPhysics(),
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
                              LocaleKeys.kTextRegistration.tr(),
                              style: UiConstants.kTextStyleText2
                                  .copyWith(color: UiConstants.kColorPrimary),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _firstNameController,
                              hintText: LocaleKeys.kTextFirstName.tr(),
                              validator: (value) => Utils.validate(value),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _secondNameController,
                              hintText: LocaleKeys.kTextSecondName.tr(),
                              validator: (value) => Utils.validate(value),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _phoneController,
                              inputFormatters: [ruFormatter],
                              hintText: LocaleKeys.kTextPhone.tr(),
                              validator: (value) =>
                                  Utils().validatePhone(value),
                              regExp: Utils.phoneRegexp,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              labelFloating: LocaleKeys.kTextPhone.tr(),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _numberLicenseController,
                              hintText:
                                  LocaleKeys.kTextNumberLicenseDriver.tr(),
                              validator: (value) =>
                                  Utils.validateNumberLicense(value),
                              regExp: Utils.numberLicenseRegexp,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            HelpsButton(
                              onTap: () => onNextButtonTap(),
                              text: LocaleKeys.kTextNext.tr(),
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
            ),
          ],
        ),
      ),
    );
  }

  Future onNextButtonTap() async {
    if (formKey.currentState!.validate()) {
      // опускаем клавиатуру
      FocusManager.instance.primaryFocus?.unfocus();
      UserModel userModel = UserModel(
          name: _firstNameController.text,
          surname: _secondNameController.text,
          phone: Utils.normalizePhoneNumber(_phoneController.text),
          driverLicenseNumber: _numberLicenseController.text);
      bool isSuccess = await RegistrationUserScreenController.putUserData(
          context, userModel);
      if (isSuccess) {
        Navigator.pushNamed(
          context,
          Routes.carRegistrationScreen,
        );
      }
    }
  }
}
