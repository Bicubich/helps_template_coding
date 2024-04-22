import 'package:blur/blur.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/paths.dart';
import 'package:helps_flutter/constants/size_utils.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/constants/utils.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/components/helps_dropdown_field.dart';
import 'package:helps_flutter/ui/components/helps_switch_with_text/helps_switch_with_text.dart';
import 'package:helps_flutter/ui/components/helps_switch_with_text/helps_switch_with_text_cubit.dart';
import 'package:helps_flutter/ui/components/helps_text_field_with_text/helps_text_field_with_text.dart';
import 'package:helps_flutter/ui/components/helps_support_button.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/data/announcement_data.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_view/model/announcement_model.dart';
import 'package:helps_flutter/ui/features/announcement_screen/controller/announcement_controller.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';
import 'package:ru_phone_formatter/ru_phone_formatter.dart';

class AnnouncementCreateScreen extends StatefulWidget {
  const AnnouncementCreateScreen({super.key});

  @override
  State<AnnouncementCreateScreen> createState() =>
      _AnnouncementCreateScreenState();
}

class _AnnouncementCreateScreenState extends State<AnnouncementCreateScreen> {
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _subwayController = TextEditingController();

  final TextEditingController _brandCarController = TextEditingController();

  final TextEditingController _modelCarController = TextEditingController();

  final TextEditingController _yearCarController = TextEditingController();

  final TextEditingController _classCarController = TextEditingController();

  final TextEditingController _rentCarController = TextEditingController();

  final TextEditingController _depositCarController = TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController(text: '+7 ');
  final ruFormatter = RuPhoneInputFormatter(initialText: '+7 ');

  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cityController.dispose();
    _subwayController.dispose();
    _phoneController.dispose();
    _brandCarController.dispose();
    _modelCarController.dispose();
    _yearCarController.dispose();
    _rentCarController.dispose();
    _depositCarController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
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
                          fit: BoxFit.fill,
                        ).blurred(
                          colorOpacity: 0.0,
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(20)),
                          blur: 2,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                LocaleKeys.kTextAdPlacement.tr(),
                                style: UiConstants.kTextStyleText2
                                    .copyWith(color: UiConstants.kColorPrimary),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _cityController,
                              hintText: LocaleKeys.kTextCity.tr(),
                              validator: (value) => Utils.validate(value),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 5.h),
                            BlocProvider(
                              create: (context) =>
                                  HelpsSwitchWithTextCubit(true),
                              child:
                                  BlocBuilder<HelpsSwitchWithTextCubit, bool>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: getMarginOrPadding(
                                            bottom: 5, left: 10),
                                        child: HelpsSwitchWithText(
                                          text: LocaleKeys.kTextIsMetroAvailable
                                              .tr(),
                                          textStyle:
                                              UiConstants.kTextStyleText3,
                                          isEnabled: state,
                                          onChanged: (isSwitchEnabled) => context
                                              .read<HelpsSwitchWithTextCubit>()
                                              .changeSwitch(isSwitchEnabled),
                                        ),
                                      ),
                                      state
                                          ? Padding(
                                              padding: getMarginOrPadding(
                                                  bottom: state ? 25 : 0),
                                              child: HelpsTextFieldWithText(
                                                controller: _subwayController,
                                                hintText: LocaleKeys
                                                    .kTextMetroStation
                                                    .tr(),
                                                validator: (value) =>
                                                    Utils.validate(value),
                                                textInputAction:
                                                    TextInputAction.next,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                },
                              ),
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
                              controller: _yearCarController,
                              hintText: LocaleKeys.kTextYear.tr(),
                              validator: (value) =>
                                  Utils.validateYearCar(value),
                              regExp: Utils.digitsOnlyRegexp,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsDropdownField(
                              options: AnnouncementData.carClassList,
                              controller: _classCarController,
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            HelpsTextFieldWithText(
                              controller: _rentCarController,
                              hintText: LocaleKeys.kTextCostPerMonth.tr(),
                              validator: (value) =>
                                  Utils.validateRentPrice(value),
                              regExp: Utils.digitsOnlyRegexp,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 5.h),
                            BlocProvider(
                              create: (context) =>
                                  HelpsSwitchWithTextCubit(true),
                              child:
                                  BlocBuilder<HelpsSwitchWithTextCubit, bool>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: getMarginOrPadding(
                                            bottom: 5, left: 10),
                                        child: HelpsSwitchWithText(
                                          text: LocaleKeys
                                              .kTextIsDepositAvailable
                                              .tr(),
                                          textStyle:
                                              UiConstants.kTextStyleText3,
                                          isEnabled: state,
                                          onChanged: (isSwitchEnabled) => context
                                              .read<HelpsSwitchWithTextCubit>()
                                              .changeSwitch(isSwitchEnabled),
                                        ),
                                      ),
                                      state
                                          ? Padding(
                                              padding: getMarginOrPadding(
                                                  bottom: state ? 25 : 0),
                                              child: HelpsTextFieldWithText(
                                                controller:
                                                    _depositCarController,
                                                hintText: LocaleKeys
                                                    .kTextDeposit
                                                    .tr(),
                                                validator: (value) =>
                                                    Utils.validateRentPrice(
                                                        value),
                                                regExp: Utils.digitsOnlyRegexp,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                },
                              ),
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
                              controller: _descriptionController,
                              hintText:
                                  LocaleKeys.kTextYouCanLeaveDescription.tr(),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              minLines: 3,
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            HelpsButton(
                              onTap: () => onNextButtonTap(),
                              text: LocaleKeys.kTextPlace.tr(),
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

      String depositString = _rentCarController.text;
      int deposit = depositString.isEmpty ? 0 : int.parse(depositString);

      AnnouncementModel announcementModel = AnnouncementModel(
          carBrand: _brandCarController.text,
          carModel: _modelCarController.text,
          carClass: _classCarController.text,
          city: _cityController.text,
          manufactoryYear: _yearCarController.text,
          description: _descriptionController.text,
          phone: Utils.normalizePhoneNumber(_phoneController.text),
          pledge: deposit,
          rentPrice: int.parse(_rentCarController.text),
          subway: _subwayController.text,
          telegram: '',
          whatsapp: Utils.normalizePhoneNumber(_phoneController.text));
      AnnouncementController.createAnnouncement(context, announcementModel);
    }
  }
}
