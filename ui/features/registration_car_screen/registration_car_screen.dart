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
import 'package:helps_flutter/ui/features/registration_car_screen/controller/registration_car_screen_controller.dart';

class RegistrationCarScreen extends StatefulWidget {
  const RegistrationCarScreen({super.key});

  @override
  State<RegistrationCarScreen> createState() => _RegistrationCarScreenState();
}

class _RegistrationCarScreenState extends State<RegistrationCarScreen> {
  final TextEditingController _brandCarController = TextEditingController();

  final TextEditingController _modelCarController = TextEditingController();

  final TextEditingController _carRegNumberController = TextEditingController();

  final TextEditingController _colorController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _brandCarController.dispose();
    _modelCarController.dispose();
    _carRegNumberController.dispose();
    _colorController.dispose();
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
                              controller: _brandCarController,
                              hintText: LocaleKeys.kTextCarBrand.tr(),
                              validator: (value) => Utils.validate(value),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _modelCarController,
                              hintText: LocaleKeys.kTextCarModel.tr(),
                              validator: (value) => Utils.validate(value),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _carRegNumberController,
                              hintText:
                                  LocaleKeys.kTextCarRegistrationNumber.tr(),
                              validator: (value) =>
                                  Utils.validateCarNumber(value),
                              regExp: Utils.carNumberRegexp,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _colorController,
                              hintText: LocaleKeys.kTextColor.tr(),
                              validator: (value) => Utils.validate(value),
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            HelpsButton(
                              onTap: () => onCompleteButtonTap(),
                              text: LocaleKeys.kTextComplete.tr(),
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

  Future onCompleteButtonTap() async {
    if (formKey.currentState!.validate()) {
      // опускаем клавиатуру
      FocusManager.instance.primaryFocus?.unfocus();
      UserModel userModel = UserModel(
          carBrand: _brandCarController.text,
          carModel: _modelCarController.text,
          carColor: _colorController.text,
          licensePlate: _carRegNumberController.text + "RUS");
      bool isSuccess =
          await RegistrationCarScreenController.putUserData(context, userModel);
      if (isSuccess) {
        Navigator.popAndPushNamed(
          context,
          Routes.mapsScreen,
        );
      }
    }
  }
}
