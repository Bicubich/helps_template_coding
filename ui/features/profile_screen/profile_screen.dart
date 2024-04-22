import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/api/model/user_model.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/components/helps_fetch_data_error_widget.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/helps_text_field_with_text.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:helps_flutter/ui/features/profile_screen/controller/profile_screen_controller.dart';
import 'package:helps_flutter/ui/features/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ruFormatter = RuPhoneInputFormatter(initialText: '+7 ');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      body: BlocProvider(
        create: (context) => ProfileScreenCubit(),
        child: BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
          builder: (cubitContext, state) {
            if (state is ProfileScreenError) {
              return HelpsFetchDataErrorWidget();
            }
            if (state is ProfileScreenLoaded) {
              return Form(
                key: formKey,
                child: ListView(
                  padding: UiConstants.appPaddingHorizontal +
                      UiConstants.appPaddingVertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Column(
                            children: [
                              Text(
                                LocaleKeys.kTextProfile.tr(),
                                style: UiConstants.kTextStyleText2
                                    .copyWith(color: UiConstants.kColorPrimary),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextFirstName.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .firstNameController,
                                hintText: LocaleKeys.kTextYourFirstName.tr(),
                                validator: (value) =>
                                    Utils.validateTextOnly(value),
                                regExp: Utils.textOnlyRegexp,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextSecondName.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .secondNameController,
                                hintText: LocaleKeys.kTextYourSecondName.tr(),
                                validator: (value) =>
                                    Utils.validateTextOnly(value),
                                regExp: Utils.textOnlyRegexp,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextPhone.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .phoneController,
                                inputFormatters: [ruFormatter],
                                hintText: LocaleKeys.kTextPhoneTemplate.tr(),
                                validator: (value) =>
                                    Utils().validatePhone(value),
                                regExp: Utils.phoneRegexp,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                labelFloating: LocaleKeys.kTextPhone.tr(),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextNumberLicenseDriver.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .numberLicenseController,
                                hintText: LocaleKeys
                                    .kTextNumberLicenseDriverTemplate
                                    .tr(),
                                validator: (value) =>
                                    Utils.validateNumberLicense(value),
                                regExp: Utils.numberLicenseRegexp,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextCarBrand.tr().tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .brandCarController,
                                hintText: LocaleKeys.kTextCarBrandTemplate.tr(),
                                validator: (value) => Utils.validate(value),
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextCarModel.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .modelCarController,
                                hintText: LocaleKeys.kTextCarModelTemplate.tr(),
                                validator: (value) => Utils.validate(value),
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label:
                                    LocaleKeys.kTextCarRegistrationNumber.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .carRegNumberController,
                                hintText: LocaleKeys
                                    .kTextCarRegistrationNumberTemplate
                                    .tr(),
                                validator: (value) =>
                                    Utils.validateCarNumber(value),
                                regExp: Utils.carNumberRegexp,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              HelpsTextFieldWithText(
                                label: LocaleKeys.kTextColor.tr(),
                                controller: cubitContext
                                    .read<ProfileScreenCubit>()
                                    .colorController,
                                hintText: LocaleKeys.kTextColor.tr(),
                                validator: (value) => Utils.validate(value),
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              HelpsButton(
                                onTap: () => onCompleteButtonTap(cubitContext),
                                text: LocaleKeys.kTextSaveChanges.tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Future onCompleteButtonTap(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // опускаем клавиатуру
      FocusManager.instance.primaryFocus?.unfocus();
      UserModel userModel = UserModel(
          name: context.read<ProfileScreenCubit>().firstNameController.text,
          surname: context.read<ProfileScreenCubit>().secondNameController.text,
          phone: Utils.normalizePhoneNumber(
              context.read<ProfileScreenCubit>().phoneController.text),
          driverLicenseNumber:
              context.read<ProfileScreenCubit>().numberLicenseController.text,
          carBrand: context.read<ProfileScreenCubit>().brandCarController.text,
          carModel: context.read<ProfileScreenCubit>().modelCarController.text,
          carColor: context.read<ProfileScreenCubit>().colorController.text,
          licensePlate: context
                      .read<ProfileScreenCubit>()
                      .carRegNumberController
                      .text
                      .length ==
                  9
              ? context.read<ProfileScreenCubit>().carRegNumberController.text +
                  "RUS"
              : context.read<ProfileScreenCubit>().carRegNumberController.text);
      bool isSuccess =
          await ProfileScreenController.putUserData(context, userModel);
      if (isSuccess) {
        Navigator.pop(context);
      }
    }
  }
}
