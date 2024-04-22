import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helps_flutter/constants/ui_constants.dart';
import 'package:helps_flutter/system/routes.dart';
import 'package:helps_flutter/translations/locale_keys.g.dart';
import 'package:helps_flutter/ui/components/helps_button.dart';
import 'package:helps_flutter/ui/components/helps_dropdown_field_with_search.dart';
import 'package:helps_flutter/ui/components/helps_loading_indicator.dart';
import 'package:helps_flutter/ui/components/notification/notification_cubit.dart';
import 'package:helps_flutter/ui/features/announcement_screen/announcement_select_city/cubit/announcement_select_city_cubit.dart';
import 'package:helps_flutter/ui/features/helps_template/helps_template.dart';

class AnnouncementSelectCityScreen extends StatefulWidget {
  const AnnouncementSelectCityScreen({super.key});

  @override
  State<AnnouncementSelectCityScreen> createState() =>
      _AnnouncementSelectCityScreenState();
}

class _AnnouncementSelectCityScreenState
    extends State<AnnouncementSelectCityScreen> {
  final TextEditingController _cityController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return HelpsTemplate(
      body: Form(
        key: formKey,
        child: BlocProvider(
          create: (context) => AnnouncementSelectCityCubit(),
          child: BlocBuilder<AnnouncementSelectCityCubit, List<String>>(
            builder: (context, state) {
              if (state.isNotEmpty) {
                return Padding(
                  padding: UiConstants.appPaddingHorizontal,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Expanded(
                        child: HelpsDropdownFieldWithSearch(
                          hintText: LocaleKeys.kTextPlaceHolder.tr(),
                          options: state,
                          controller: _cityController,
                          onTap: () =>
                              onTapCity(context, _cityController.text, state),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      HelpsButton(
                        onTap: () =>
                            onTapCity(context, _cityController.text, state),
                        text: LocaleKeys.kTextSelectCity.tr(),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                );
              }
              return HelpsLoadingIndicator();
            },
          ),
        ),
      ),
    );
  }

  onTapCity(BuildContext context, String inputCity, List<String> cities) {
    // опускаем клавиатуру
    FocusManager.instance.primaryFocus?.unfocus();
    if (!cities.contains(inputCity.trim())) {
      context
          .read<NotificationCubit>()
          .showErrorNotification(context, 'Такого города мы не знаем');
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.announcementViewScreen,
        arguments: {'myAnnouncement': false, 'city': inputCity},
      );
    }
  }
}
